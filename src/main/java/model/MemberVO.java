package model;

import java.sql.Date;

public class MemberVO {
	private String id;
	private String pass;
	private Date regidate;
	private String avg_score;
	private String mobile;
	private String addr;
	private String grade;
	private String trade_count;
	private String searchField;
	private String searchTxt;
	private int start;
	private int end;

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return this.pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public Date getRegidate() {
		return this.regidate;
	}

	public void setRegidate(Date regidate) {
		this.regidate = regidate;
	}

	public String getAvg_score() {
		return this.avg_score;
	}

	public void setAvg_score(String avg_score) {
		this.avg_score = avg_score;
	}

	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getAddr() {
		return this.addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getGrade() {
		return this.grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getTrade_count() {
		return this.trade_count;
	}

	public void setTrade_count(String trade_count) {
		this.trade_count = trade_count;
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
}