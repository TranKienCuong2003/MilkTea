package api;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import beans.Topping;
import dao.DaoTopping;

@RestController
@RequestMapping("/api/topping")
public class ToppingApi {
	@Autowired
	private DaoTopping daoTopping;
	
	@GetMapping("")
    public ResponseEntity<?> get(HttpServletRequest request){
		List<Topping> toppings = daoTopping.getAllToppings();
		String name = request.getParameter("name");
		if (name != null && !name.trim().isEmpty()) {
			toppings = daoTopping.getAllToppingsByKey(name);
	    }
        return ResponseEntity.ok(toppings);
    }
}
