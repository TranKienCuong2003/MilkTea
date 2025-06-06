package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    /**
     * Trang báo cáo doanh thu (theo ngày/tháng/quý/năm)
     * URL: /cashier/revenue?type=day|month|quarter|year
     */
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
    public Object confirmPayment(@PathVariable int id, HttpSession session, @RequestHeader(value = "X-Requested-With", required = false) String requestedWith) {
        Object permission = session.getAttribute("permission");
        if (permission == null || !"nhân viên thu ngân".equals(permission.toString())) {
            if ("XMLHttpRequest".equals(requestedWith)) {
                return org.springframework.http.ResponseEntity.status(403).body(java.util.Map.of("error", "Không có quyền!"));
            }
            return "redirect:/login";
        }
        boolean ok = daoOrder.confirmPayment(id); // Đánh dấu đã thanh toán
        if ("XMLHttpRequest".equals(requestedWith)) {
            if (ok) return org.springframework.http.ResponseEntity.ok(java.util.Map.of("success", true));
            else return org.springframework.http.ResponseEntity.badRequest().body(java.util.Map.of("error", "Lỗi xác nhận!"));
        }
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
