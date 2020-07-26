package model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public interface WooChatImpl {
	public List<WooChatRoomVO> selectRoom(String sellerid);
	public List<WooChattingVO> selectLastChat(String roomidx);
	public void saveMessage(WooChattingVO chattingVO);
	public void updateLastChatTime(String chatroomidx, Timestamp lastChat);
	public List<WooChattingVO> selectChatting(String chatroomidx);
}
