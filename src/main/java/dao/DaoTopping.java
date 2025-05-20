package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import beans.Size;
import beans.Topping;

@Repository
public class DaoTopping {
	 @Autowired
	    private JdbcTemplate jdbcTemplate;
	    
	    public List<Topping> getAllToppings() {
	        String sql = "SELECT * FROM topping WHERE trangthai = 1";
	        try {
	        	return jdbcTemplate.query(
	        		    sql,
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
	    
	    public List<Topping> getAllToppingsByKey(String key) {
	        String sql = "SELECT * FROM topping WHERE trangthai = 1 AND tenTopping like '%" + key + "%'";
	        try {
	        	return jdbcTemplate.query(
	        		    sql,
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
	    
	    public Topping getToppingById(int maTopping) {
	        String sql = "SELECT * FROM topping WHERE maTopping = ?";
	        return jdbcTemplate.queryForObject(sql, new Object[]{maTopping}, new RowMapper<Topping>() {
	            @Override
	            public Topping mapRow(ResultSet rs, int rowNum) throws SQLException {
	            	Topping topping = new Topping();
    		    	topping.setMaTopping(rs.getInt("maTopping"));
    		    	topping.setTenTopping(rs.getString("tenTopping"));
    		    	topping.setDonGia(rs.getBigDecimal("donGia"));
    		    	topping.setTrangThai(rs.getInt("trangThai"));
    		    	return topping;
	            }
	        });
	    }
}
