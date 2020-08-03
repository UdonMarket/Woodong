package model;

import java.sql.Date;

public class WooPayVO {
	private String pay_idx; //거래 번호
	private String merchant_uid; //거래 고유 번호
	private String product_name; //상품명
	private String product_price; //상품가격
	private String board_idx; //보드idx
	private Date paydate; //결제일
	private String buyer_id; //구매자 id
	private String seller_id; //판매자 id
	private String status; //결제상태
	private String pay_method; //결제방법
	
	public Date getPaydate() {
		return paydate;
	}
	public void setPaydate(Date paydate) {
		this.paydate = paydate;
	}
	public String getPay_idx() {
		return pay_idx;
	}
	public void setPay_idx(String pay_idx) {
		this.pay_idx = pay_idx;
	}
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_price() {
		return product_price;
	}
	public void setProduct_price(String product_price) {
		this.product_price = product_price;
	}
	public String getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(String board_idx) {
		this.board_idx = board_idx;
	}
	public String getBuyer_id() {
		return buyer_id;
	}
	public void setBuyer_id(String buyer_id) {
		this.buyer_id = buyer_id;
	}
	public String getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	
	
}
