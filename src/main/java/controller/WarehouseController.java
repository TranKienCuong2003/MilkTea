package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import beans.User;
import beans.Warehouse;
import dao.DaoWarehouse;
import dao.DaoSupplier;

@Controller
@RequestMapping("/warehouse")
public class WarehouseController {

    @Autowired
    private DaoWarehouse daoWarehouse;

    @Autowired
    private DaoSupplier daoSupplier;

    @GetMapping("/view")
    public String views(Model model, HttpSession session) {
        model.addAttribute("active", "warehouseMgm");
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        List<Warehouse> warehouses = daoWarehouse.list();
        model.addAttribute("warehouses", warehouses);
        return "warehouse_list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model, HttpSession session) {
        model.addAttribute("active", "warehouseMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        model.addAttribute("warehouse", new Warehouse());
        model.addAttribute("suppliers", daoSupplier.list());
        return "warehouse_create_form";
    }

    @PostMapping("/add")
    public String add(@ModelAttribute Warehouse warehouse, BindingResult result, Model model, HttpSession session) {
        model.addAttribute("active", "warehouseMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        if (result.hasErrors()) {
            return "warehouse_create_form";
        }

        daoWarehouse.save(warehouse);
        return "redirect:/warehouse/view";
    }

    @GetMapping("/delete/{maKho}")
    public String deleteProduct(@PathVariable int maKho, HttpSession session, Model model) {
        model.addAttribute("active", "warehouseMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        daoWarehouse.delete(maKho);
        return "redirect:/warehouse/view";
    }

    @GetMapping("/edit/{maKho}")
    public String showEditForm(@PathVariable int maKho, Model model, HttpSession session) {
        model.addAttribute("active", "warehouseMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        Warehouse warehouse = daoWarehouse.getWarehouseById(maKho);
        if (warehouse == null) {
            return "redirect:/warehouse/view";
        }

        model.addAttribute("warehouse", warehouse);
        model.addAttribute("suppliers", daoSupplier.list());
        return "warehouse_edit_form";
    }

    @PostMapping("/edit/{maKho}")
    public String updateProduct(@PathVariable int maKho, @ModelAttribute Warehouse warehouse, 
                                BindingResult result, Model model, HttpSession session) {
        model.addAttribute("active", "warehouseMgm");

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }

        if (result.hasErrors()) {
            return "warehouse_edit_form";
        }

        warehouse.setCode(maKho);
        daoWarehouse.update(warehouse);
        return "redirect:/warehouse/view";
    }
}
