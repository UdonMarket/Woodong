package model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class WooBoardVO {
	
	//멤버변수
	private String idx;//게시물 일련번호
	private String title;//게시물 제목
	private String contents;//내용 (상품설명)
	private String postdate;//게시물 작성일
	private String id;//게시물 작성자
	private String bname;
	private String visitcount;//게시물 조회수
	private String image;
	private String manyimage;
	private String likecount;//좋아요 수
	private String price;//상품 가격
	private String product_state;//상품 상태
	private String chatcount;//채팅 수
	private int like_check;//좋아요 체크
	private String three_dimens; //3D이미지 체크
	private String product_tag;//상품 태그
	private String woopay;//우동페이 체크
	private String deal_type;//거래 종류
	private String latitude;//거래희망 위치 좌표
	private String longitude;//거래희망 위치 좌표
	private String imagefile;
	private List<MultipartFile> file;
	private int seq_woo_board;
	private String good_state;
	private String review_score;
	
	
	
	
	
	//getter / setter
	public String getGood_state() {
		return this.good_state;
	}

	public void setGood_state(String good_state) {
		this.good_state = good_state;
	}
	
	public String getManyimage() {
		return this.manyimage;
	}

	public void setManyimage(String manyimage) {
		this.manyimage = manyimage;
	}
	
	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	public String getReview_score() {
		return review_score;
	}

	public void setReview_score(String review_score) {
		this.review_score = review_score;
	}
	public String getIdx() {
		return idx;
	}
	public int getSeq_woo_board() {
		return seq_woo_board;
	}
	public void setSeq_woo_board(int seq_woo_board) {
		this.seq_woo_board = seq_woo_board;
	}
	public String getImagefile() {
		return imagefile;
	}
	public void setImagefile(String imagefile) {
		this.imagefile = imagefile;
	}
	public List<MultipartFile> getFile() {
		return file;
	}
	public void setFile(List<MultipartFile> file) {
		this.file = file;
	}
	public void setIdx(String idx) {
		this.idx = idx;
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
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}
	public String getLikecount() {
		return likecount;
	}
	public void setLikecount(String likecount) {
		this.likecount = likecount;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getProduct_state() {
		return product_state;
	}
	public void setProduct_state(String product_state) {
		this.product_state = product_state;
	}
	public String getChatcount() {
		return chatcount;
	}
	public void setChatcount(String chatcount) {
		this.chatcount = chatcount;
	}
	public int getLike_check() {
		return like_check;
	}
	public void setLike_check(int like_check) {
		this.like_check = like_check;
	}
	public String getThree_dimens() {
		return three_dimens;
	}
	public void setThree_dimens(String three_dimens) {
		this.three_dimens = three_dimens;
	}
	public String getProduct_tag() {
		return product_tag;
	}
	public void setProduct_tag(String product_tag) {
		this.product_tag = product_tag;
	}
	public String getWoopay() {
		return woopay;
	}
	public void setWoopay(String woopay) {
		this.woopay = woopay;
	}
	public String getDeal_type() {
		return deal_type;
	}
	public void setDeal_type(String deal_type) {
		this.deal_type = deal_type;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
	
	
	
	
	
}
