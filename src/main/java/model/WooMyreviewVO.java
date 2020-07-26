package model;

public class WooMyreviewVO {
	
	// 테이블 컬럼
	private String reviewidx;
	private String seller_id;
	private String title;
	private String contents;
	private String buyer_id;
	
	// 기타
	private String imagefile;

	public String getReviewidx() {
		return reviewidx;
	}

	public void setReviewidx(String reviewidx) {
		this.reviewidx = reviewidx;
	}

	public String getSeller_id() {
		return seller_id;
	}

	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
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

	public String getImagefile() {
		return imagefile;
	}

	public void setImagefile(String imagefile) {
		this.imagefile = imagefile;
	}
	
	
}
