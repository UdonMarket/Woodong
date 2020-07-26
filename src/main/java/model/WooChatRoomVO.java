package model;

public class WooChatRoomVO {
	
	// 테이블 컬럼
	private String chatroomidx;
	private String boardidx;
	private String myid;
	private String otherid;
	private String lastchatdate;
	
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

	public String getMyid() {
		return myid;
	}

	public void setMyid(String myid) {
		this.myid = myid;
	}

	public String getOtherid() {
		return otherid;
	}

	public void setOtherid(String otherid) {
		this.otherid = otherid;
	}

	public String getLastchatdate() {
		return lastchatdate;
	}

	public void setLastchatdate(String lastchatdate) {
		this.lastchatdate = lastchatdate;
	}

	public String getLastChat() {
		return lastChat;
	}

	public void setLastChat(String lastChat) {
		this.lastChat = lastChat;
	}
	
	
}
