package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import beans.Product;
import beans.Size;

@Repository
public class DaoSize {
	@Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<Size> getAllSizes() {
        String sql = "SELECT * FROM size_san_pham";
        try {
        	return jdbcTemplate.query(
        		    sql,
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		    	Size size = new Size();
        		    	size.setMaSize(rs.getInt("maSize"));
        		    	size.setTenSize(rs.getString("tenSize"));
        		    	size.setHeSoGia(rs.getBigDecimal("heSoGia"));
        		    	return size;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }
    
    public Size getSizeById(int maSize) {
        String sql = "SELECT * FROM size_san_pham WHERE MaSize = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{maSize}, new RowMapper<Size>() {
            @Override
            public Size mapRow(ResultSet rs, int rowNum) throws SQLException {
            	Size size = new Size();
		    	size.setMaSize(rs.getInt("maSize"));
		    	size.setTenSize(rs.getString("tenSize"));
		    	size.setHeSoGia(rs.getBigDecimal("heSoGia"));
		    	return size;
            }
        });
    }
}
