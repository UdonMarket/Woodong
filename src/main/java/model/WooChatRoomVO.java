package model;

public class WooChatRoomVO {
	private String roomidx;
	private String boardidx;
	private String myid;
	private String otherid;
	private String lastchatdate;
	private String lastChat;
	
	public String getLastchatdate() {
		return lastchatdate;
	}

	public void setLastchatdate(String lastchatdate) {
		this.lastchatdate = lastchatdate;
	}

	public String getRoomidx() {
		return roomidx;
	}

	public void setRoomidx(String roomidx) {
		this.roomidx = roomidx;
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

	public String getLastChat() {
		return lastChat;
	}

	public void setLastChat(String lastChat) {
		this.lastChat = lastChat;
	}
	
	
}
