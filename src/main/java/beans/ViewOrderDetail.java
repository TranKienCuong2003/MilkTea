package beans;

import java.math.BigDecimal;

public class ViewOrderDetail {
	private String productName;
	private BigDecimal donGia;
	private String size;
	private String topping;
	private BigDecimal thanhTien;
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public BigDecimal getDonGia() {
		return donGia;
	}
	public void setDonGia(BigDecimal donGia) {
		this.donGia = donGia;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getTopping() {
		return topping;
	}
	public void setTopping(String topping) {
		this.topping = topping;
	}
	public BigDecimal getThanhTien() {
		return thanhTien;
	}
	public void setThanhTien(BigDecimal thanhTien) {
		this.thanhTien = thanhTien;
	}
}
