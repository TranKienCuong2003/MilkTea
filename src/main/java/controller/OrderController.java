package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;

import beans.Order;
import beans.User;
import beans.ViewOrderDetail;
import beans.Voucher;
import dao.DaoOrder;
import dao.DaoOrderDetail;
import dao.DaoVoucher;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private DaoOrder daoOrder;

    @Autowired
    private DaoVoucher daoVoucher;

    @Autowired
    private DaoOrderDetail daoOrderDetail;

    @GetMapping("/view")
    public String views(Model model, HttpSession session) {
        model.addAttribute("active", "orderMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        List<Order> orders = daoOrder.getAllOrders();
        model.addAttribute("orders", orders);

        return "order_list";
    }

    @GetMapping("/detail/{order}")
    public String detail(@PathVariable int order, Model model, HttpSession session) {
        model.addAttribute("active", "orderMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        List<ViewOrderDetail> orderDetails = daoOrderDetail.getAllOrderDetails(order);
        model.addAttribute("orderDetails", orderDetails);

        Order orderObj = daoOrder.getOrderById(order);
        model.addAttribute("order", orderObj);

        return "order_detail";
    }

    @PostMapping("/confirm")
    @ResponseBody
    public ResponseEntity<?> confirmOrder(
        @RequestParam int orderId,
        @RequestParam String loaiDon
    ) {
        daoOrder.updateOrderTypeAndTable(orderId, loaiDon, null, null);
        daoOrder.updateOrderStatus(orderId, 2);
        return ResponseEntity.ok(java.util.Map.of("success", true));
    }
}
