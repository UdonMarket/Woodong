package model;

import java.sql.Timestamp;

public class WooChatRoomVO {
	
	// 테이블 컬럼
	private String chatroomidx;
	private String boardidx;
	private String sellerid;
	private String buyerid;
	private Timestamp lastchatdate;
	
	private int seq_woo_chatroom;
	private String title;
	private String chatting;
	private String lastchatdateString;
	private String getUserGrade;

	
	public String getGetUserGrade() {
		return getUserGrade;
	}

	public void setGetUserGrade(String getUserGrade) {
		this.getUserGrade = getUserGrade;
	}

	public String getLastchatdateString() {
		return lastchatdateString;
	}

	public void setLastchatdateString(String lastchatdateString) {
		this.lastchatdateString = lastchatdateString;
	}

	public String getChatting() {
		return chatting;
	}

	public void setChatting(String chatting) {
		this.chatting = chatting;
	} 

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getSeq_woo_chatroom() {
		return seq_woo_chatroom;
	}

	public void setSeq_woo_chatroom(int seq_woo_chatroom) {
		this.seq_woo_chatroom = seq_woo_chatroom;
	}

	// 기타
	private String lastChat;

	public String getChatroomidx() {
		return chatroomidx;
	}

	public void setChatroomidx(String chatroomidx) {
		this.chatroomidx = chatroomidx;
	}

	public String getBoardidx() {
		return boardidx;
	}

	public void setBoardidx(String boardidx) {
		this.boardidx = boardidx;
	}

	public String getSellerid() {
		return sellerid;
	}

	public void setSellerid(String sellerid) {
		this.sellerid = sellerid;
	}

	public String getBuyerid() {
		return buyerid;
	}

	public void setBuyerid(String buyerid) {
		this.buyerid = buyerid;
	}

	public Timestamp getLastchatdate() {
		return lastchatdate;
	}

	public void setLastchatdate(Timestamp lastchatdate) {
		this.lastchatdate = lastchatdate;
	}

	public String getLastChat() {
		return lastChat;
	}

	public void setLastChat(String lastChat) {
		this.lastChat = lastChat;
	}
	
	
}
