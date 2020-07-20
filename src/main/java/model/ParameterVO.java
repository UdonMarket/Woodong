package model;

import java.util.List;

public class ParameterVO {
	private String user_id;
	private String board_idx;
	private int start;
	private int end;
	private String searchField;
	private String searchTxt;
	private List<String> list;
	private String mode;
	private String dealMode;
	
	
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

	public String getUser_id() {
		return this.user_id;
	}

	public List<String> getList() {
		return this.list;
	}

	public void setList(List<String> list) {
		this.list = list;
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