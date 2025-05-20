package beans;

import java.util.List;

public class Cart {
	private int product;
	private Product productObj;
	private int size;
	private Size sizeObj;
	private List<Integer> toppings;
	private List<Topping> toppingsObj;
	public int getProduct() {
		return product;
	}
	public void setProduct(int product) {
		this.product = product;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public List<Integer> getToppings() {
		return toppings;
	}
	public void setToppings(List<Integer> toppings) {
		this.toppings = toppings;
	}
	public Product getProductObj() {
		return productObj;
	}
	public void setProductObj(Product productObj) {
		this.productObj = productObj;
	}
	public Size getSizeObj() {
		return sizeObj;
	}
	public void setSizeObj(Size sizeObj) {
		this.sizeObj = sizeObj;
	}
	public List<Topping> getToppingsObj() {
		return toppingsObj;
	}
	public void setToppingsObj(List<Topping> toppingsObj) {
		this.toppingsObj = toppingsObj;
	}
	
}
