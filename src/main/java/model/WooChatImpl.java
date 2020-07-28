package model;

import java.util.ArrayList;
import java.util.List;

public interface WooChatImpl {
	public List<WooChatRoomVO> selectRoom(String sellerid);
	public List<WooChattingVO> selectLastChat(String roomidx);
	public ArrayList<WooJusoVO> jusoList();
	public ArrayList<WooJusoVO> searchPlace(ParameterVO parameterVO);
	
}
