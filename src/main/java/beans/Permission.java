package beans;

public class Permission {
	private int maQuyen;
    private String tenQuyen;
	public int getMaQuyen() {
		return maQuyen;
	}
	public void setMaQuyen(int maQuyen) {
		this.maQuyen = maQuyen;
	}
	public String getTenQuyen() {
		return tenQuyen;
	}
	public void setTenQuyen(String tenQuyen) {
		this.tenQuyen = tenQuyen;
	}
	public Permission(int maQuyen, String tenQuyen) {
		super();
		this.maQuyen = maQuyen;
		this.tenQuyen = tenQuyen;
	}
	public Permission() {
		super();
	}
    
    
}
