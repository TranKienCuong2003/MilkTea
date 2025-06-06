package dao;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import beans.Order;
import beans.OrderDetail;
import beans.Topping;
import beans.ViewOrderDetail;

@Repository
public class DaoOrderDetail {
	@Autowired
    private JdbcTemplate jdbcTemplate;
	
	public int add(OrderDetail orderDetail) {
        String sql = "INSERT INTO chi_tiet_don_hang (don_hang, san_pham, size) VALUES (?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        try {
        	jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, orderDetail.getDonHang());
                ps.setInt(2, orderDetail.getSanPham());
                ps.setInt(3, orderDetail.getSize());
                return ps;
            }, keyHolder);

            return keyHolder.getKey().intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }
	
	public List<ViewOrderDetail> getAllOrderDetails(int order) {
        String sql = "SELECT ct.id, sp.TenSP, sp.DonGia, size.TenSize, size.HeSoGia "
        		+ "FROM chi_tiet_don_hang ct "
        		+ "JOIN san_pham sp ON sp.maSP = ct.san_pham "
        		+ "JOIN size_san_pham size ON size.MaSize = ct.size "
        		+ "WHERE ct.don_hang = ?";
        try {
        	return jdbcTemplate.query(
        		    sql, new Object[]{order},
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		    	ViewOrderDetail viewOrderDetail = new ViewOrderDetail();
        		    	viewOrderDetail.setProductName(rs.getString("TenSP"));
        		    	BigDecimal donGia = rs.getBigDecimal("DonGia");
        		    	BigDecimal thanhTien = BigDecimal.ZERO;
        		    	viewOrderDetail.setDonGia(donGia);
        		    	String tenSize = rs.getString("TenSize");
        		    	BigDecimal heSoGiaSize = rs.getBigDecimal("HeSoGia");
        		    	viewOrderDetail.setSize(tenSize + "(" + heSoGiaSize + ")");
        		    	String topping = "";
        		    	List<Topping> toppings = getToppings(rs.getInt("id"));
        		    	thanhTien = thanhTien.add(donGia.multiply(heSoGiaSize));
        		    	for(int i = 0; i < toppings.size(); i++) {
        		    		if(topping.length() > 0) {
        		    			topping += ", ";
        		    		}
        		    		topping += toppings.get(i).getTenTopping();
        		    		NumberFormat vnFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        		    		String formatted = vnFormat.format(toppings.get(i).getDonGia());
        		    		topping += "(" + formatted + ")";
        		    		thanhTien = thanhTien.add(toppings.get(i).getDonGia());
        		    	}
        		    	viewOrderDetail.setTopping(topping);
        		    	viewOrderDetail.setThanhTien(thanhTien);
        		    	return viewOrderDetail;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }
	
	public List<Topping> getToppings(int orderDetail) {
        String sql = "SELECT topping.* "
        		+ "FROM chi_tiet_don_hang_topping cttopping "
        		+ "JOIN topping topping ON topping.MaTopping = cttopping.topping "
        		+ "WHERE cttopping.chi_tiet_don_hang = ?";
        try {
        	return jdbcTemplate.query(
        		    sql, new Object[]{orderDetail},
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		    	Topping topping = new Topping();
        		    	topping.setMaTopping(rs.getInt("maTopping"));
        		    	topping.setTenTopping(rs.getString("tenTopping"));
        		    	topping.setDonGia(rs.getBigDecimal("donGia"));
        		    	topping.setTrangThai(rs.getInt("trangThai"));
        		    	return topping;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }
}
