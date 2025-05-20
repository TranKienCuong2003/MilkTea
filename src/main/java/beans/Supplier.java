package beans;

public class Supplier {
	private int code;
	private String name;
	private String address;
	private String phone;
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Supplier(int code, String name, String address, String phone) {
		super();
		this.code = code;
		this.name = name;
		this.address = address;
		this.phone = phone;
	}
	public Supplier() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
