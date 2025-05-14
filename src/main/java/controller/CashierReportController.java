package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.DaoOrder;
import dao.DaoOrderDetail;
import beans.Order;
import beans.ViewOrderDetail;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/cashier")
public class CashierReportController {
    @Autowired
    private DaoOrder daoOrder;

    @Autowired
    private DaoOrderDetail daoOrderDetail;

    @GetMapping("/revenue")
    public String revenueReport(@RequestParam(defaultValue = "day") String type, Model model, HttpSession session) {
        Object permission = session.getAttribute("permission");
        if (permission == null || !"nhân viên thu ngân".equals(permission.toString())) {
            return "redirect:/login";
        }
        List<Map<String, Object>> report;
        switch (type) {
            case "month":
                report = daoOrder.getRevenueByMonth();
                break;
            case "quarter":
                report = daoOrder.getRevenueByQuarter();
                break;
            case "year":
                report = daoOrder.getRevenueByYear();
                break;
            default:
                report = daoOrder.getRevenueByDay();
        }
        model.addAttribute("report", report);
        model.addAttribute("type", type);
        model.addAttribute("active", "cashierReport");
        return "cashier/revenue_report";
    }

    @GetMapping("/orders/waiting-payment")
    public String waitingPaymentOrders(Model model, HttpSession session) {
        Object permission = session.getAttribute("permission");
        if (permission == null || !"nhân viên thu ngân".equals(permission.toString())) {
            return "redirect:/login";
        }
        List<Order> orders = daoOrder.getOrdersWaitingPayment();
        model.addAttribute("orders", orders);
        model.addAttribute("active", "cashierPayment");
        return "cashier/waiting_payment_orders";
    }

    @PostMapping("/orders/{id}/confirm-payment")
    public String confirmPayment(@PathVariable int id, HttpSession session) {
        Object permission = session.getAttribute("permission");
        if (permission == null || !"nhân viên thu ngân".equals(permission.toString())) {
            return "redirect:/login";
        }
        daoOrder.confirmPayment(id);
        return "redirect:/cashier/orders/waiting-payment";
    }

    @GetMapping("/orders/{id}/bill")
    public String viewBill(@PathVariable int id, Model model, HttpSession session) {
        Object permission = session.getAttribute("permission");
        if (permission == null || !"nhân viên thu ngân".equals(permission.toString())) {
            return "redirect:/login";
        }
        
        Order order = daoOrder.getOrderById(id);
        if (order == null) {
            return "redirect:/cashier/orders/waiting-payment";
        }
        
        List<ViewOrderDetail> orderDetails = daoOrderDetail.getAllOrderDetails(id);
        
        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("active", "cashierPayment");
        return "cashier/order_bill";
    }
} 