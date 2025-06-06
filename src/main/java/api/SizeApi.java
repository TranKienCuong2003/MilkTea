package api;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import beans.Size;
import dao.DaoSize;

@RestController
@RequestMapping("/api/size")
public class SizeApi {
	@Autowired
	private DaoSize daoSize;
	
	@GetMapping("")
    public ResponseEntity<?> get(HttpServletRequest request){
        List<Size> sizes = daoSize.getAllSizes();
        return ResponseEntity.ok(sizes);
    }
}
