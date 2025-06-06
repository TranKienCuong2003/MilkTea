package dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.NonNull;

import beans.Product;

@Repository
public class DaoProduct {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    // Thêm sản phẩm mới
    public int save(Product p) {
        String sql = "INSERT INTO SAN_PHAM (TenSP, DonGia, MaDM, MoTa, HinhAnh, SoLuong, TrangThai) VALUES (?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, 
            p.getTenSP(), 
            p.getDonGia(), 
            p.getMaDM(), 
            p.getMoTa(), 
            p.getHinhAnh(),
            p.getSoLuong(),
            p.isTrangThai());
    }

    // Cập nhật sản phẩm
    public int update(Product p) {
        String sql = "UPDATE SAN_PHAM SET TenSP = ?, DonGia = ?, MaDM = ?, MoTa = ?, HinhAnh = ?, SoLuong = ?, TrangThai = ? WHERE MaSP = ?";
        return jdbcTemplate.update(sql, 
            p.getTenSP(), 
            p.getDonGia(), 
            p.getMaDM(), 
            p.getMoTa(), 
            p.getHinhAnh(),
            p.getSoLuong(),
            p.isTrangThai(),
            p.getMaSP());
    }

    // Xoá sản phẩm
    public int delete(int maSP) {
        try {
            // Xóa chi tiết sản phẩm trước
            String deleteDetailSql = "DELETE FROM CHI_TIET_SAN_PHAM WHERE MaSP = ?";
            jdbcTemplate.update(deleteDetailSql, maSP);
            
            // Sau đó xóa sản phẩm
        String sql = "DELETE FROM SAN_PHAM WHERE MaSP = ?";
        return jdbcTemplate.update(sql, maSP);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // Lấy sản phẩm theo ID
    public Product getProductById(int maSP) {
        String sql = "SELECT * FROM SAN_PHAM WHERE MaSP = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{maSP}, new RowMapper<Product>() {
            @Override
            public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
                Product product = new Product();
                product.setMaSP(rs.getInt("MaSP"));
                product.setTenSP(rs.getString("TenSP"));
                product.setDonGia(rs.getBigDecimal("DonGia"));
                product.setMaDM(rs.getInt("MaDM"));
                product.setMoTa(rs.getString("MoTa"));
                product.setHinhAnh(rs.getString("HinhAnh"));
                product.setSoLuong(rs.getInt("SoLuong"));
                product.setTrangThai(rs.getBoolean("TrangThai"));
                return product;
            }
        });
    }

    // Lấy danh sách tất cả sản phẩm
    public List<Product> getProducts() {
        String sql = "SELECT * FROM SAN_PHAM";
        return jdbcTemplate.query(sql, new RowMapper<Product>() {
            @Override
            public Product mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                Product product = new Product();
                product.setMaSP(rs.getInt("MaSP"));
                product.setTenSP(rs.getString("TenSP"));
                product.setDonGia(rs.getBigDecimal("DonGia"));
                product.setMaDM(rs.getInt("MaDM"));
                product.setMoTa(rs.getString("MoTa"));
                product.setHinhAnh(rs.getString("HinhAnh"));
                product.setSoLuong(rs.getInt("SoLuong"));
                product.setTrangThai(rs.getBoolean("TrangThai"));
                return product;
            }
        });
    }

    // Lấy tổng số sản phẩm
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM SAN_PHAM";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    // Lấy sản phẩm theo trang
    public List<Product> getProductsByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM SAN_PHAM ORDER BY MaSP LIMIT ?, ?";
        return jdbcTemplate.query(sql, new Object[]{offset, pageSize}, new RowMapper<Product>() {
            @Override
            public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
                Product product = new Product();
                product.setMaSP(rs.getInt("MaSP"));
                product.setTenSP(rs.getString("TenSP"));
                product.setDonGia(rs.getBigDecimal("DonGia"));
                product.setMaDM(rs.getInt("MaDM"));
                product.setMoTa(rs.getString("MoTa"));
                product.setHinhAnh(rs.getString("HinhAnh"));
                product.setSoLuong(rs.getInt("SoLuong"));
                product.setTrangThai(rs.getBoolean("TrangThai"));
                return product;
            }
        });
    }

    public List<Product> searchProducts(String keyword, Integer category) {
        StringBuilder sql = new StringBuilder("SELECT * FROM SAN_PHAM WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (TenSP LIKE ? OR MoTa LIKE ?)");
            String searchTerm = "%" + keyword.trim() + "%";
            params.add(searchTerm);
            params.add(searchTerm);
        }
        
        if (category != null && category > 0) {
            sql.append(" AND MaDM = ?");
            params.add(category);
        }
        
        sql.append(" ORDER BY MaSP DESC");
        
        try {
            return jdbcTemplate.query(sql.toString(), 
                params.toArray(), 
                new RowMapper<Product>() {
                    @Override
                    public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Product product = new Product();
                        product.setMaSP(rs.getInt("MaSP"));
                        product.setTenSP(rs.getString("TenSP"));
                        product.setDonGia(rs.getBigDecimal("DonGia"));
                        product.setMaDM(rs.getInt("MaDM"));
                        product.setMoTa(rs.getString("MoTa"));
                        product.setHinhAnh(rs.getString("HinhAnh"));
                        product.setSoLuong(rs.getInt("SoLuong"));
                        product.setTrangThai(rs.getBoolean("TrangThai"));
                        return product;
                    }
                });
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}
