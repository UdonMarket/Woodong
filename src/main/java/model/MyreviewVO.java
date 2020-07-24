package model;

public class MyreviewVO {
	
	private String seller_id;
	private String review_idx;
	private String title;
	private String contents;
	private String buyer_id;
	private String imagefile;
	
	
	public String getImagefile() {
		return imagefile;
	}
	public void setImagefile(String imagefile) {
		this.imagefile = imagefile;
	}
	public String getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	public String getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(String review_idx) {
		this.review_idx = review_idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getBuyer_id() {
		return buyer_id;
	}
	public void setBuyer_id(String buyer_id) {
		this.buyer_id = buyer_id;
	}
	
	
	
}
