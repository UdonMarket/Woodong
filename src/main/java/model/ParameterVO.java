package model;

import java.util.List;

public class ParameterVO {
	private String id;
	private String idx;
	private int start;
	private int end;
	private String searchField;
	private String searchTxt;
	private List<String> list;

	
	
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