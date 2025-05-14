package beans;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Order {
	private int id;
	private String ten;
	private String diaChi;
	private String sdt;
	private LocalDateTime ngayDat;
	private int status;
	private String ngayDatFormatted;
	private String voucher;
	private BigDecimal thanhTien;
	public String getVoucher() {
		return voucher;
	}
	public void setVoucher(String voucher) {
		this.voucher = voucher;
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
}
