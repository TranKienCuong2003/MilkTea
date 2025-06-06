package controller;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import beans.Cart;
import beans.Category;
import beans.Topping;
import beans.User;
import beans.Product;
import beans.Size;
import beans.Voucher;
import dao.DaoProduct;
import dao.DaoSize;
import dao.DaoTopping;
import dao.DaoVoucher;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private DaoProduct daoProduct;

    @Autowired
    private DaoSize daoSize;

    @Autowired
    private DaoTopping daoTopping;

    @Autowired
    private DaoVoucher daoVoucher;

    /**
     * Hiển thị danh sách sản phẩm trong giỏ hàng
     * URL: /cart/view
     */
    @GetMapping("/view")
    public String viewCategories(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "Bạn cần đăng nhập để sử dụng chức năng này");
            return "redirect:/login";
        }
        // Thiết lập timeout session 30 phút
        session.setMaxInactiveInterval(30 * 60);
        model.addAttribute("loggedInUser", loggedInUser);
        model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());

        List<Cart> carts = null;
        if (session.getAttribute("cart") == null) {
            carts = new ArrayList<Cart>();
        } else {
            carts = (List<Cart>) session.getAttribute("cart");
        }

        for (int i = 0; i < carts.size(); i++) {
            Product product = daoProduct.getProductById(carts.get(i).getProduct());
            carts.get(i).setProductObj(product);

            Size size = daoSize.getSizeById(carts.get(i).getSize());
            carts.get(i).setSizeObj(size);

            List<Topping> toppings = new ArrayList<Topping>();
            List<Integer> toppingIds = carts.get(i).getToppings();
            if (toppingIds != null) {
                for (int j = 0; j < toppingIds.size(); j++) {
                    Integer toppingId = toppingIds.get(j);
                    if (toppingId != null) {
                        try {
                            Topping topping = daoTopping.getToppingById(toppingId);
                            if (topping != null) {
                                toppings.add(topping);
                            }
                        } catch (Exception e) {
                        }
                    }
                }
            }
            carts.get(i).setToppingsObj(toppings);
        }

        // --- Voucher logic ---
        List<String> voucherCodes = (List<String>) session.getAttribute("vouchers");
        if (voucherCodes == null) voucherCodes = new ArrayList<>();
        List<Voucher> vouchers = new ArrayList<>();
        for (String code : voucherCodes) {
            try {
                Voucher v = daoVoucher.getVoucherById(code);
                if (v != null) vouchers.add(v);
            } catch (Exception e) {}
        }
        // Tính tổng tiền trước giảm
        BigDecimal totalBeforeDiscount = BigDecimal.ZERO;
        for (Cart cart : carts) {
            BigDecimal basePrice = cart.getProductObj().getDonGia();
            BigDecimal sizeRatio = cart.getSizeObj().getHeSoGia();
            BigDecimal toppingTotal = BigDecimal.ZERO;
            if (cart.getToppingsObj() != null) {
                for (Topping topping : cart.getToppingsObj()) {
                    toppingTotal = toppingTotal.add(topping.getDonGia());
                }
            }
            BigDecimal totalPrice = basePrice.multiply(sizeRatio).add(toppingTotal);
            totalBeforeDiscount = totalBeforeDiscount.add(totalPrice);
        }
        // Tính tổng giảm giá
        BigDecimal totalDiscount = BigDecimal.ZERO;
        BigDecimal tempTotal = totalBeforeDiscount;
        for (Voucher v : vouchers) {
            if (v.getPercentDiscount() != null && v.getValueDiscount() == null) {
                BigDecimal percent = v.getPercentDiscount();
                BigDecimal discount = tempTotal.multiply(percent).divide(new BigDecimal(100));
                totalDiscount = totalDiscount.add(discount);
                tempTotal = tempTotal.subtract(discount);
            } else if (v.getValueDiscount() != null && v.getPercentDiscount() == null) {
                BigDecimal discount = v.getValueDiscount();
                totalDiscount = totalDiscount.add(discount);
                tempTotal = tempTotal.subtract(discount);
            }
        }
        BigDecimal totalAfterDiscount = totalBeforeDiscount.subtract(totalDiscount);
        if (totalAfterDiscount.compareTo(BigDecimal.ZERO) < 0) totalAfterDiscount = BigDecimal.ZERO;

        model.addAttribute("carts", carts);
        model.addAttribute("count", carts.size());
        model.addAttribute("vouchers", vouchers);
        model.addAttribute("totalBeforeDiscount", totalBeforeDiscount);
        model.addAttribute("totalDiscount", totalDiscount);
        model.addAttribute("totalAfterDiscount", totalAfterDiscount);
        return "cart_list";
    }

    /**
     * Xóa một sản phẩm khỏi giỏ hàng theo chỉ số (index)
     * URL: /cart/delete/{id}
     */
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        try {
            List<Cart> carts = null;
            if (session.getAttribute("cart") == null) {
                carts = new ArrayList<Cart>();
            } else {
                carts = (List<Cart>) session.getAttribute("cart");
            }

            if (id < carts.size()) {
                carts.remove(id);
            }

            session.setAttribute("cart", carts);
        } catch (Exception e) {
            // Báo lỗi nếu có exception
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }

        return "redirect:/cart/view";
    }

    @PostMapping("/remove-voucher/{code}")
    @ResponseBody
    public String removeVoucher(@PathVariable String code, HttpSession session) {
        List<String> voucherCodes = (List<String>) session.getAttribute("vouchers");
        if (voucherCodes != null) {
            voucherCodes = new ArrayList<>(voucherCodes);
            voucherCodes.removeIf(c -> c.equalsIgnoreCase(code));
            session.setAttribute("vouchers", voucherCodes);
        }
        return "OK";
    }

    @PostMapping("/add-voucher/{code}")
    @ResponseBody
    public String addVoucher(@PathVariable String code, HttpSession session) {
        List<String> voucherCodes = (List<String>) session.getAttribute("vouchers");
        if (voucherCodes == null) voucherCodes = new ArrayList<>();
        else voucherCodes = new ArrayList<>(voucherCodes);
        if (!voucherCodes.contains(code)) {
            voucherCodes.add(code);
            session.setAttribute("vouchers", voucherCodes);
        }
        return "OK";
    }
}
