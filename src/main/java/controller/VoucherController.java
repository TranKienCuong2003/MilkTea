package controller;

import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import beans.User;
import beans.Voucher;
import dao.DaoVoucher;

@Controller
@RequestMapping("/voucher")
public class VoucherController {

    @Autowired
    private DaoVoucher daoVoucher;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(LocalDateTime.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                if (text != null && !text.isEmpty()) {
                    LocalDate localDate = LocalDate.parse(text);
                    setValue(localDate.atTime(7, 0, 0));
                }
            }
        });
    }

    @GetMapping("/view")
    public String views(Model model, HttpSession session) {
        model.addAttribute("active", "voucherMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        String permission = null;
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            permission = loggedInUser.getTenQuyen().toLowerCase();
            model.addAttribute("permission", permission);
        }

        List<Voucher> vouchers = daoVoucher.list();
        if ("khách hàng".equals(permission)) {
            java.time.LocalDateTime now = java.time.LocalDateTime.now();
            vouchers = vouchers.stream()
                .filter(v -> v.getDateStart() != null && v.getDateEnd() != null &&
                    (v.getDateStart().isBefore(now) || v.getDateStart().isEqual(now)) &&
                    (v.getDateEnd().isAfter(now) || v.getDateEnd().isEqual(now)))
                .toList();
        }
        model.addAttribute("vouchers", vouchers);
        return "voucher_list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session) {
        model.addAttribute("active", "voucherMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        model.addAttribute("voucher", new Voucher());
        return "voucher_create_form";
    }

    @PostMapping("/add")
    public String add(@ModelAttribute Voucher voucher, BindingResult result, Model model, HttpSession session) {
        model.addAttribute("active", "voucherMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        if (result.hasErrors()) {
            return "voucher_create_form";
        }

        voucher.setCode(daoVoucher.generateCodeCheck());
        daoVoucher.save(voucher);
        return "redirect:/voucher/view";
    }

    @GetMapping("/delete/{ma}")
    public String deleteProduct(@PathVariable String ma, HttpSession session, Model model) {
        model.addAttribute("active", "voucherMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        daoVoucher.delete(ma);
        return "redirect:/voucher/view";
    }

    @GetMapping("/edit/{ma}")
    public String showEditForm(@PathVariable String ma, Model model, HttpSession session) {
        model.addAttribute("active", "voucherMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        Voucher voucher = daoVoucher.getVoucherById(ma);
        if (voucher == null) {
            return "redirect:/voucher/view";
        }

        model.addAttribute("voucher", voucher);
        return "voucher_edit_form";
    }

    @PostMapping("/edit/{ma}")
    public String updateProduct(@PathVariable String ma, @ModelAttribute Voucher voucher, 
                              BindingResult result, Model model, HttpSession session) {
        model.addAttribute("active", "voucherMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        if (result.hasErrors()) {
            return "voucher_edit_form";
        }

        voucher.setCode(ma);

        if ("value".equals(voucher.getType())) {
            voucher.setPercentDiscount(null);
        } else {
            voucher.setValueDiscount(null);
        }

        daoVoucher.update(voucher);
        return "redirect:/voucher/view";
    }
}
