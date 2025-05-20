package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import beans.Supplier;
import beans.Warehouse;

@Repository
public class DaoSupplier {
	@Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<Supplier> list() {
    	String sql = "SELECT * FROM nhaCungCap";
        try {
        	return jdbcTemplate.query(
        		    sql,
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		    	Supplier supplier = new Supplier();
        		    	supplier.setCode(rs.getInt("maNhaCungCap"));
        		    	supplier.setName(rs.getString("tenNhaCungCap"));
        		    	supplier.setAddress(rs.getString("diaChi"));
        		    	supplier.setPhone(rs.getString("soDienThoai"));
        		    	return supplier;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }
    
    public int save(Supplier u) {
        String sql = "INSERT INTO nhaCungCap (TenNhaCungCap, diaChi, soDienThoai) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, 
            u.getName(),
            u.getAddress(),
            u.getPhone());
    }

    public void update(Supplier u) {
        String sql = "UPDATE nhaCungCap SET TenNhaCungCap=?, diaChi=?, soDienThoai=? WHERE maNhaCungCap=?";
        jdbcTemplate.update(sql, 
            u.getName(),
            u.getAddress(),
            u.getPhone(),
            u.getCode()
        );
    }
    
    public Supplier getSupplierById(int maNhaCungCap) {
    	String sql = "SELECT * FROM nhaCungCap WHERE maNhaCungCap = ? ";
        return jdbcTemplate.queryForObject(sql, new Object[]{maNhaCungCap}, 
        		(java.sql.ResultSet rs, int rowNum) -> {
        			Supplier supplier = new Supplier();
    		    	supplier.setCode(rs.getInt("maNhaCungCap"));
    		    	supplier.setName(rs.getString("tenNhaCungCap"));
    		    	supplier.setAddress(rs.getString("diaChi"));
    		    	supplier.setPhone(rs.getString("soDienThoai"));
    		    	return supplier;
	    }
	);
    }

    public int delete(int maNhaCungCap) {
        String sql = "DELETE FROM nhaCungCap WHERE maNhaCungCap = ?";
        return jdbcTemplate.update(sql, maNhaCungCap);
    }
}
