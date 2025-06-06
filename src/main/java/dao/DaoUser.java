package dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import beans.Permission;
import beans.Product;
import beans.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@Repository
public class DaoUser {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public User checkLogin(String username, String password) {
        String sql = "SELECT nd.*, pq.TenQuyen FROM NGUOI_DUNG nd " +
                     "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                     "WHERE nd.TenDangNhap = ? AND nd.MatKhau = ? AND nd.TrangThai = true";
        try {
        	return jdbcTemplate.queryForObject(
        		    sql,
        		    new Object[]{ username, password },
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		        User user = new User();
        		        user.setMaNd(rs.getInt("MaND"));
        		        user.setHoTen(rs.getString("HoTen"));
        		        user.setTenDangNhap(rs.getString("TenDangNhap"));
        		        user.setEmail(rs.getString("Email"));
        		        user.setSoDienThoai(rs.getString("SoDienThoai"));
        		        user.setDiaChi(rs.getString("DiaChi"));
        		        user.setMaQuyen(rs.getInt("MaQuyen"));
        		        user.setTrangThai(rs.getBoolean("TrangThai"));
        		        user.setNgayTao(rs.getTimestamp("NgayTao"));
        		        user.setTenQuyen(rs.getString("TenQuyen"));
        		        user.setAnhDaiDien(rs.getString("AnhDaiDien"));
        		        return user;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }
    
    public List<User> list(int permission) {
    	//permission = 0 -> chủ quán
    	//permission = 1 -> quản lý
    	String sql = "";
    	if(permission == 0) {
    		sql = "SELECT nd.*, pq.TenQuyen FROM NGUOI_DUNG nd " +
                    "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                    "WHERE nd.TrangThai = true "
                    + "AND (pq.TenQuyen = 'Nhân viên kho' OR pq.TenQuyen = 'Nhân viên order'"
                    + " OR pq.TenQuyen = 'Nhân viên pha chế' OR pq.TenQuyen = 'Nhân viên thu ngân' "
                    + "OR pq.TenQuyen = 'Chủ quán' OR pq.TenQuyen = 'Quản lý')";
    	}else if(permission == 1) {
    		sql = "SELECT nd.*, pq.TenQuyen FROM NGUOI_DUNG nd " +
                    "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                    "WHERE nd.TrangThai = true "
                    + "AND (pq.TenQuyen = 'Nhân viên kho' OR pq.TenQuyen = 'Nhân viên order'"
                    + " OR pq.TenQuyen = 'Nhân viên pha chế' OR pq.TenQuyen = 'Nhân viên thu ngân' "
                    + "OR pq.TenQuyen = 'Quản lý')";
    	}
        try {
        	return jdbcTemplate.query(
        		    sql,
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		        User user = new User();
        		        user.setMaNd(rs.getInt("MaND"));
        		        user.setHoTen(rs.getString("HoTen"));
        		        user.setTenDangNhap(rs.getString("TenDangNhap"));
        		        user.setMatKhau(rs.getString("MatKhau"));
        		        user.setEmail(rs.getString("Email"));
        		        user.setSoDienThoai(rs.getString("SoDienThoai"));
        		        user.setDiaChi(rs.getString("DiaChi"));
        		        user.setMaQuyen(rs.getInt("MaQuyen"));
        		        user.setTrangThai(rs.getBoolean("TrangThai"));
        		        user.setNgayTao(rs.getTimestamp("NgayTao"));
        		        user.setTenQuyen(rs.getString("TenQuyen"));
        		        user.setAnhDaiDien(rs.getString("AnhDaiDien"));
        		        return user;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }
    
    public int save(User u) {
        String sql = "INSERT INTO nguoi_dung (HoTen, TenDangNhap, MatKhau, Email, SoDienThoai, MaQuyen, DiaChi, AnhDaiDien, TrangThai, NgayTao) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, 
            u.getHoTen(),
            u.getTenDangNhap(),
            u.getMatKhau(),
            u.getEmail(),
            u.getSoDienThoai(),
            u.getMaQuyen(),
            u.getDiaChi(),
            u.getAnhDaiDien(),
            1,
            LocalDate.now());
    }
    
    public String getUserName(String permission) {
        String sql = "SELECT nd.TenDangNhap FROM NGUOI_DUNG nd " +
                "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                "WHERE pq.TenQuyen = ? ORDER BY nd.TenDangNhap DESC";
        return jdbcTemplate.queryForObject(
    		    sql,
    		    new Object[]{ permission },
    		    (java.sql.ResultSet rs, int rowNum) -> {
    		    	String TenDangNhapOld = "";
    		    	String TenDangNhapNew = "";
    		    	if(rs.getRow() > 0)
    		    		TenDangNhapOld = rs.getString("TenDangNhap");
    		    	switch(permission.toLowerCase()) {
    		    	case "nhân viên kho":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "kho01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(3));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "kho0" + num;
    		    			}else {
    		    				TenDangNhapNew = "kho" + num;
    		    			}
    		    		}
    		    		break;
    		    	case "nhân viên order":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "order01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(5));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "order0" + num;
    		    			}else {
    		    				TenDangNhapNew = "order" + num;
    		    			}
    		    		}
    		    		break;
    		    	case "nhân viên pha chế":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "phache01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(6));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "phache0" + num;
    		    			}else {
    		    				TenDangNhapNew = "phache" + num;
    		    			}
    		    		}
    		    		break;
    		    	case "nhân viên thu ngân":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "thungan01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(7));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "thungan0" + num;
    		    			}else {
    		    				TenDangNhapNew = "thungan" + num;
    		    			}
    		    		}
    		    		break;
    		    	case "chủ quán":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "chuquan01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(7));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "chuquan0" + num;
    		    			}else {
    		    				TenDangNhapNew = "chuquan" + num;
    		    			}
    		    		}
    		    		break;
    		    	case "quản lý":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "quanly01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(6));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "quanly0" + num;
    		    			}else {
    		    				TenDangNhapNew = "quanly" + num;
    		    			}
    		    		}
    		    		break;
    		    }
    		        return TenDangNhapNew;
    		    }
    		);
    }
    
    public int getPermission(String permission) {
        String sql = "SELECT * FROM " +
                "PHAN_QUYEN " +
                "WHERE "
                + "TenQuyen = ?";
        return jdbcTemplate.queryForObject(
    		    sql,
    		    new Object[]{ permission },
    		    (java.sql.ResultSet rs, int rowNum) -> {
    		        return rs.getInt("MaQuyen");
    		    }
    		);
    }

    public void updateUser(User user) {
        String sql = "UPDATE NGUOI_DUNG SET HoTen=?, Email=?, SoDienThoai=?, DiaChi=? WHERE MaND=?";
        jdbcTemplate.update(sql, 
            user.getHoTen(),
            user.getEmail(),
            user.getSoDienThoai(),
            user.getDiaChi(),
            user.getMaNd()
        );
    }

    public void updateAvatar(int userId, String avatarPath) {
        String sql = "UPDATE NGUOI_DUNG SET AnhDaiDien=? WHERE MaND=?";
        jdbcTemplate.update(sql, avatarPath, userId);
    }

    public boolean checkPassword(String username, String password) {
        String sql = "SELECT COUNT(*) FROM NGUOI_DUNG WHERE TenDangNhap=? AND MatKhau=?";
        int count = jdbcTemplate.queryForObject(sql, Integer.class, username, password);
        return count > 0;
    }

    public void updatePassword(String username, String newPassword) {
        String sql = "UPDATE NGUOI_DUNG SET MatKhau=? WHERE TenDangNhap=?";
        jdbcTemplate.update(sql, newPassword, username);
    }

    private User mapUser(ResultSet rs, int rowNum) throws SQLException {
        User user = new User();
        user.setMaNd(rs.getInt("MaND"));
        user.setTenDangNhap(rs.getString("TenDangNhap"));
        user.setMatKhau(rs.getString("MatKhau"));
        user.setHoTen(rs.getString("HoTen"));
        user.setEmail(rs.getString("Email"));
        user.setSoDienThoai(rs.getString("SoDienThoai"));
        user.setDiaChi(rs.getString("DiaChi"));
        user.setMaQuyen(rs.getInt("MaQuyen"));
        user.setAnhDaiDien(rs.getString("AnhDaiDien"));
        return user;
    }
    
    public int update(User u) {
        String sql = "UPDATE Nguoi_Dung SET HoTen = ?, Email = ?, SoDienThoai = ?, MaQuyen = ?, DiaChi = ?, AnhDaiDien = ? WHERE MaND = ?";
        return jdbcTemplate.update(sql, 
            u.getHoTen(),
            u.getEmail(),
            u.getSoDienThoai(),
            u.getMaQuyen(),
            u.getDiaChi(),
            u.getAnhDaiDien(),
            u.getMaNd());
    }
    
    public User getUserById(int maNd) {
    	String sql = "SELECT nd.*, pq.TenQuyen FROM NGUOI_DUNG nd " +
                "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                "WHERE nd.TrangThai = true "
                + "AND (pq.TenQuyen = 'Nhân viên kho' OR pq.TenQuyen = 'Nhân viên order'"
                + " OR pq.TenQuyen = 'Nhân viên pha chế' OR pq.TenQuyen = 'Nhân viên thu ngân' "
                + "OR pq.TenQuyen = 'Chủ quán' OR pq.TenQuyen = 'Quản lý')"
                + " AND nd.MaNd = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{maNd}, 
        		(java.sql.ResultSet rs, int rowNum) -> {
	        User user = new User();
	        user.setMaNd(rs.getInt("MaND"));
	        user.setHoTen(rs.getString("HoTen"));
	        user.setTenDangNhap(rs.getString("TenDangNhap"));
	        user.setEmail(rs.getString("Email"));
	        user.setSoDienThoai(rs.getString("SoDienThoai"));
	        user.setDiaChi(rs.getString("DiaChi"));
	        user.setMaQuyen(rs.getInt("MaQuyen"));
	        user.setTrangThai(rs.getBoolean("TrangThai"));
	        user.setNgayTao(rs.getTimestamp("NgayTao"));
	        user.setTenQuyen(rs.getString("TenQuyen"));
	        user.setAnhDaiDien(rs.getString("AnhDaiDien"));
	        return user;
	    }
	);
    }

    public int delete(int maNd) {
        String sql = "DELETE FROM Nguoi_Dung WHERE MaND = ?";
        return jdbcTemplate.update(sql, maNd);
    }

    public boolean existsByUsername(String username) {
        String sql = "SELECT COUNT(*) FROM NGUOI_DUNG WHERE TenDangNhap = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, username);
        return count != null && count > 0;
    }

    public boolean existsByEmail(String email) {
        String sql = "SELECT COUNT(*) FROM NGUOI_DUNG WHERE Email = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email);
        return count != null && count > 0;
    }

    public int saveWithToken(User u) {
        String sql = "INSERT INTO NGUOI_DUNG (HoTen, TenDangNhap, MatKhau, Email, SoDienThoai, MaQuyen, DiaChi, AnhDaiDien, TrangThai, NgayTao, xacThucToken) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, 
            u.getHoTen(),
            u.getTenDangNhap(),
            u.getMatKhau(),
            u.getEmail(),
            u.getSoDienThoai(),
            u.getMaQuyen(),
            u.getDiaChi(),
            u.getAnhDaiDien(),
            false, // TrangThai: chưa xác thực
            LocalDate.now(),
            u.getXacThucToken()
        );
    }

    public User findByToken(String token) {
        String sql = "SELECT * FROM NGUOI_DUNG WHERE xacThucToken = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{token}, (rs, rowNum) -> {
                User user = new User();
                user.setMaNd(rs.getInt("MaND"));
                user.setHoTen(rs.getString("HoTen"));
                user.setTenDangNhap(rs.getString("TenDangNhap"));
                user.setMatKhau(rs.getString("MatKhau"));
                user.setEmail(rs.getString("Email"));
                user.setSoDienThoai(rs.getString("SoDienThoai"));
                user.setMaQuyen(rs.getInt("MaQuyen"));
                user.setDiaChi(rs.getString("DiaChi"));
                user.setAnhDaiDien(rs.getString("AnhDaiDien"));
                user.setTrangThai(rs.getBoolean("TrangThai"));
                user.setXacThucToken(rs.getString("xacThucToken"));
                return user;
            });
        } catch (Exception e) {
            return null;
        }
    }

    public void verifyUser(User user) {
        String sql = "UPDATE NGUOI_DUNG SET TrangThai = true, xacThucToken = NULL WHERE MaND = ?";
        jdbcTemplate.update(sql, user.getMaNd());
    }

    public int saveWithOtp(User u) {
        String sql = "INSERT INTO NGUOI_DUNG (HoTen, TenDangNhap, MatKhau, Email, SoDienThoai, MaQuyen, DiaChi, AnhDaiDien, TrangThai, NgayTao, otpCode) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
            u.getHoTen(),
            u.getTenDangNhap(),
            u.getMatKhau(),
            u.getEmail(),
            u.getSoDienThoai(),
            u.getMaQuyen(),
            u.getDiaChi(),
            u.getAnhDaiDien(),
            false,
            java.sql.Timestamp.valueOf(java.time.LocalDateTime.now()),
            u.getOtpCode()
        );
    }

    public User findByEmail(String email) {
        String sql = "SELECT * FROM NGUOI_DUNG WHERE Email = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{email}, (rs, rowNum) -> mapUser(rs, rowNum));
        } catch (Exception e) {
            return null;
        }
    }

    public boolean verifyOtp(String email, String otp) {
        String sql = "SELECT * FROM NGUOI_DUNG WHERE Email = ? AND otpCode = ?";
        try {
            User user = jdbcTemplate.queryForObject(sql, new Object[]{email, otp}, (rs, rowNum) -> mapUser(rs, rowNum));
            if (user != null) {
                String updateSql = "UPDATE NGUOI_DUNG SET TrangThai = 1, otpCode = NULL WHERE Email = ?";
                jdbcTemplate.update(updateSql, email);
                return true;
            }
        } catch (Exception e) {
            // Không tìm thấy user hoặc sai mã
        }
        return false;
    }

    public void updateOtpCode(String email, String otp) {
        String sql = "UPDATE NGUOI_DUNG SET otpCode = ? WHERE Email = ?";
        jdbcTemplate.update(sql, otp, email);
    }

    public void updateEmailWithOtp(int userId, String newEmail, String otp) {
        String sql = "UPDATE NGUOI_DUNG SET Email = ?, otpCode = ? WHERE MaND = ?";
        jdbcTemplate.update(sql, newEmail, otp, userId);
    }

    public boolean verifyNewEmailOtp(int userId, String otp) {
        String sql = "SELECT COUNT(*) FROM NGUOI_DUNG WHERE MaND = ? AND otpCode = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId, otp);
        if (count != null && count > 0) {
            // Clear OTP after successful verification
            String clearOtpSql = "UPDATE NGUOI_DUNG SET otpCode = NULL WHERE MaND = ?";
            jdbcTemplate.update(clearOtpSql, userId);
            return true;
        }
        return false;
    }

    public List<User> findByRoleRange(int from, int to) {
        String sql = "SELECT nd.*, pq.TenQuyen FROM NGUOI_DUNG nd " +
                "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                "WHERE nd.TrangThai = true AND nd.MaQuyen >= ? AND nd.MaQuyen <= ?";
        try {
            return jdbcTemplate.query(
                sql,
                new Object[]{from, to},
                (ResultSet rs, int rowNum) -> {
                    User user = new User();
                    user.setMaNd(rs.getInt("MaND"));
                    user.setHoTen(rs.getString("HoTen"));
                    user.setTenDangNhap(rs.getString("TenDangNhap"));
                    user.setMatKhau(rs.getString("MatKhau"));
                    user.setEmail(rs.getString("Email"));
                    user.setSoDienThoai(rs.getString("SoDienThoai"));
                    user.setDiaChi(rs.getString("DiaChi"));
                    user.setMaQuyen(rs.getInt("MaQuyen"));
                    user.setTrangThai(rs.getBoolean("TrangThai"));
                    user.setNgayTao(rs.getTimestamp("NgayTao"));
                    user.setTenQuyen(rs.getString("TenQuyen"));
                    user.setAnhDaiDien(rs.getString("AnhDaiDien"));
                    return user;
                }
            );
        } catch (Exception e) {
            return null;
        }
    }

    // Lưu OTP cho user (dùng cho quên mật khẩu)
    public void saveOtp(int maNd, String otp) {
        String sql = "UPDATE NGUOI_DUNG SET otpCode = ? WHERE MaND = ?";
        jdbcTemplate.update(sql, otp, maNd);
    }

    // Đổi mật khẩu theo email (dùng cho quên mật khẩu)
    public void updatePasswordByEmail(String email, String newPassword) {
        String sql = "UPDATE NGUOI_DUNG SET MatKhau = ? WHERE Email = ?";
        jdbcTemplate.update(sql, newPassword, email);
    }
} 