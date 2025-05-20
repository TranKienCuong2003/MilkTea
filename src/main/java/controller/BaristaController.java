package controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import beans.Order;
import beans.User;
import beans.ViewOrderDetail;
import dao.DaoOrder;
import dao.DaoOrderDetail;

@Controller
@RequestMapping("/barista")
public class BaristaController {

    @Autowired
    private DaoOrder daoOrder;

    @Autowired
    private DaoOrderDetail daoOrderDetail;

    @GetMapping("/orders")
    public String viewOrders(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || !loggedInUser.getTenQuyen().equalsIgnoreCase("nhân viên pha chế")) {
            return "redirect:/login";
        }

        List<Order> orders = daoOrder.getOrdersByStatus(2);
        model.addAttribute("orders", orders);
        model.addAttribute("active", "baristaOrders");
        return "barista/order_list";
    }

    @GetMapping("/orders/{id}")
    public String viewOrderDetail(@PathVariable int id, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || !loggedInUser.getTenQuyen().equalsIgnoreCase("nhân viên pha chế")) {
            return "redirect:/login";
        }

        Order order = daoOrder.getOrderById(id);
        if (order == null || order.getStatus() != 2) {
            return "redirect:/barista/orders";
        }

        List<ViewOrderDetail> orderDetails = daoOrderDetail.getAllOrderDetails(id);
        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("active", "baristaOrders");
        return "barista/order_detail";
    }

    @PostMapping("/orders/{id}/complete")
    public String completeOrder(@PathVariable int id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || !loggedInUser.getTenQuyen().equalsIgnoreCase("nhân viên pha chế")) {
            return "redirect:/login";
        }

        Order order = daoOrder.getOrderById(id);
        if (order != null && order.getStatus() == 2) {
            order.setStatus(3);
            daoOrder.updateOrder(order);
        }

        return "redirect:/barista/orders";
    }

    @GetMapping("/orders/search")
    public String searchOrders(@RequestParam(required = false) String keyword, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || !loggedInUser.getTenQuyen().equalsIgnoreCase("nhân viên pha chế")) {
            return "redirect:/login";
        }

        List<Order> orders;
        if (keyword != null && !keyword.trim().isEmpty()) {
            orders = daoOrder.searchOrders(keyword, 2);
        } else {
            orders = daoOrder.getOrdersByStatus(2);
        }

        model.addAttribute("orders", orders);
        model.addAttribute("keyword", keyword);
        model.addAttribute("active", "baristaOrders");
        return "barista/order_list";
    }

    @GetMapping("/orders/filter")
    public String filterOrders(@RequestParam(required = false) String timeFilter, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || !loggedInUser.getTenQuyen().equalsIgnoreCase("nhân viên pha chế")) {
            return "redirect:/login";
        }

        List<Order> orders;
        if (timeFilter != null && !timeFilter.trim().isEmpty()) {
            LocalDateTime now = LocalDateTime.now();
            LocalDateTime filterTime;

            switch (timeFilter) {
                case "today":
                    filterTime = now.withHour(0).withMinute(0).withSecond(0);
                    break;
                case "10min":
                    filterTime = now.minusMinutes(10);
                    break;
                case "30min":
                    filterTime = now.minusMinutes(30);
                    break;
                default:
                    filterTime = now.withHour(0).withMinute(0).withSecond(0);
            }

            orders = daoOrder.getOrdersByStatusAndTime(2, filterTime);
        } else {
            orders = daoOrder.getOrdersByStatus(2);
        }

        model.addAttribute("orders", orders);
        model.addAttribute("timeFilter", timeFilter);
        model.addAttribute("active", "baristaOrders");
        return "barista/order_list";
    }
}
