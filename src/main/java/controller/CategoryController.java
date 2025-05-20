package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

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
        model.addAttribute("active", "categoryMgm"); // Đánh dấu menu đang active
        // Lấy thông tin người dùng đang đăng nhập từ session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Thiết lập thời gian timeout cho session: 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        try {
            List<Category> categories = daoCategory.getAllCategories();
            model.addAttribute("categories", categories);
            return "category_list";
        } catch (Exception e) {
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
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        model.addAttribute("category", new Category()); // Khởi tạo đối tượng rỗng cho form
        return "category_create_form";
    }

    @PostMapping("/add")
    public String addCategory(@ModelAttribute Category category, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        model.addAttribute("active", "categoryMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        try {
            if (category.getTenDM() == null || category.getTenDM().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Tên danh mục không được để trống!");
                return "redirect:/category/add";
            }

            if (daoCategory.addCategory(category)) {
                redirectAttributes.addFlashAttribute("success", "Thêm danh mục thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể thêm danh mục!");
            }
            return "redirect:/category/view";
        } catch (Exception e) {
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
    public String updateCategory(@PathVariable int maDM, HttpSession session, Model model, @ModelAttribute Category category, RedirectAttributes redirectAttributes) {
        model.addAttribute("active", "categoryMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        try {
            if (category.getTenDM() == null || category.getTenDM().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Tên danh mục không được để trống!");
                return "redirect:/category/edit/" + maDM;
            }

            category.setMaDM(maDM);
            if (daoCategory.updateCategory(category)) {
                redirectAttributes.addFlashAttribute("success", "Cập nhật danh mục thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể cập nhật danh mục!");
            }
            return "redirect:/category/view";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/category/edit/" + maDM;
        }
    }

    @GetMapping("/delete/{maDM}")
    public String deleteCategory(@PathVariable int maDM, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        model.addAttribute("active", "categoryMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
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
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "redirect:/category/view";
    }
}
