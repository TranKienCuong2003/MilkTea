package dao;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import beans.Voucher;

@Repository
public class DaoVoucher {
	@Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<Voucher> list() {
    	String sql = "SELECT * FROM voucher";
        try {
        	return jdbcTemplate.query(
        		    sql,
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		    	Voucher voucher = new Voucher();
        		    	voucher.setCode(rs.getString("ma"));
        		    	voucher.setDateEnd(rs.getObject("ngayketthuc", LocalDateTime.class));
        		    	voucher.setDateStart(rs.getObject("ngaybatdau", LocalDateTime.class));
        		    	voucher.setDescription(rs.getString("mota"));
        		    	voucher.setId(rs.getInt("id"));
        		    	voucher.setName(rs.getString("ten"));
        		    	voucher.setPercentDiscount(rs.getBigDecimal("phantramgiamgia"));
        		    	voucher.setValueDiscount(rs.getBigDecimal("giatrigiamgia"));
        		    	return voucher;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }
    
    public int save(Voucher u) {
        String sql = "INSERT INTO voucher (ma, ten, mota, ngaybatdau, ngayketthuc, phantramgiamgia, giatrigiamgia) VALUES (?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, 
            u.getCode(),
            u.getName(),
            u.getDescription(),
            java.sql.Timestamp.valueOf(u.getDateStart()),
            java.sql.Timestamp.valueOf(u.getDateEnd()),
            u.getPercentDiscount(),
            u.getValueDiscount());
    }
    
    public Boolean checkCode(String code) {
    	String sql = "SELECT * FROM voucher WHERE ma = ?";
        try {
        	if(jdbcTemplate.queryForObject(
        		    sql,
        		    new Object[]{ code },
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		    	return rs.getRow();
        		    }
        		) == 0){
        		return true;
        	}else {
        		return false;
        	}
        } catch (Exception e) {
            return true;
        }
    }
    
    public String generateCodeCheck() {
    	while(true) {
    		String code = generateCodeNoCheck(6);
            if(checkCode(code)) {
            	return code;
            }
    	}
    }
    
    public String generateCodeNoCheck(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(characters.length());
            result.append(characters.charAt(index));
        }

        return result.toString();
    }

    public void update(Voucher u) {
        String sql = "UPDATE voucher SET ten=?, mota=?, ngaybatdau=?, ngayketthuc=?, phantramgiamgia=?, giatrigiamgia=? WHERE ma=?";
        jdbcTemplate.update(sql,
                u.getName(),
                u.getDescription(),
                java.sql.Timestamp.valueOf(u.getDateStart()),
                java.sql.Timestamp.valueOf(u.getDateEnd()),
                u.getPercentDiscount(),
                u.getValueDiscount(),
                u.getCode()
        );
    }
    
    public Voucher getVoucherById(String ma) {
    	String sql = "SELECT * FROM voucher WHERE ma = ? ";
        return jdbcTemplate.queryForObject(sql, new Object[]{ma}, 
        		(java.sql.ResultSet rs, int rowNum) -> {
        			Voucher voucher = new Voucher();
    		    	voucher.setCode(rs.getString("ma"));
    		    	voucher.setDateEnd(rs.getObject("ngayketthuc", LocalDateTime.class));
    		    	voucher.setDateStart(rs.getObject("ngaybatdau", LocalDateTime.class));
    		    	voucher.setDescription(rs.getString("mota"));
    		    	voucher.setId(rs.getInt("id"));
    		    	voucher.setName(rs.getString("ten"));
    		    	voucher.setPercentDiscount(rs.getBigDecimal("phantramgiamgia"));
    		    	voucher.setValueDiscount(rs.getBigDecimal("giatrigiamgia"));
    		    	return voucher;
	    }
	);
    }

    public int delete(String ma) {
        String sql = "DELETE FROM voucher WHERE ma = ?";
        return jdbcTemplate.update(sql, ma);
    }
}
