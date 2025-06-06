package api;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import beans.Cart;
import beans.Voucher;
import beans.VoucherViewApi;
import dao.DaoSize;
import dao.DaoVoucher;

@RestController
@RequestMapping("/api/voucher")
public class VoucherApi {
	@Autowired
	private DaoVoucher daoVoucher;
	
	@GetMapping("/{maVoucher}")
	public ResponseEntity<?> getVoucher(@PathVariable String maVoucher){
	    if(maVoucher != null && maVoucher.trim().length() > 0) {
	        Voucher voucher = daoVoucher.getVoucherById(maVoucher);
	        if (voucher == null) {
	            return ResponseEntity.badRequest().body("Voucher không tồn tại");
	        }

	        LocalDate today = LocalDate.now();
	        LocalDate start = voucher.getDateStart().toLocalDate();
	        LocalDate end = voucher.getDateEnd().toLocalDate();

	        if ((start.isBefore(today) || start.isEqual(today)) &&
	            (end.isAfter(today) || end.isEqual(today))) {
	        	VoucherViewApi voucherViewApi = new VoucherViewApi();
	        	voucherViewApi.id = voucher.id;
	        	voucherViewApi.code = voucher.code;
	        	voucherViewApi.percentDiscount = voucher.percentDiscount;
	        	voucherViewApi.valueDiscount = voucher.valueDiscount;
	            return ResponseEntity.ok(voucherViewApi);
	        }

	        return ResponseEntity.badRequest().body("Voucher đã hết hạn");
	    }

	    return ResponseEntity.badRequest().body("Mã voucher không hợp lệ");
	}
}
