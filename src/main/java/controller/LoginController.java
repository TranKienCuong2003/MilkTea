package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import beans.User;
import dao.DaoUser;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    
    @Autowired
    private DaoUser daoUser;
    
    @GetMapping("/login")
    public String showLoginForm(HttpSession session) {
        // Nếu đã đăng nhập, chuyển hướng về trang chủ
        if (session != null && session.getAttribute("loggedInUser") != null) {
            return "redirect:/home";
        }
        return "login";
    }
    
    @GetMapping("/")
    public String redirectToHome(HttpSession session) {
        // Nếu đã đăng nhập, chuyển hướng về trang chủ
        if (session != null && session.getAttribute("loggedInUser") != null) {
            return "redirect:/home";
        }
        return "redirect:/login";
    }
    
    @PostMapping("/login")
    public String processLogin(@RequestParam String username, 
                             @RequestParam String password,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User user = daoUser.checkLogin(username, password);
        
        if (user != null) {
            // Đặt thời gian timeout session
            session.setMaxInactiveInterval(30 * 60); // 30 phút
            session.setAttribute("loggedInUser", user);
            session.setAttribute("permission", user.getTenQuyen().toLowerCase());
            // Kiểm tra URL đích để chuyển hướng
            String targetUrl = (String) session.getAttribute("targetUrl");
            if (targetUrl != null) {
                session.removeAttribute("targetUrl");
                return "redirect:" + targetUrl;
            }
            
            return "redirect:/home";
        } else {
            redirectAttributes.addFlashAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            return "redirect:/login";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }
} 