package dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;
import beans.ProductDetail;

@Repository
public class DaoProductDetail {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public ProductDetail getProductDetailByProductId(int maSP) {
        String sql = "SELECT * FROM CHI_TIET_SAN_PHAM WHERE MaSP = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{maSP}, new RowMapper<ProductDetail>() {
                @Override
                public ProductDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
                    ProductDetail detail = new ProductDetail();
                    detail.setMaCTSP(rs.getInt("MaCTSP"));
                    detail.setMaSP(rs.getInt("MaSP"));
                    detail.setNguyenLieu(rs.getString("NguyenLieu"));
                    detail.setHuongDanSuDung(rs.getString("HuongDanSuDung"));
                    detail.setLoiIch(rs.getString("LoiIch"));
                    detail.setGhiChu(rs.getString("GhiChu"));
                    return detail;
                }
            });
        } catch (Exception e) {
            return null;
        }
    }
    
    public boolean save(ProductDetail detail) {
        String sql = "INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu) VALUES (?, ?, ?, ?, ?)";
        try {
            return jdbcTemplate.update(sql,
                detail.getMaSP(),
                detail.getNguyenLieu(),
                detail.getHuongDanSuDung(),
                detail.getLoiIch(),
                detail.getGhiChu()) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean update(ProductDetail detail) {
        String sql = "UPDATE CHI_TIET_SAN_PHAM SET NguyenLieu=?, HuongDanSuDung=?, LoiIch=?, GhiChu=? WHERE MaSP=?";
        try {
            return jdbcTemplate.update(sql,
                detail.getNguyenLieu(),
                detail.getHuongDanSuDung(),
                detail.getLoiIch(),
                detail.getGhiChu(),
                detail.getMaSP()) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean delete(int maSP) {
        String sql = "DELETE FROM CHI_TIET_SAN_PHAM WHERE MaSP=?";
        try {
            return jdbcTemplate.update(sql, maSP) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
} 