package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import beans.Warehouse;

@Repository
public class DaoWarehouse {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Warehouse> list() {
        String sql = "SELECT k.*, n.TenNhaCungCap as supplierName FROM kho k " +
                    "LEFT JOIN nhaCungCap n ON k.maNhaCungCap = n.maNhaCungCap";
        try {
            return jdbcTemplate.query(
                sql,
                (java.sql.ResultSet rs, int rowNum) -> {
                    Warehouse warehouse = new Warehouse();
                    warehouse.setCode(rs.getInt("maNguyenLieu"));
                    warehouse.setName(rs.getString("tenNguyenLieu"));
                    warehouse.setQuantity(rs.getDouble("soLuong"));
                    warehouse.setAddress(rs.getString("donViTinh"));
                    warehouse.setImportDate(rs.getDate("ngayNhap"));
                    warehouse.setExpiryDate(rs.getDate("hanSuDung"));
                    warehouse.setSupplierId(rs.getInt("maNhaCungCap"));
                    warehouse.setNote(rs.getString("ghiChu"));
                    warehouse.setSupplierName(rs.getString("supplierName"));
                    return warehouse;
                }
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int save(Warehouse u) {
        String sql = "INSERT INTO kho (tenNguyenLieu, soLuong, donViTinh, ngayNhap, hanSuDung, maNhaCungCap, ghiChu) VALUES (?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, 
            u.getName(),
            u.getQuantity(),
            u.getAddress(),
            u.getImportDate(),
            u.getExpiryDate(),
            u.getSupplierId(),
            u.getNote()
        );
    }

    public void update(Warehouse u) {
        String sql = "UPDATE kho SET tenNguyenLieu=?, soLuong=?, donViTinh=?, ngayNhap=?, hanSuDung=?, maNhaCungCap=?, ghiChu=? WHERE maNguyenLieu=?";
        jdbcTemplate.update(sql, 
            u.getName(),
            u.getQuantity(),
            u.getAddress(),
            u.getImportDate(),
            u.getExpiryDate(),
            u.getSupplierId(),
            u.getNote(),
            u.getCode()
        );
    }

    public Warehouse getWarehouseById(int code) {
        String sql = "SELECT k.*, n.TenNhaCungCap as supplierName FROM kho k " +
                    "LEFT JOIN nhaCungCap n ON k.maNhaCungCap = n.maNhaCungCap " +
                    "WHERE k.maNguyenLieu = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{code}, 
            (java.sql.ResultSet rs, int rowNum) -> {
                Warehouse warehouse = new Warehouse();
                warehouse.setCode(rs.getInt("maNguyenLieu"));
                warehouse.setName(rs.getString("tenNguyenLieu"));
                warehouse.setQuantity(rs.getDouble("soLuong"));
                warehouse.setAddress(rs.getString("donViTinh"));
                warehouse.setImportDate(rs.getDate("ngayNhap"));
                warehouse.setExpiryDate(rs.getDate("hanSuDung"));
                warehouse.setSupplierId(rs.getInt("maNhaCungCap"));
                warehouse.setNote(rs.getString("ghiChu"));
                warehouse.setSupplierName(rs.getString("supplierName"));
                return warehouse;
            }
        );
    }

    public int delete(int code) {
        String sql = "DELETE FROM kho WHERE maNguyenLieu = ?";
        return jdbcTemplate.update(sql, code);
    }
}
