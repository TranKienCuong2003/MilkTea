package beans;

import java.sql.Date;

public class Warehouse {
    private Integer code;
    private String name;
    private Double quantity;
    private String address; // đơn vị tính
    private Date importDate;
    private Date expiryDate;
    private Integer supplierId;
    private String note;
    private String supplierName; // chỉ dùng để hiển thị

    public Integer getCode() {
        return code;
    }
    public void setCode(Integer code) {
        this.code = code;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public Double getQuantity() {
        return quantity;
    }
    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public Date getImportDate() {
        return importDate;
    }
    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }
    public Date getExpiryDate() {
        return expiryDate;
    }
    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
    public Integer getSupplierId() {
        return supplierId;
    }
    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }
    public String getNote() {
        return note;
    }
    public void setNote(String note) {
        this.note = note;
    }
    public String getSupplierName() {
        return supplierName;
    }
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public Warehouse() {
        super();
    }

    public Warehouse(Integer code, String name, Double quantity, String address, Date importDate, Date expiryDate, Integer supplierId, String note, String supplierName) {
        super();
        this.code = code;
        this.name = name;
        this.quantity = quantity;
        this.address = address;
        this.importDate = importDate;
        this.expiryDate = expiryDate;
        this.supplierId = supplierId;
        this.note = note;
        this.supplierName = supplierName;
    }
}