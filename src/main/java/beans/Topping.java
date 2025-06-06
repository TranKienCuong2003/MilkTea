package beans;

import java.math.BigDecimal;

public class Topping {
	private int maTopping;
	private String tenTopping;
	private BigDecimal donGia;
	private int trangThai;
	public int getMaTopping() {
		return maTopping;
	}
	public void setMaTopping(int maTopping) {
		this.maTopping = maTopping;
	}
	public String getTenTopping() {
		return tenTopping;
	}
	public void setTenTopping(String tenTopping) {
		this.tenTopping = tenTopping;
	}
	public BigDecimal getDonGia() {
		return donGia;
	}
	public void setDonGia(BigDecimal donGia) {
		this.donGia = donGia;
	}
	public int getTrangThai() {
		return trangThai;
	}
	public void setTrangThai(int trangThai) {
		this.trangThai = trangThai;
	}
	
	
}
