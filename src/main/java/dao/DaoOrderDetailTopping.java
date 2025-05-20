package dao;

import java.sql.PreparedStatement;
import java.sql.Statement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import beans.OrderDetailTopping;

@Repository
public class DaoOrderDetailTopping {
	@Autowired
    private JdbcTemplate jdbcTemplate;
	
	public int add(OrderDetailTopping orderDetailTopping) {
        String sql = "INSERT INTO chi_tiet_don_hang_topping (chi_tiet_don_hang, topping) VALUES (?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        try {
        	jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, orderDetailTopping.getChiTietDonHang());
                ps.setInt(2, orderDetailTopping.getTopping());
                return ps;
            }, keyHolder);

            return keyHolder.getKey().intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }
}
