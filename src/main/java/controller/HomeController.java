// Import các thư viện cần thiết
package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.ServletContext;
import java.io.File;
import java.util.List;
import beans.Product;
import beans.Category;
import dao.DaoProduct;
import dao.DaoCategory;
import javax.servlet.http.HttpSession;
import beans.User;

@Controller
public class HomeController {

    @Autowired
    private DaoProduct daoProduct;

    @Autowired
    private DaoCategory daoCategory;

    @Autowired
    ServletContext servletContext;

    private void checkAndSetSession(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60); // 30 phút
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
    }

    @RequestMapping(value = {"", "/", "/home"})
    public String home(Model model, HttpSession session) {
        checkAndSetSession(session, model);

        List<Product> products = daoProduct.getProducts();
        List<Category> categories = daoCategory.getAllCategories();

        for (Product product : products) {
            Category category = daoCategory.getCategoryById(product.getMaDM());
            if (category != null) {
                product.setTenDM(category.getTenDM());
            }
        }

        model.addAttribute("products", products);
        model.addAttribute("categories", categories);

        return "home";
    }

    @GetMapping("/product_create_form")
    public String showForm(Model model, HttpSession session) {
        checkAndSetSession(session, model);
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        model.addAttribute("product", new Product());
        model.addAttribute("categories", daoCategory.getAllCategories());
        return "product_create_form";
    }

    @PostMapping(value="/save")
    public String save(@ModelAttribute("product") Product prd, 
                      @RequestParam("imageFile") MultipartFile file,
                      BindingResult result,
                      Model model,
                      HttpSession session) {
        checkAndSetSession(session, model);
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        try {
            if (prd.getDonGia() != null && prd.getDonGia().doubleValue() > 999999) {
                model.addAttribute("error", "Giá sản phẩm không thể vượt quá 999,999");
                model.addAttribute("categories", daoCategory.getAllCategories());
                return "product_create_form";
            }

            if (!file.isEmpty()) {
                String uploadPath = servletContext.getRealPath("/resources/images/");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String fileName = file.getOriginalFilename();
                File uploadedFile = new File(uploadPath + File.separator + fileName);
                file.transferTo(uploadedFile);
                prd.setHinhAnh(fileName);
            }

            daoProduct.save(prd);
            return "redirect:/product/view";

        } catch (Exception e) {
            model.addAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            model.addAttribute("categories", daoCategory.getAllCategories());
            return "product_create_form";
        }
    }

    @RequestMapping("/product/view")
    public String viewProducts(Model model, HttpSession session) {
        checkAndSetSession(session, model);
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        List<Product> products = daoProduct.getProducts();
        for (Product product : products) {
            try {
                Category category = daoCategory.getCategoryById(product.getMaDM());
                if (category != null) {
                    product.setTenDM(category.getTenDM());
                } else {
                    product.setTenDM("Không xác định");
                }
            } catch (Exception e) {
                product.setTenDM("Lỗi");
            }
        }

        model.addAttribute("list", products);
        return "product_list";
    }

    @RequestMapping(value = "/editproduct/{idSanPham}")
    public String edit(@PathVariable int idSanPham, Model model, HttpSession session) {
        checkAndSetSession(session, model);
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        Product product = daoProduct.getProductById(idSanPham);
        model.addAttribute("product", product);
        model.addAttribute("categories", daoCategory.getAllCategories());
        return "product_edit_form";
    }

    @RequestMapping(value = "/editsave", method = RequestMethod.POST)
    public String editSave(@ModelAttribute("product") Product product,
                          @RequestParam(value = "imageFile", required = false) MultipartFile file,
                          BindingResult result,
                          Model model,
                          HttpSession session) {
        checkAndSetSession(session, model);
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        try {
            if (product.getDonGia() != null && product.getDonGia().doubleValue() > 999999) {
                model.addAttribute("error", "Giá sản phẩm không thể vượt quá 999,999");
                model.addAttribute("categories", daoCategory.getAllCategories());
                return "product_edit_form";
            }

            if (result.hasErrors()) {
                System.out.println("Có lỗi trong dữ liệu: " + result.getAllErrors());
                return "product_edit_form";
            }
            
            if (file != null && !file.isEmpty()) {
                String uploadPath = servletContext.getRealPath("/resources/images/");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String fileName = file.getOriginalFilename();
                File uploadedFile = new File(uploadPath + File.separator + fileName);
                file.transferTo(uploadedFile);
                product.setHinhAnh(fileName);
            }

            daoProduct.update(product);
            return "redirect:/product/view";

        } catch (Exception e) {
            model.addAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            model.addAttribute("categories", daoCategory.getAllCategories());
            return "product_edit_form";
        }
    }

    @RequestMapping(value = "/deleteproduct/{idSanPham}", method = RequestMethod.GET)
    public String delete(@PathVariable int idSanPham, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        daoProduct.delete(idSanPham);
        return "redirect:/product/view";
    }

    @GetMapping("/search")
    public String searchProducts(@RequestParam(required = false) String keyword,
                               @RequestParam(required = false) Integer category,
                               Model model,
                               HttpSession session) {
        checkAndSetSession(session, model);

        List<Product> searchResults = daoProduct.searchProducts(keyword, category);
        List<Category> categories = daoCategory.getAllCategories();

        for (Product product : searchResults) {
            for (Category cat : categories) {
                if (cat.getMaDM() == product.getMaDM()) {
                    product.setTenDM(cat.getTenDM());
                    break;
                }
            }
        }

        model.addAttribute("products", searchResults);
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedCategory", category);

        return "home";
    }
}
