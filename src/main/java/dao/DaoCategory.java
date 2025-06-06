package dao;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Repository;
import beans.Category;

@Repository
public class DaoCategory {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<Category> getAllCategories() {
        String sql = "SELECT * FROM DANH_MUC ORDER BY MaDM";
        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Category.class));
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public Category getCategoryById(int maDM) {
        String sql = "SELECT * FROM DANH_MUC WHERE MaDM = ?";
        try {
            return jdbcTemplate.queryForObject(sql, 
                new BeanPropertyRowMapper<>(Category.class), maDM);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public boolean addCategory(Category category) {
        String sql = "INSERT INTO DANH_MUC (TenDM) VALUES (?)";
        try {
            return jdbcTemplate.update(sql, category.getTenDM()) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateCategory(Category category) {
        String sql = "UPDATE DANH_MUC SET TenDM = ? WHERE MaDM = ?";
        try {
            return jdbcTemplate.update(sql, category.getTenDM(), category.getMaDM()) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteCategory(int maDM) {
        String sql = "DELETE FROM DANH_MUC WHERE MaDM = ?";
        try {
            return jdbcTemplate.update(sql, maDM) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Category> searchCategories(String keyword) {
        String sql = "SELECT * FROM DANH_MUC WHERE TenDM LIKE ? ORDER BY MaDM";
        try {
            return jdbcTemplate.query(sql, 
                new BeanPropertyRowMapper<>(Category.class), 
                "%" + keyword + "%");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
} 