package beans;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Voucher {
	public int id;
	public String code;
	public String name;
	public String description;
	public LocalDateTime dateStart;
	public LocalDateTime dateEnd;
	public BigDecimal percentDiscount;
	public BigDecimal valueDiscount;
	public String type;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public LocalDateTime getDateStart() {
		return dateStart;
	}
	public void setDateStart(LocalDateTime dateStart) {
		this.dateStart = dateStart;
	}
	public LocalDateTime getDateEnd() {
		return dateEnd;
	}
	public void setDateEnd(LocalDateTime dateEnd) {
		this.dateEnd = dateEnd;
	}
	public BigDecimal getPercentDiscount() {
		return percentDiscount;
	}
	public void setPercentDiscount(BigDecimal percentDiscount) {
		this.percentDiscount = percentDiscount;
	}
	public BigDecimal getValueDiscount() {
		return valueDiscount;
	}
	public void setValueDiscount(BigDecimal valueDiscount) {
		this.valueDiscount = valueDiscount;
	}
	public Voucher(int id, String code, String name, String description, LocalDateTime dateStart, LocalDateTime dateEnd,
			BigDecimal percentDiscount, BigDecimal valueDiscount) {
		super();
		this.id = id;
		this.code = code;
		this.name = name;
		this.description = description;
		this.dateStart = dateStart;
		this.dateEnd = dateEnd;
		this.percentDiscount = percentDiscount;
		this.valueDiscount = valueDiscount;
	}
	public Voucher() {
		super();
		// TODO Auto-generated constructor stub
	}
	public java.util.Date getDateStartAsDate() {
		if (dateStart == null) return null;
		return java.util.Date.from(dateStart.atZone(java.time.ZoneId.systemDefault()).toInstant());
	}
	public java.util.Date getDateEndAsDate() {
		if (dateEnd == null) return null;
		return java.util.Date.from(dateEnd.atZone(java.time.ZoneId.systemDefault()).toInstant());
	}
}
