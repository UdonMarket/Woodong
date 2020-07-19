package model;

public class BoardListVO {
	private String bname;
	private String location;
	private String locationname;
	private String requestname;
	private String idx;
	private String type;
	private int boardorder;
	
	public int getBoardorder() {
		return boardorder;
	}
	public void setBoardorder(int boardorder) {
		this.boardorder = boardorder;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getLocationname() {
		return locationname;
	}
	public void setLocationname(String locationname) {
		this.locationname = locationname;
	}
	public String getRequestname() {
		return requestname;
	}
	public void setRequestname(String requestname) {
		this.requestname = requestname;
	}
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
		
}