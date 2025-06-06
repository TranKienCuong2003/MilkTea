package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;
import beans.User;
import dao.DaoUser;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    @Autowired
    private DaoUser daoUser;

    @GetMapping
    public String showProfile(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);

            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        if (loggedInUser == null) {
            return "redirect:/login";
        }

        model.addAttribute("user", loggedInUser);

        return "profile";
    }


    @PostMapping("/update")
    public String updateProfile(@ModelAttribute User updatedUser, 
                                HttpSession session,
                                RedirectAttributes redirectAttributes, 
                                Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);

            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        try {
            User currentUser = (User) session.getAttribute("loggedInUser");
            if (currentUser == null) {
                return "redirect:/login";
            }

            currentUser.setHoTen(updatedUser.getHoTen());
            currentUser.setEmail(updatedUser.getEmail());
            currentUser.setSoDienThoai(updatedUser.getSoDienThoai());
            currentUser.setDiaChi(updatedUser.getDiaChi());

            daoUser.updateUser(currentUser);

            session.setAttribute("loggedInUser", currentUser);

            redirectAttributes.addFlashAttribute("success", "Cập nhật thông tin thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }

        return "redirect:/profile";
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes, 
                                 Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);

            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        try {
            User currentUser = (User) session.getAttribute("loggedInUser");
            if (currentUser == null) {
                return "redirect:/login";
            }

            if (!daoUser.checkPassword(currentUser.getUsername(), currentPassword)) {
                redirectAttributes.addFlashAttribute("error", "Mật khẩu hiện tại không đúng!");
                return "redirect:/profile";
            }

            if (!newPassword.equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("error", "Mật khẩu xác nhận không khớp!");
                return "redirect:/profile";
            }

            daoUser.updatePassword(currentUser.getUsername(), newPassword);

            redirectAttributes.addFlashAttribute("success", "Đổi mật khẩu thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }

        return "redirect:/profile";
    }
}
