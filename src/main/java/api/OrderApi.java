package api;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.time.LocalDateTime;
import java.time.ZoneId;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import beans.Cart;
import beans.Order;
import beans.OrderDetail;
import beans.OrderDetailTopping;
import beans.Product;
import beans.Size;
import beans.Topping;
import beans.Voucher;
import dao.DaoOrder;
import dao.DaoOrderDetail;
import dao.DaoOrderDetailTopping;
import dao.DaoProduct;
import dao.DaoSize;
import dao.DaoTopping;
import dao.DaoVoucher;

@RestController
@RequestMapping("/api/order")
public class OrderApi {
	
	@Autowired
    private DaoOrder daoOrder;
	@Autowired
    private DaoSize daoSize;
	@Autowired
    private DaoVoucher daoVoucher;
	@Autowired
    private DaoTopping daoTopping;
	@Autowired
    private DaoProduct daoProduct;
	@Autowired
    private DaoOrderDetail daoOrderDetail;
	@Autowired
    private DaoOrderDetailTopping daoOrderDetailTopping;
	
	@PostMapping("")
    public ResponseEntity<?> checkout(@RequestBody Order order, HttpServletRequest request, 
    		HttpSession session){
		// Lấy tất cả voucher từ session
		List<String> voucherCodes = (List<String>) session.getAttribute("vouchers");
		String firstVoucher = null;
		if (voucherCodes != null && !voucherCodes.isEmpty()) {
			firstVoucher = voucherCodes.get(0);
			order.setVouchers(java.util.Collections.singletonList(firstVoucher));
		}
		List<Cart> carts = null;
		if(session.getAttribute("cart") == null) {
			carts = new ArrayList<Cart>();
		}else {
			carts = (List<Cart>) session.getAttribute("cart");
		}
		Map<Integer, Integer> products = new HashMap<>();
		for(int i = 0; i < carts.size(); i++) {
			if(products.containsKey(carts.get(i).getProduct())) {
				products.put(carts.get(i).getProduct(), products.get(carts.get(i).getProduct()) + 1);
			}else {
				products.put(carts.get(i).getProduct(), 1);
			}
		}
		for(int i = 0; i < carts.size(); i++) {
			if(daoProduct.getProductById(carts.get(i).getProduct()).getSoLuong() < products.get(carts.get(i).getProduct())) {
				return ResponseEntity.badRequest().body(daoProduct.getProductById(carts.get(i).getProduct()).getTenSP() + " hết hàng");
			}
		}
		// Tính tổng tiền và giảm giá nhiều voucher
		BigDecimal originalTotal = BigDecimal.ZERO;
		for(int i = 0; i < carts.size(); i++) {
			Product product = daoProduct.getProductById(carts.get(i).getProduct());
			Size size = daoSize.getSizeById(carts.get(i).getSize());
			originalTotal = originalTotal.add(product.getDonGia().multiply(size.getHeSoGia()));
			for(int j = 0; j < carts.get(i).getToppings().size(); j++) {
				Topping topping = daoTopping.getToppingById(carts.get(i).getToppings().get(j));
				originalTotal = originalTotal.add(topping.getDonGia());
			}
		}
		BigDecimal totalDiscount = BigDecimal.ZERO;
		BigDecimal currentTotal = originalTotal;
		String firstDiscountType = null;
		BigDecimal firstDiscountValue = null;
		if (firstVoucher != null) {
			Voucher voucher = daoVoucher.getVoucherById(firstVoucher);
			if (voucher != null) {
				if (voucher.getPercentDiscount() != null && voucher.getPercentDiscount().compareTo(BigDecimal.ZERO) > 0) {
					BigDecimal discount = currentTotal.multiply(voucher.getPercentDiscount()).divide(BigDecimal.valueOf(100));
					totalDiscount = totalDiscount.add(discount);
					currentTotal = currentTotal.subtract(discount);
					firstDiscountType = "PERCENT";
					firstDiscountValue = voucher.getPercentDiscount();
				} else if (voucher.getValueDiscount() != null && voucher.getValueDiscount().compareTo(BigDecimal.ZERO) > 0) {
					BigDecimal discount = voucher.getValueDiscount();
					totalDiscount = totalDiscount.add(discount);
					currentTotal = currentTotal.subtract(discount);
					firstDiscountType = "VALUE";
					firstDiscountValue = voucher.getValueDiscount();
				}
			}
		}
		order.setThanhTien(currentTotal);
		order.setDiscountAmount(totalDiscount);
		order.setDiscountType(firstDiscountType);
		order.setDiscountValue(firstDiscountValue);
		// Set ngày đặt theo giờ Việt Nam
		order.setNgayDat(LocalDateTime.now(ZoneId.of("Asia/Ho_Chi_Minh")));
		int orderId = daoOrder.add(order);
		for(int i = 0; i < carts.size(); i++) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setDonHang(orderId);
			orderDetail.setSanPham(carts.get(i).getProduct());
			orderDetail.setSize(carts.get(i).getSize());
			int orderDetailId = daoOrderDetail.add(orderDetail);
			for(int j = 0; j < carts.get(i).getToppings().size(); j++) {
				OrderDetailTopping orderDetailTopping = new OrderDetailTopping();
				orderDetailTopping.setChiTietDonHang(orderDetailId);
				orderDetailTopping.setTopping(carts.get(i).getToppings().get(j));
				daoOrderDetailTopping.add(orderDetailTopping);
				Product product = daoProduct.getProductById(carts.get(i).getProduct());
				product.setSoLuong(product.getSoLuong() - 1);
				daoProduct.update(product);
			}
		}
		session.removeAttribute("cart");
		// Sau khi đặt hàng thành công, xóa voucher khỏi session
		session.removeAttribute("vouchers");
		return ResponseEntity.ok("success");
    }
}
