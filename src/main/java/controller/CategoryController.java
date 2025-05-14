package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

import javax.servlet.http.HttpSession;

import beans.Category;
import beans.User;
import dao.DaoCategory;

@Controller
@RequestMapping("/category")
public class CategoryController {
    
    @Autowired
    private DaoCategory daoCategory;
    
    @GetMapping("/view")
    public String viewCategories(Model model, HttpSession session) {
    	model.addAttribute("active", "categoryMgm");
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Đặt thời gian timeout session là 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        try {
            System.out.println("Fetching all categories...");
            List<Category> categories = daoCategory.getAllCategories();
            System.out.println("Found " + categories.size() + " categories");
            model.addAttribute("categories", categories);
            return "category_list";
        } catch (Exception e) {
            System.out.println("Error in viewCategories: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Có lỗi xảy ra khi tải danh sách danh mục");
            return "category_list";
        }
    }

    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session) {
    	model.addAttribute("active", "categoryMgm");
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Đặt thời gian timeout session là 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        model.addAttribute("category", new Category());
        return "category_create_form";
    }

    @PostMapping("/add")
    public String addCategory(@ModelAttribute Category category, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
    	model.addAttribute("active", "categoryMgm");
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Đặt thời gian timeout session là 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
    	try {
            System.out.println("Adding new category: " + category.getTenDM());
            // Kiểm tra xem tên danh mục có bị trống không
            if (category.getTenDM() == null || category.getTenDM().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Tên danh mục không được để trống!");
                return "redirect:/category/add";
            }
            
            // Thực hiện thêm danh mục
            if (daoCategory.addCategory(category)) {
                System.out.println("Category added successfully");
                redirectAttributes.addFlashAttribute("success", "Thêm danh mục thành công!");
            } else {
                System.out.println("Failed to add category");
                redirectAttributes.addFlashAttribute("error", "Không thể thêm danh mục!");
            }
            return "redirect:/category/view";
        } catch (Exception e) {
            System.out.println("Error in addCategory: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/category/add";
        }
    }

    @GetMapping("/edit/{maDM}")
    public String showEditForm(@PathVariable int maDM, Model model, RedirectAttributes redirectAttributes, HttpSession session) {
    	model.addAttribute("active", "categoryMgm");
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Đặt thời gian timeout session là 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
    	Category category = daoCategory.getCategoryById(maDM);
        if (category == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy danh mục!");
            return "redirect:/category/view";
        }
        model.addAttribute("category", category);
        return "category_edit_form";
    }

    @PostMapping("/edit/{maDM}")
    public String updateCategory(@PathVariable int maDM, HttpSession session, Model model, @ModelAttribute Category category, 
                               RedirectAttributes redirectAttributes) {
    	model.addAttribute("active", "categoryMgm");
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Đặt thời gian timeout session là 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
    	try {
            // Kiểm tra xem tên danh mục có bị trống không
            if (category.getTenDM() == null || category.getTenDM().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Tên danh mục không được để trống!");
                return "redirect:/category/edit/" + maDM;
            }
            
            category.setMaDM(maDM); // Đảm bảo maDM được set đúng
            if (daoCategory.updateCategory(category)) {
                redirectAttributes.addFlashAttribute("success", "Cập nhật danh mục thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể cập nhật danh mục!");
            }
            return "redirect:/category/view";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/category/edit/" + maDM;
        }
    }

    @GetMapping("/delete/{maDM}")
    public String deleteCategory(@PathVariable int maDM, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
    	model.addAttribute("active", "categoryMgm");
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Đặt thời gian timeout session là 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
    	try {
            if (daoCategory.deleteCategory(maDM)) {
                redirectAttributes.addFlashAttribute("success", "Xóa danh mục thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể xóa danh mục!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "redirect:/category/view";
    }

    @GetMapping("/search")
    public String searchCategories(@RequestParam(required = false) String keyword, HttpSession session, Model model) {
    	model.addAttribute("active", "categoryMgm");
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Đặt thời gian timeout session là 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
    	List<Category> categories;
        if (keyword != null && !keyword.trim().isEmpty()) {
            categories = daoCategory.searchCategories(keyword);
            model.addAttribute("keyword", keyword);
        } else {
            categories = daoCategory.getAllCategories();
        }
        model.addAttribute("categories", categories);
        return "category_list";
    }
} 