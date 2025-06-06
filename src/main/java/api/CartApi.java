package api;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import beans.Cart;

@RestController
@RequestMapping("/api/cart")
public class CartApi {
	@PostMapping("")
    public ResponseEntity<?> addCart(@RequestBody Cart cart, HttpServletRequest request, HttpSession session){
		List<Cart> carts = null;
		if(session.getAttribute("cart") == null) {
			carts = new ArrayList<Cart>();
		}else {
			carts = (List<Cart>) session.getAttribute("cart");
		}
		carts.add(cart);
		session.setAttribute("cart", carts);
		return ResponseEntity.ok("success");
    }
	
	@GetMapping("")
    public ResponseEntity<?> listCart(HttpServletRequest request, HttpSession session){
		List<Cart> carts = null;
		if(session.getAttribute("cart") == null) {
			carts = new ArrayList<Cart>();
		}else {
			carts = (List<Cart>) session.getAttribute("cart");
		}
		return ResponseEntity.ok(carts);
    }
}
