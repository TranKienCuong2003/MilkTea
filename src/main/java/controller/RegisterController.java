package controller;

import beans.User;
import dao.DaoUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import service.EmailService;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import java.util.Random;
import java.util.HashMap;
import java.util.Map;

@Controller
public class RegisterController {
    @Autowired
    private DaoUser daoUser;
    @Autowired
    private EmailService emailService;

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String processRegister(
            @ModelAttribute("user") User user,
            @RequestParam("confirmPassword") String confirmPassword,
            @RequestParam("captcha") String captcha,
            @RequestParam("otp") String otp,
            HttpSession session,  
            RedirectAttributes redirectAttributes) {

        String sessionCaptcha = (String) session.getAttribute("captcha");
        if (sessionCaptcha == null || !sessionCaptcha.equalsIgnoreCase(captcha)) {
            redirectAttributes.addFlashAttribute("error", "Captcha không đúng!");
            return "redirect:/register";
        }

        if (!user.getMatKhau().equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu xác nhận không khớp!");
            return "redirect:/register";
        }

        if (daoUser.existsByUsername(user.getTenDangNhap())) {
            redirectAttributes.addFlashAttribute("error", "Tên đăng nhập đã tồn tại!");
            return "redirect:/register";
        }

        if (daoUser.existsByEmail(user.getEmail())) {
            User userDb = daoUser.findByEmail(user.getEmail());
            if (userDb == null || userDb.getOtpCode() == null || !userDb.getOtpCode().equals(otp)) {
                redirectAttributes.addFlashAttribute("error", "Mã xác thực không đúng!");
                return "redirect:/register";
            }
            daoUser.verifyOtp(user.getEmail(), otp);
            try {
                emailService.sendRegistrationSuccessEmail(user.getEmail());
            } catch (MessagingException e) {
                // Có thể log lỗi nếu cần
            }
            redirectAttributes.addFlashAttribute("success", "Đăng ký thành công! Bạn có thể đăng nhập.");
            return "redirect:/login";
        } else {
            String otpSession = (String) session.getAttribute("otpForRegister:" + user.getEmail());
            if (otpSession == null || !otpSession.equals(otp)) {
                redirectAttributes.addFlashAttribute("error", "Mã xác thực không đúng!");
                return "redirect:/register";
            }

            user.setMaQuyen(7);
            user.setTrangThai(false);

            user.setOtpCode(otp);
            daoUser.saveWithOtp(user);

            session.removeAttribute("otpForRegister:" + user.getEmail());

            daoUser.verifyOtp(user.getEmail(), otp);
            try {
                emailService.sendRegistrationSuccessEmail(user.getEmail());
            } catch (MessagingException e) {
                // Có thể log lỗi nếu cần
            }
            redirectAttributes.addFlashAttribute("success", "Đăng ký thành công! Bạn có thể đăng nhập.");
            return "redirect:/login";
        }
    }

    @GetMapping("/verify-otp")
    public String showOtpForm() {
        return "verify-otp";
    }
    
    @PostMapping("/verify-otp")
    public String processOtp(@RequestParam("otp") String otp, HttpSession session, RedirectAttributes redirectAttributes) {
        
        String email = (String) session.getAttribute("emailForOtp");
        if (email == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng ký lại.");
            return "redirect:/register";
        }
        boolean verified = daoUser.verifyOtp(email, otp);
        if (verified) {
            redirectAttributes.addFlashAttribute("success", "Xác thực email thành công! Bạn có thể đăng nhập.");
            session.removeAttribute("emailForOtp");
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "Mã xác minh email không khớp!");
            return "redirect:/verify-otp";
        }
    }

    @PostMapping("/resend-otp")
    public String resendOtp(HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            String email = (String) session.getAttribute("emailForOtp");
            if (email == null) {
                redirectAttributes.addFlashAttribute("error", "Vui lòng đăng ký lại.");
                return "redirect:/register";
            }
            User user = daoUser.findByEmail(email);
            if (user == null) {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy tài khoản để gửi lại mã xác thực.");
                return "redirect:/register";
            }
            String otp = String.format("%06d", new java.util.Random().nextInt(1000000));
            user.setOtpCode(otp);

            daoUser.updateOtpCode(email, otp);

            emailService.sendVerificationEmail(email, otp);

            redirectAttributes.addFlashAttribute("info", "Đã gửi lại mã xác thực! Vui lòng kiểm tra email.");
            return "redirect:/verify-otp";
        } catch (MessagingException e) {
            redirectAttributes.addFlashAttribute("error", "Không thể gửi email xác thực. Vui lòng thử lại sau.");
            return "redirect:/verify-otp";
        }
    }

    @PostMapping("/send-otp")
    @ResponseBody
    public Map<String, Object> sendOtp(@RequestParam("email") String email, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            if (email == null || email.isEmpty()) {
                result.put("success", false);
                result.put("message", "Email không hợp lệ!");
                return result;
            }

            if (daoUser.existsByEmail(email)) {
                User user = daoUser.findByEmail(email);
                if (user == null) {
                    result.put("success", false);
                    result.put("message", "Không tìm thấy tài khoản để gửi mã xác thực!");
                    return result;
                }
                String otp = String.format("%06d", new java.util.Random().nextInt(1000000));
                user.setOtpCode(otp);

                daoUser.updateOtpCode(email, otp);

                emailService.sendVerificationEmail(email, otp);

                result.put("success", true);
                return result;
            } else {
                String otp = String.format("%06d", new java.util.Random().nextInt(1000000));
                session.setAttribute("otpForRegister:" + email, otp);

                emailService.sendVerificationEmail(email, otp);

                result.put("success", true);
                return result;
            }
        } catch (MessagingException e) {
            result.put("success", false);
            result.put("message", "Không thể gửi email xác thực. Vui lòng thử lại sau.");
            return result;
        }
    }
}
