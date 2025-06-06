package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import beans.Permission;
import beans.Product;
import beans.User;
import dao.DaoUser;
import service.EmailService;
import javax.mail.MessagingException;

@Controller
@RequestMapping("/user")
public class UserController {
    
    @Autowired
    private DaoUser daoUser;
    
    @Autowired
    private ServletContext servletContext;

    @Autowired
    private EmailService emailService;

    @PostMapping("/upload-avatar")
    public String uploadAvatar(@RequestParam("avatar") MultipartFile file, 
                             HttpSession session,
                             RedirectAttributes redirectAttributes, Model model) {
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        
    	User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để thực hiện chức năng này");
            return "redirect:/login";
        }

        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng chọn file ảnh");
            return "redirect:/user/profile";
        }

        try {
            String uploadDir = servletContext.getRealPath("/resources/images/avatars");
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            String filename = user.getMaNd() + "_" + System.currentTimeMillis() + "_" + file.getOriginalFilename();
            Path path = Paths.get(uploadDir, filename);
            
            Files.write(path, file.getBytes());
            
            String avatarPath = "/resources/images/avatars/" + filename;
            daoUser.updateAvatar(user.getMaNd(), avatarPath);
            
            user.setAnhDaiDien(avatarPath);
            session.setAttribute("loggedInUser", user);
            
            redirectAttributes.addFlashAttribute("success", "Cập nhật ảnh đại diện thành công");
        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra khi tải lên ảnh");
        }
        
        return "redirect:/user/profile";
    }

    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
    	User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("loggedInUser", user);
        return "user_profile";
    }

    @PostMapping("/update")
    public String updateProfile(@ModelAttribute User updatedUser, HttpSession session, 
                              RedirectAttributes redirectAttributes, Model model) {
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
    	User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        try {
            currentUser.setHoTen(updatedUser.getHoTen());
            currentUser.setEmail(updatedUser.getEmail());
            currentUser.setSoDienThoai(updatedUser.getSoDienThoai());
            currentUser.setDiaChi(updatedUser.getDiaChi());
            
            daoUser.updateUser(currentUser);
            
            session.setAttribute("loggedInUser", currentUser);
            
            redirectAttributes.addFlashAttribute("success", "Cập nhật thông tin thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin: " + e.getMessage());
        }
        
        return "redirect:/user/profile";
    }
    
    @GetMapping("/view")
    public String views(Model model, HttpSession session) {
        model.addAttribute("active", "employeeMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
            
            int permission = -1;
            if(loggedInUser.getTenQuyen().toLowerCase().equals("quản lý")) {
                permission = 1;
            } else if(loggedInUser.getTenQuyen().toLowerCase().equals("chủ quán")) {
                permission = 0;
            }
            List<User> users = daoUser.list(permission);
            model.addAttribute("users", users);
        }
        return "user_list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session) {
        model.addAttribute("active", "employeeMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
            
            List<Permission> permissions = new ArrayList<Permission>();
            permissions.add(new Permission(0, "Nhân viên kho"));
            permissions.add(new Permission(1, "Nhân viên order"));
            permissions.add(new Permission(2, "Nhân viên pha chế"));
            permissions.add(new Permission(3, "Nhân viên thu ngân"));
            
            if(loggedInUser.getTenQuyen().toLowerCase().equals("quản lý")) {
                permissions.add(new Permission(5, "Quản lý"));
            } else if(loggedInUser.getTenQuyen().toLowerCase().equals("chủ quán")) {
                permissions.add(new Permission(4, "Chủ quán"));
                permissions.add(new Permission(5, "Quản lý"));
            }
            model.addAttribute("permissions", permissions);
        }
        model.addAttribute("user", new User());
        return "user_create_form";
    }

    @PostMapping("/add")
    public String add(@ModelAttribute User user, BindingResult result, Model model, HttpSession session) {
        model.addAttribute("active", "employeeMgm");
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
            
            List<Permission> permissions = new ArrayList<Permission>();
            permissions.add(new Permission(0, "Nhân viên kho"));
            permissions.add(new Permission(1, "Nhân viên order"));
            permissions.add(new Permission(2, "Nhân viên pha chế"));
            permissions.add(new Permission(3, "Nhân viên thu ngân"));
            
            if(loggedInUser.getTenQuyen().toLowerCase().equals("quản lý")) {
                permissions.add(new Permission(5, "Quản lý"));
            } else if(loggedInUser.getTenQuyen().toLowerCase().equals("chủ quán")) {
                permissions.add(new Permission(4, "Chủ quán"));
                permissions.add(new Permission(5, "Quản lý"));
            }
            model.addAttribute("permissions", permissions);
        }
        if (result.hasErrors()) {
            return "user_create_form";
        }
        switch(user.getMaQuyen()) {
    	case 0:
    		user.setTenDangNhap(daoUser.getUserName("Nhân viên kho"));
    		break;
    	case 1:
    		user.setTenDangNhap(daoUser.getUserName("Nhân viên order"));
    		break;
    	case 2:
    		user.setTenDangNhap(daoUser.getUserName("Nhân viên pha chế"));
    		break;
    	case 3:
    		user.setTenDangNhap(daoUser.getUserName("Nhân viên thu ngân"));
    		break;
    	case 4:
    		user.setTenDangNhap(daoUser.getUserName("Chủ quán"));
    		break;
    	case 5:
    		user.setTenDangNhap(daoUser.getUserName("Quản lý"));
    		break;
    }
        user.setPassword("123");

        switch(user.getMaQuyen()) {
        	case 0:
        		user.setMaQuyen(daoUser.getPermission("Nhân viên kho"));
        		break;
        	case 1:
        		user.setMaQuyen(daoUser.getPermission("Nhân viên order"));
        		break;
        	case 2:
        		user.setMaQuyen(daoUser.getPermission("Nhân viên pha chế"));
        		break;
        	case 3:
        		user.setMaQuyen(daoUser.getPermission("Nhân viên thu ngân"));
        		break;
        	case 4:
        		user.setMaQuyen(daoUser.getPermission("Chủ quán"));
        		break;
        	case 5:
        		user.setMaQuyen(daoUser.getPermission("Quản lý"));
        		break;
        }
        user.setAnhDaiDien(saveFile(user.getFile()));
        daoUser.save(user);
        return "redirect:/user/view";
    }
    
    public String saveFile(MultipartFile file) {
        String path = "D:\\MilkTea\\Images\\";

        LocalDateTime localDateTime = LocalDateTime.now();
        Timestamp timestamp = Timestamp.valueOf(localDateTime);
        Date date = new Date(timestamp.getTime());

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String formattedDate = formatter.format(date);

        String fileName = "user-" + formattedDate + "." + getFileExtension(file.getOriginalFilename());

        String rs = "images/" + fileName;

        try {
            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            Files.copy(file.getInputStream(), Paths.get(path + fileName));

            return rs;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public String getFileExtension(String fileName) {
        if (fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0) {
            return fileName.substring(fileName.lastIndexOf(".") + 1);
        } else {
            return "";
        }
    }
    
    @GetMapping("/delete/{maNd}")
    public String deleteProduct(@PathVariable int maNd, HttpSession session, Model model) {
        model.addAttribute("active", "employeeMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);

            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        daoUser.delete(maNd);

        return "redirect:/user/view";
    }
    
    @GetMapping("/edit/{MaNd}")
    public String showEditForm(@PathVariable int MaNd, Model model, HttpSession session) {
        model.addAttribute("active", "employeeMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        List<Permission> permissions = new ArrayList<>();
        permissions.add(new Permission(0, "Nhân viên kho"));
        permissions.add(new Permission(1, "Nhân viên order"));
        permissions.add(new Permission(2, "Nhân viên pha chế"));
        permissions.add(new Permission(3, "Nhân viên thu ngân"));

        if (loggedInUser.getTenQuyen().toLowerCase().equals("quản lý")) {
            permissions.add(new Permission(5, "Quản lý"));
        } else if (loggedInUser.getTenQuyen().toLowerCase().equals("chủ quán")) {
            permissions.add(new Permission(4, "Chủ quán"));
            permissions.add(new Permission(5, "Quản lý"));
        }

        model.addAttribute("permissions", permissions);

        User user = daoUser.getUserById(MaNd);

        switch(user.getTenQuyen().toLowerCase()) {
            case "nhân viên kho":
                user.setMaQuyen(0);
                break;
            case "nhân viên order":
                user.setMaQuyen(1);
                break;
            case "nhân viên pha chế":
                user.setMaQuyen(2);
                break;
            case "nhân viên thu ngân":
                user.setMaQuyen(3);
                break;
            case "chủ quán":
                user.setMaQuyen(4);
                break;
            case "quản lý":
                user.setMaQuyen(5);
                break;
        }

        if (user == null) {
            return "redirect:/user/view";
        }

        model.addAttribute("user", user);

        return "user_edit_form";
    }

    @PostMapping("/edit/{MaNd}")
    public String updateProduct(@PathVariable int MaNd, @ModelAttribute User user,
                                BindingResult result, Model model, HttpSession session) {
        model.addAttribute("active", "employeeMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        List<Permission> permissions = new ArrayList<>();
        permissions.add(new Permission(0, "Nhân viên kho"));
        permissions.add(new Permission(1, "Nhân viên order"));
        permissions.add(new Permission(2, "Nhân viên pha chế"));
        permissions.add(new Permission(3, "Nhân viên thu ngân"));

        if (loggedInUser.getTenQuyen().toLowerCase().equals("quản lý")) {
            permissions.add(new Permission(5, "Quản lý"));
        } else if (loggedInUser.getTenQuyen().toLowerCase().equals("chủ quán")) {
            permissions.add(new Permission(4, "Chủ quán"));
            permissions.add(new Permission(5, "Quản lý"));
        }

        model.addAttribute("permissions", permissions);

        if (result.hasErrors()) {
            return "user_edit_form";
        }

        switch(user.getMaQuyen()) {
            case 0:
                user.setMaQuyen(daoUser.getPermission("Nhân viên kho"));
                break;
            case 1:
                user.setMaQuyen(daoUser.getPermission("Nhân viên order"));
                break;
            case 2:
                user.setMaQuyen(daoUser.getPermission("Nhân viên pha chế"));
                break;
            case 3:
                user.setMaQuyen(daoUser.getPermission("Nhân viên thu ngân"));
                break;
            case 4:
                user.setMaQuyen(daoUser.getPermission("Chủ quán"));
                break;
            case 5:
                user.setMaQuyen(daoUser.getPermission("Quản lý"));
                break;
        }

        user.setAnhDaiDien(saveFile(user.getFile()));

        daoUser.update(user);

        return "redirect:/user/view";
    }

    @PostMapping("/change-email")
    @ResponseBody
    public ResponseEntity<?> changeEmail(@RequestParam String newEmail, HttpSession session) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Vui lòng đăng nhập");
        }

        // Kiểm tra email mới đã tồn tại chưa
        User existingUser = daoUser.findByEmail(newEmail);
        if (existingUser != null) {
            return ResponseEntity.badRequest().body("Email này đã được sử dụng");
        }

        try {
            // Tạo mã OTP
            String otp = generateOTP();
            
            // Cập nhật email và OTP tạm thời
            daoUser.updateEmailWithOtp(currentUser.getMaNd(), newEmail, otp);
            
            // Gửi email xác thực đổi email đến địa chỉ mới
            emailService.sendChangeEmailOtp(newEmail, otp);
            
            return ResponseEntity.ok("Mã xác thực đã được gửi đến email mới của bạn");
        } catch (MessagingException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Có lỗi xảy ra khi gửi email. Vui lòng thử lại sau.");
        }
    }

    @PostMapping("/verify-new-email")
    @ResponseBody
    public ResponseEntity<?> verifyNewEmail(@RequestParam String otp, HttpSession session) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Vui lòng đăng nhập");
        }

        String oldEmail = currentUser.getEmail();

        if (daoUser.verifyNewEmailOtp(currentUser.getMaNd(), otp)) {
            try {
                // Cập nhật session với email mới
                User updatedUser = daoUser.getUserById(currentUser.getMaNd());
                currentUser.setEmail(updatedUser.getEmail());
                session.setAttribute("loggedInUser", currentUser);

                // Gửi email thông báo đến địa chỉ cũ
                emailService.sendEmailChangeNotification(oldEmail, currentUser.getEmail());

                return ResponseEntity.ok("Email đã được cập nhật thành công");
            } catch (MessagingException e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Email đã được cập nhật nhưng có lỗi khi gửi thông báo. Vui lòng kiểm tra lại email của bạn.");
            }
        }

        return ResponseEntity.badRequest().body("Mã xác thực không hợp lệ");
    }

    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
} 