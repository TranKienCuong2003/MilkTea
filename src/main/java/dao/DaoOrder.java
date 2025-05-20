package dao;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import java.time.LocalDateTime;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import beans.Category;
import beans.Order;
import beans.Warehouse;

@Repository
public class DaoOrder {
	@Autowired
    private JdbcTemplate jdbcTemplate;
	
	public int add(Order order) {
		String sql;
		if(order.getVouchers() == null || order.getVouchers().isEmpty()) {
			sql = "INSERT INTO don_hang (ten, diaChi, sdt, ngayDat, status, tongTien) VALUES (?, ?, ?, ?, 1, ?)";
		}else {
			sql = "INSERT INTO don_hang (ten, diaChi, sdt, ngayDat, status, tongTien, voucher, discount_amount, discount_type, discount_value) VALUES (?, ?, ?, ?, 1, ?, ?, ?, ?, ?)";
		}
        
        KeyHolder keyHolder = new GeneratedKeyHolder();

        try {
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, order.getTen());
                ps.setString(2, order.getDiaChi());
                ps.setString(3, order.getSdt());
                ps.setTimestamp(4, java.sql.Timestamp.valueOf(order.getNgayDat()));
                ps.setBigDecimal(5, order.getThanhTien());
                if(!(order.getVouchers() == null || order.getVouchers().isEmpty())) {
                	ps.setString(6, order.getVoucherString());
                	ps.setBigDecimal(7, order.getDiscountAmount());
                	ps.setString(8, order.getDiscountType());
                	ps.setBigDecimal(9, order.getDiscountValue());
                }
                return ps;
            }, keyHolder);

            return keyHolder.getKey().intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return -1; // Trả về -1 nếu có lỗi
        }
    }
	
	public List<Order> getAllOrders() {
        String sql = "SELECT * FROM don_hang";
        try {
        	return jdbcTemplate.query(
        		    sql,
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		    	Order order = new Order();
        		    	order.setId(rs.getInt("id"));
        		    	order.setTen(rs.getString("ten"));
        		    	order.setDiaChi(rs.getString("diachi"));
        		    	order.setSdt(rs.getString("sdt"));
        		    	order.setNgayDat(rs.getTimestamp("ngayDat").toLocalDateTime());
        		    	order.setStatus(rs.getInt("status"));
        		    	order.setNgayDatFormatted(order.getNgayDatFormatted());
        		    	order.setThanhTien(rs.getBigDecimal("tongTien"));
        		    	order.setVoucherString(rs.getString("voucher"));
        		    	order.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        		    	order.setDiscountType(rs.getString("discount_type"));
        		    	order.setDiscountValue(rs.getBigDecimal("discount_value"));
        		    	return order;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }
	
	public Order getOrderById(int id) {
        String sql = "SELECT * FROM don_hang WHERE id = ?";
        try {
        	return jdbcTemplate.queryForObject(
        		    sql, new Object[]{id},
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		    	Order order = new Order();
        		    	order.setId(rs.getInt("id"));
        		    	order.setTen(rs.getString("ten"));
        		    	order.setDiaChi(rs.getString("diachi"));
        		    	order.setSdt(rs.getString("sdt"));
        		    	order.setNgayDat(rs.getTimestamp("ngayDat").toLocalDateTime());
        		    	order.setStatus(rs.getInt("status"));
        		    	order.setNgayDatFormatted(order.getNgayDatFormatted());
        		    	order.setThanhTien(rs.getBigDecimal("tongTien"));
        		    	order.setVoucherString(rs.getString("voucher"));
        		    	order.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        		    	order.setDiscountType(rs.getString("discount_type"));
        		    	order.setDiscountValue(rs.getBigDecimal("discount_value"));
        		    	return order;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }

    public List<Order> getOrdersByStatus(int status) {
        String sql = "SELECT * FROM don_hang WHERE status = ? ORDER BY ngayDat DESC";
        try {
            return jdbcTemplate.query(
                sql, new Object[]{status},
                (java.sql.ResultSet rs, int rowNum) -> {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setTen(rs.getString("ten"));
                    order.setDiaChi(rs.getString("diachi"));
                    order.setSdt(rs.getString("sdt"));
                    order.setNgayDat(rs.getTimestamp("ngayDat").toLocalDateTime());
                    order.setStatus(rs.getInt("status"));
                    order.setNgayDatFormatted(order.getNgayDatFormatted());
                    order.setThanhTien(rs.getBigDecimal("tongTien"));
                    order.setVoucherString(rs.getString("voucher"));
                    return order;
                }
            );
        } catch (Exception e) {
            return null;
        }
    }

    public List<Order> searchOrders(String keyword, int status) {
        String sql = "SELECT * FROM don_hang WHERE status = ? AND (ten LIKE ? OR id LIKE ?) ORDER BY ngayDat DESC";
        String searchPattern = "%" + keyword + "%";
        try {
            return jdbcTemplate.query(
                sql, new Object[]{status, searchPattern, searchPattern},
                (java.sql.ResultSet rs, int rowNum) -> {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setTen(rs.getString("ten"));
                    order.setDiaChi(rs.getString("diachi"));
                    order.setSdt(rs.getString("sdt"));
                    order.setNgayDat(rs.getTimestamp("ngayDat").toLocalDateTime());
                    order.setStatus(rs.getInt("status"));
                    order.setNgayDatFormatted(order.getNgayDatFormatted());
                    order.setThanhTien(rs.getBigDecimal("tongTien"));
                    order.setVoucherString(rs.getString("voucher"));
                    return order;
                }
            );
        } catch (Exception e) {
            return null;
        }
    }

    public List<Order> getOrdersByStatusAndTime(int status, LocalDateTime fromTime) {
        String sql = "SELECT * FROM don_hang WHERE status = ? AND ngayDat >= ? ORDER BY ngayDat DESC";
        try {
            return jdbcTemplate.query(
                sql, new Object[]{status, fromTime},
                (java.sql.ResultSet rs, int rowNum) -> {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setTen(rs.getString("ten"));
                    order.setDiaChi(rs.getString("diachi"));
                    order.setSdt(rs.getString("sdt"));
                    order.setNgayDat(rs.getTimestamp("ngayDat").toLocalDateTime());
                    order.setStatus(rs.getInt("status"));
                    order.setNgayDatFormatted(order.getNgayDatFormatted());
                    order.setThanhTien(rs.getBigDecimal("tongTien"));
                    order.setVoucherString(rs.getString("voucher"));
                    return order;
                }
            );
        } catch (Exception e) {
            return null;
        }
    }

    public boolean updateOrder(Order order) {
        String sql = "UPDATE don_hang SET status = ? WHERE id = ?";
        try {
            int rowsAffected = jdbcTemplate.update(sql, order.getStatus(), order.getId());
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Map<String, Object>> getRevenueByDay() {
        String sql = "SELECT DATE(ngaydat) AS Ngay, SUM(tongTien) AS DoanhThu, COUNT(*) AS SoDon " +
                     "FROM DON_HANG WHERE status = 4 GROUP BY DATE(ngaydat) ORDER BY Ngay DESC";
        return jdbcTemplate.queryForList(sql);
    }

    public List<Map<String, Object>> getRevenueByMonth() {
        String sql = "SELECT YEAR(ngaydat) AS Nam, MONTH(ngaydat) AS Thang, SUM(tongTien) AS DoanhThu, COUNT(*) AS SoDon " +
                     "FROM DON_HANG WHERE status = 4 GROUP BY YEAR(ngaydat), MONTH(ngaydat) ORDER BY Nam DESC, Thang DESC";
        return jdbcTemplate.queryForList(sql);
    }

    public List<Map<String, Object>> getRevenueByQuarter() {
        String sql = "SELECT YEAR(ngaydat) AS Nam, QUARTER(ngaydat) AS Quy, SUM(tongTien) AS DoanhThu, COUNT(*) AS SoDon " +
                     "FROM DON_HANG WHERE status = 4 GROUP BY YEAR(ngaydat), QUARTER(ngaydat) ORDER BY Nam DESC, Quy DESC";
        return jdbcTemplate.queryForList(sql);
    }

    public List<Map<String, Object>> getRevenueByYear() {
        String sql = "SELECT YEAR(ngaydat) AS Nam, SUM(tongTien) AS DoanhThu, COUNT(*) AS SoDon " +
                     "FROM DON_HANG WHERE status = 4 GROUP BY YEAR(ngaydat) ORDER BY Nam DESC";
        return jdbcTemplate.queryForList(sql);
    }

    public List<Order> getOrdersWaitingPayment() {
        String sql = "SELECT * FROM don_hang WHERE status IN (3, 4) ORDER BY ngaydat DESC";
        return jdbcTemplate.query(
            sql,
            (rs, rowNum) -> {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setTen(rs.getString("ten"));
                order.setDiaChi(rs.getString("diachi"));
                order.setSdt(rs.getString("sdt"));
                order.setNgayDat(rs.getTimestamp("ngaydat").toLocalDateTime());
                order.setStatus(rs.getInt("status"));
                order.setThanhTien(rs.getBigDecimal("tongTien"));
                order.setVoucherString(rs.getString("voucher"));
                return order;
            }
        );
    }

    public boolean confirmPayment(int orderId) {
        String sql = "UPDATE don_hang SET status = 4 WHERE id = ?";
        return jdbcTemplate.update(sql, orderId) > 0;
    }

    public boolean updateOrderTypeAndTable(int orderId, String loaiDon, Integer maBan, Integer soKhach) {
        String sql = "UPDATE don_hang SET loai_don = ?, ma_ban = ?, so_khach = ? WHERE id = ?";
        try {
            int rows = jdbcTemplate.update(sql, loaiDon, maBan, soKhach, orderId);
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateOrderStatus(int orderId, int status) {
        String sql = "UPDATE don_hang SET status = ? WHERE id = ?";
        try {
            int rows = jdbcTemplate.update(sql, status, orderId);
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
