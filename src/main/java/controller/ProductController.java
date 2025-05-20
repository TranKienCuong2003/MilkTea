package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import beans.Product;
import beans.Category;
import beans.ProductDetail;
import beans.User;
import dao.DaoProduct;
import dao.DaoCategory;
import dao.DaoProductDetail;

@Controller
@RequestMapping("/product")
public class ProductController {
    
    @Autowired
    private DaoProduct daoProduct;
    
    @Autowired
    private DaoCategory daoCategory;
    
    @Autowired
    private DaoProductDetail daoProductDetail;
    
    @GetMapping("/view")
    public String viewProducts(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
        	
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        
        List<Product> products = daoProduct.getProducts();
        List<Category> categories = daoCategory.getAllCategories();
        
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
        
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("active", "productMgm");
        return "product_list";
    }

    @GetMapping("/search")
    public String searchProducts(@RequestParam(required = false) String keyword,
                                 @RequestParam(required = false) Integer category,
                                 Model model, HttpSession session) {
        model.addAttribute("active", "productMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        
        List<Product> products = daoProduct.searchProducts(keyword, category);
        List<Category> categories = daoCategory.getAllCategories();
        
        for (Product product : products) {
            for (Category cat : categories) {
                if (cat.getMaDM() == product.getMaDM()) {
                    product.setTenDM(cat.getTenDM());
                    break;
                }
            }
        }
        
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedCategory", category);
        
        return "product_list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session) {
        model.addAttribute("active", "productMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        model.addAttribute("product", new Product());
        model.addAttribute("categories", daoCategory.getAllCategories());
        return "product_create_form";
    }

    @PostMapping("/add")
    public String addProduct(@ModelAttribute Product product, BindingResult result, HttpSession session, Model model) {
        model.addAttribute("active", "productMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        if (result.hasErrors()) {
            model.addAttribute("categories", daoCategory.getAllCategories());
            
            return "product_create_form";
        }
        
        daoProduct.save(product);
        return "redirect:/product/view";
    }

    @GetMapping("/edit/{maSP}")
    public String showEditForm(@PathVariable int maSP, Model model, HttpSession session) {
        model.addAttribute("active", "productMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        
        Product product = daoProduct.getProductById(maSP);
        if (product == null) {
            
            return "redirect:/product/view";
        }
        
        model.addAttribute("product", product);
        model.addAttribute("categories", daoCategory.getAllCategories());
        return "product_edit_form";
    }

    @PostMapping("/edit/{maSP}")
    public String updateProduct(@PathVariable int maSP, @ModelAttribute Product product, 
                                BindingResult result, Model model, HttpSession session) {
        model.addAttribute("active", "productMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        if (result.hasErrors()) {
            model.addAttribute("categories", daoCategory.getAllCategories());
            return "product_edit_form";
        }
        
        daoProduct.update(product);
        return "redirect:/product/view";
    }

    @GetMapping("/delete/{maSP}")
    public String deleteProduct(@PathVariable int maSP, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        model.addAttribute("active", "productMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        
        try {
            int result = daoProduct.delete(maSP);
            if (result > 0) {
                redirectAttributes.addFlashAttribute("success", "Xóa sản phẩm thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể xóa sản phẩm!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "redirect:/product/view";
    }

    @GetMapping("/detail/{maSP}")
    public String viewDetail(@PathVariable int maSP, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        
        Product product = daoProduct.getProductById(maSP);
        if (product == null) {
            return "redirect:/product/view";
        }
        
        Category category = daoCategory.getCategoryById(product.getMaDM());
        if (category != null) {
            product.setTenDM(category.getTenDM());
        }
        
        ProductDetail detail = daoProductDetail.getProductDetailByProductId(maSP);
        if (detail == null) {
            detail = new ProductDetail();
            detail.setMaSP(maSP);
        }
        
        List<Product> allProducts = daoProduct.getProducts();
        List<Product> relatedProducts = new ArrayList<>();
        if (allProducts != null) {
            for (Product p : allProducts) {
                if (p.getMaDM() == product.getMaDM() && p.getMaSP() != product.getMaSP()) {
                    Category cat = daoCategory.getCategoryById(p.getMaDM());
                    if (cat != null) {
                        p.setTenDM(cat.getTenDM());
                    }
                    relatedProducts.add(p);
                    if (relatedProducts.size() >= 4) break;
                }
            }
        }
        
        model.addAttribute("product", product);
        model.addAttribute("detail", detail);
        model.addAttribute("relatedProducts", relatedProducts);
        return "product_detail";
    }

    @PostMapping("/detail/save")
    public String saveDetail(@ModelAttribute ProductDetail detail, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        model.addAttribute("active", "productMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        try {
            boolean success;
            if (daoProductDetail.getProductDetailByProductId(detail.getMaSP()) == null) {
                success = daoProductDetail.save(detail);
            } else {
                success = daoProductDetail.update(detail);
            }
            
            if (success) {
                redirectAttributes.addFlashAttribute("success", "Lưu chi tiết sản phẩm thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể lưu chi tiết sản phẩm!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "redirect:/product/detail/" + detail.getMaSP();
    }

    @GetMapping("/detail/delete/{maSP}")
    public String deleteDetail(@PathVariable int maSP, RedirectAttributes redirectAttributes, Model model) {
        model.addAttribute("active", "productMgm");
        try {
            if (daoProductDetail.delete(maSP)) {
                redirectAttributes.addFlashAttribute("success", "Xóa chi tiết sản phẩm thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể xóa chi tiết sản phẩm!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xóa chi tiết: " + e.getMessage());
        }
        return "redirect:/product/detail/" + maSP;
    }
}
