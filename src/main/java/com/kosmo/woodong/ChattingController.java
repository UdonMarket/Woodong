package com.kosmo.woodong;

import java.security.Principal;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import model.WooChatDAOImpl;
import model.WooChatRoomVO;
import model.WooChattingVO;

@Controller
public class ChattingController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/main/chat_main.woo")
	public String chatMain(Principal principal, Model model) {
		String sellerid = principal.getName();
		List<WooChatRoomVO> roomList = sqlSession.getMapper(WooChatDAOImpl.class).selectRoom(sellerid);
		
		for(WooChatRoomVO room : roomList) {
			List<WooChattingVO> chatList = sqlSession.getMapper(WooChatDAOImpl.class).selectLastChat(room.getRoomidx());
			if(chatList.size()>0) {
				room.setLastChat(chatList.get(chatList.size()-1).getChatting());
			}
		}
		
		model.addAttribute("roomList", roomList);
		
		return "main/chat_main";
	}
	
	
}
