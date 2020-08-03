package model;

import java.sql.Timestamp;

public class WooChattingVO {
	
	// 테이블 컬럼
	private String chattionidx;
	private String id;
	private String chatting;
	private Timestamp chatDate;
	private String chatroomidx;

	// 기타
	
	
	
	public String getChatting() {
		return chatting;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setChatting(String chatting) {
		this.chatting = chatting;
	}
	public Timestamp getChatDate() {
		return chatDate;
	}
	public void setChatDate(Timestamp chatDate) {
		this.chatDate = chatDate;
	}
	public String getChattionidx() {
		return chattionidx;
	}
	public void setChattionidx(String chattionidx) {
		this.chattionidx = chattionidx;
	}
	public String getChatroomidx() {
		return chatroomidx;
	}
	public void setChatroomidx(String chatroomidx) {
		this.chatroomidx = chatroomidx;
	}
	
	
}
