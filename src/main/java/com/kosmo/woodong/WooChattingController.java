package com.kosmo.woodong;

import java.security.Principal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
		String id = principal.getName();
		List<WooChatRoomVO> roomList = sqlSession.getMapper(WooChatImpl.class).selectRoom(id);
		
		for(WooChatRoomVO room : roomList) {
			List<WooChattingVO> chatList = sqlSession.getMapper(WooChatImpl.class).selectLastChat(room.getChatroomidx());
			if(chatList.size()>0) {
				room.setLastChat(chatList.get(chatList.size()-1).getChatting());
			}
		}
		
		model.addAttribute("roomList", roomList);
		model.addAttribute("id", id);
		return "chatting/chatMain";
	}
	
	// 채팅
	@RequestMapping("/chatting/chatting.woo")
	public String chatting(Principal principal, HttpServletRequest req, HttpSession session, Model model) {
		String user_id = principal.getName();
		String chatroomidx = req.getParameter("chatroomidx");
		List<WooChattingVO> chatList = sqlSession.getMapper(WooChatImpl.class).selectChatting(chatroomidx);
		session.setAttribute("id", user_id);
		model.addAttribute("chatList", chatList);
		model.addAttribute("userid", user_id);
		model.addAttribute("chatroomidx", req.getParameter("chatroomidx"));
		return "chatting/chatting";
	}
	
	@RequestMapping("/chatting/saveMessageDB.woo")
	public void saveMessageDB(HttpServletRequest req){
		String chatting = req.getParameter("chatting");
		String chatroomidx = req.getParameter("chatroomidx");
		String id = req.getParameter("id");
		
		WooChattingVO wooChattingVO = new WooChattingVO();
		wooChattingVO.setChatroomidx(chatroomidx);
		wooChattingVO.setChatting(chatting);
		wooChattingVO.setId(id);
		sqlSession.getMapper(WooChatImpl.class).saveMessage(wooChattingVO);
		
		List<WooChattingVO> chatList = sqlSession.getMapper(WooChatImpl.class).selectLastChat(chatroomidx);
		Timestamp lastChat = null;
		if(chatList.size()>0) {
			lastChat = chatList.get(chatList.size()-1).getChatDate();
			System.out.println("1" + chatList.get(chatList.size()-1).getChatDate());
		}
		System.out.println("2" + lastChat);
		sqlSession.getMapper(WooChatImpl.class).updateLastChatTime(chatroomidx, lastChat);
	}
	
}
