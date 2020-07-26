package model;

import java.sql.Date;

public class WooChattingVO {
	
	// 테이블 컬럼
	private int chattionidx;
	private String chatting;
	private Date chatDate;
	private int chatroomidx;

	// 기타
	
	
	public int getChattionidx() {
		return chattionidx;
	}
	public void setChattionidx(int chattionidx) {
		this.chattionidx = chattionidx;
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
	public int getChatroomidx() {
		return chatroomidx;
	}
	public void setChatroomidx(int chatroomidx) {
		this.chatroomidx = chatroomidx;
	}
	
}
