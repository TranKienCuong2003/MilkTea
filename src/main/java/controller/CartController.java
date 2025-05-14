package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import beans.Cart;
import beans.Category;
import beans.Topping;
import beans.User;
import dao.DaoProduct;
import dao.DaoSize;
import dao.DaoTopping;

@Controller
@RequestMapping("/cart")
public class CartController {
	@Autowired
    private DaoProduct daoProduct;
	@Autowired
    private DaoSize daoSize;
	@Autowired
    private DaoTopping daoTopping;
	
	@GetMapping("/view")
    public String viewCategories(Model model, HttpSession session) {
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Đặt thời gian timeout session là 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
        List<Cart> carts = null;
		if(session.getAttribute("cart") == null) {
			carts = new ArrayList<Cart>();
		}else {
			carts = (List<Cart>) session.getAttribute("cart");
		}
		for(int i = 0; i < carts.size(); i++) {
			carts.get(i).setProductObj(daoProduct.getProductById(carts.get(i).getProduct()));
			carts.get(i).setSizeObj(daoSize.getSizeById(carts.get(i).getSize()));
			List<Topping> toppings = new ArrayList<Topping>();
			for(int j = 0; j < carts.get(i).getToppings().size(); j++) {
				toppings.add(daoTopping.getToppingById(carts.get(i).getToppings().get(j)));
			}
			carts.get(i).setToppingsObj(toppings);
		}
		model.addAttribute("carts", carts);
		model.addAttribute("count", carts.size());
        return "cart_list";
    }
	
	@GetMapping("/delete/{id}")
    public String delete(@PathVariable int id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Đặt thời gian timeout session là 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
    	try {
    		List<Cart> carts = null;
    		if(session.getAttribute("cart") == null) {
    			carts = new ArrayList<Cart>();
    		}else {
    			carts = (List<Cart>) session.getAttribute("cart");
    		}
    		if(id < carts.size()) {
    			carts.remove(id);
    		}
    		session.setAttribute("cart", carts);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "redirect:/cart/view";
    }
}
