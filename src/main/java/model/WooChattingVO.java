package model;

import java.sql.Date;

public class WooChattingVO {
	private int idx;
	private String chatting;
	private Date chatDate;
	private int room;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getChatting() {
		return chatting;
	}
	public void setChatting(String chatting) {
		this.chatting = chatting;
	}
	public Date getChatDate() {
		return chatDate;
	}
	public void setChatDate(Date chatDate) {
		this.chatDate = chatDate;
	}
	public int getRoom() {
		return room;
	}
	public void setRoom(int room) {
		this.room = room;
	}
	 
	 
	
	
}
