package model;

import java.util.List;

public interface WooChatDAOImpl {
	public List<WooChatRoomVO> selectRoom(String sellerid);
	public List<WooChattingVO> selectLastChat(String roomidx);
}
