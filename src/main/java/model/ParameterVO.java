package model;

import java.util.List;

public class ParameterVO {
	private String user_id;
	private String board_idx;
	private String id;
	private String idx;
	private int start;
	private int end;
	private String searchField;
	private String searchTxt;
	private List<String> list;
	private int num;
	private String locationname;
	private String mode;
	private String dealMode;
	private String title;
	private Double latTxt;
	private Double lngTxt;
	private String bname;
	
	
	public Double getLatTxt() {
		return latTxt;
	}
	public void setLatTxt(Double latTxt) {
		this.latTxt = latTxt;
	}
	public Double getLngTxt() {
		return lngTxt;
	}
	public void setLngTxt(Double lngTxt) {
		this.lngTxt = lngTxt;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getBoard_idx() {
		return this.board_idx;
	}

	public void setBoard_idx(String board_idx) {
		this.board_idx = board_idx;
	}
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDealMode() {
		return dealMode;
	}

	public void setDealMode(String dealMode) {
		this.dealMode = dealMode;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getLocationname() {
		return locationname;
	}

	public void setLocationname(String locationname) {
		this.locationname = locationname;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public List<String> getList() {
		return this.list;
	}

	public void setList(List<String> list) {
		this.list = list;
	}

	public int getStart() {
		return this.start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return this.end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public String getSearchField() {
		return this.searchField;
	}

	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}

	public String getSearchTxt() {
		return this.searchTxt;
	}

	public void setSearchTxt(String searchTxt) {
		this.searchTxt = searchTxt;
	}
}
