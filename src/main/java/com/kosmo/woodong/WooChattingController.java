package com.kosmo.woodong;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import model.WooChatImpl;
import model.WooChatRoomVO;
import model.WooChattingVO;

@Controller
public class WooChattingController {
	
	@Autowired 
	private SqlSession sqlSession;
	
	// 채팅방 메인화면
	@RequestMapping("/chatting/chatMain.woo")
	public String chatMain(Principal principal, Model model) {
		String sellerid = principal.getName();
		List<WooChatRoomVO> roomList = sqlSession.getMapper(WooChatImpl.class).selectRoom(sellerid);
		
		for(WooChatRoomVO room : roomList) {
			List<WooChattingVO> chatList = sqlSession.getMapper(WooChatImpl.class).selectLastChat(room.getChatroomidx());
			if(chatList.size()>0) {
				room.setLastChat(chatList.get(chatList.size()-1).getChatting());
			}
		}
		
		model.addAttribute("roomList", roomList);
		
		return "chatting/chatMain";
	}
	
	// 채팅
	@RequestMapping("/chatting/chatting.woo")
	public String chatting(Principal principal, HttpSession session, Model model) {
		String user_id = principal.getName();
		session.setAttribute("id", user_id);
		model.addAttribute("id", user_id);
		return "chatting/chatting";
	}
	
}
