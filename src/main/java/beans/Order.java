package beans;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Arrays;

public class Order {
	private int id;
	private String ten;
	private String diaChi;
	private String sdt;
	private LocalDateTime ngayDat;
	private int status;
	private String ngayDatFormatted;
	private List<String> vouchers;
	private BigDecimal thanhTien;
	private BigDecimal discountAmount;
	private String discountType;
	private BigDecimal discountValue;
	
	public List<String> getVouchers() {
		return vouchers;
	}
	public void setVouchers(List<String> vouchers) {
		this.vouchers = vouchers;
	}
	public void setVoucherString(String voucherStr) {
		if (voucherStr != null && !voucherStr.trim().isEmpty()) {
			this.vouchers = Arrays.asList(voucherStr.split(","));
		} else {
			this.vouchers = null;
		}
	}
	public String getVoucherString() {
		if (vouchers == null || vouchers.isEmpty()) return null;
		return String.join(",", vouchers);
	}
	public BigDecimal getThanhTien() {
		return thanhTien;
	}
	public void setThanhTien(BigDecimal thanhTien) {
		this.thanhTien = thanhTien;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTen() {
		return ten;
	}
	public void setTen(String ten) {
		this.ten = ten;
	}
	public String getDiaChi() {
		return diaChi;
	}
	public void setDiaChi(String diaChi) {
		this.diaChi = diaChi;
	}
	public String getSdt() {
		return sdt;
	}
	public void setSdt(String sdt) {
		this.sdt = sdt;
	}
	public LocalDateTime getNgayDat() {
		return ngayDat;
	}
	public void setNgayDat(LocalDateTime ngayDat) {
		this.ngayDat = ngayDat;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	public void setNgayDatFormatted(String ngayDatFormatted) {
		this.ngayDatFormatted = ngayDatFormatted;
	}
	public String getNgayDatFormatted() {
	    if (ngayDat != null) {
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	        return ngayDat.format(formatter);
	    }
	    return "";
	}
	
	public BigDecimal getDiscountAmount() {
		return discountAmount;
	}
	public void setDiscountAmount(BigDecimal discountAmount) {
		this.discountAmount = discountAmount;
	}
	public String getDiscountType() {
		return discountType;
	}
	public void setDiscountType(String discountType) {
		this.discountType = discountType;
	}
	public BigDecimal getDiscountValue() {
		return discountValue;
	}
	public void setDiscountValue(BigDecimal discountValue) {
		this.discountValue = discountValue;
	}
}
