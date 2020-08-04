package com.kosmo.woodong;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import model.ParameterVO;
import model.WooBoardImpl;
import model.WooBoardVO;
import model.WooChatImpl;
import model.WooChatRoomVO;
import model.WooChattingVO;
import model.WooJusoVO;
import model.WooMemberImpl;
import model.WooMemberVO;
import model.WooMypageImpl;
import model.WooProhiditionImpl;
import util.review;

@Controller
public class WooChattingController {
	
	@Autowired 
	private SqlSession sqlSession;
	
	// 채팅방 메인화면
	@RequestMapping("/chatting/chatMain.woo")
	public String chatMain(Principal principal, Model model) {
		String id = principal.getName();
		List<WooChatRoomVO> roomList = sqlSession.getMapper(WooChatImpl.class).selectRoom(id);
		
		Map<String, Object> map = review.revireScore(sqlSession, id);
		
		for(WooChatRoomVO room : roomList) {
			List<WooChattingVO> chatList = sqlSession.getMapper(WooChatImpl.class).selectLastChat(room.getChatroomidx());
			if(chatList.size()>0) {
				room.setLastChat(chatList.get(chatList.size()-1).getChatting());
			}
		}
		model.addAttribute("memberVO", map.get("memberVO"));
		model.addAttribute("udongGrade", map.get("udongGrade"));
		model.addAttribute("score", map.get("score"));
		model.addAttribute("roomList", roomList);
		model.addAttribute("id", id);
		return "chatting/chatMain";
	}
	
	// 채팅
	@RequestMapping("/chatting/chatting.woo")
	public String chatting(Principal principal, HttpServletRequest req, HttpSession session, Model model) {
		String user_id = principal.getName();
		String chatroomidx = req.getParameter("chatroomidx");
		if(chatroomidx==null) {
			String sellerid = req.getParameter("sellerid");
			String boardidx = req.getParameter("boardidx");
			WooChatRoomVO wooChatRoomVO = new WooChatRoomVO();
			wooChatRoomVO.setBoardidx(boardidx);
			wooChatRoomVO.setBuyerid(user_id);
			wooChatRoomVO.setSellerid(sellerid);
			String roomCheck = sqlSession.getMapper(WooChatImpl.class).selectChatRoom(wooChatRoomVO);
			if(roomCheck!=null && !"".equals(roomCheck)) {
				chatroomidx = roomCheck;
			}
			else {
				sqlSession.getMapper(WooChatImpl.class).createChatroom(wooChatRoomVO);
				chatroomidx = String.valueOf(wooChatRoomVO.getSeq_woo_chatroom());
			}
			
		}
		List<WooChattingVO> chatList = sqlSession.getMapper(WooChatImpl.class).selectChatting(chatroomidx);
		session.setAttribute("id", user_id);
		model.addAttribute("chatList", chatList);
		model.addAttribute("userid", user_id);
		model.addAttribute("chatroomidx", chatroomidx);
		return "chatting/chatting";
	}
	
	/* 우동이
	@RequestMapping("/chatting/woodongtalk.woo")
	public String woodongtalk(Principal principal, HttpSession session, Model model) {
		String user_id = principal.getName();
		session.setAttribute("id", user_id);
		model.addAttribute("id", user_id);
		return "chatting/woodongtalk";
	}*/
	//챗봇 장소추천
	@RequestMapping("/chatting/jusoList.woo")
	@ResponseBody
	public ArrayList<WooJusoVO> jusoList(HttpServletRequest req) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<WooJusoVO> lists = sqlSession.getMapper(WooChatImpl.class).jusoList();
		map.put("jusoList", lists);
		
		return lists;
	}
	@RequestMapping("/chatting/location.woo")
	public String location(Model model, HttpServletRequest req) {
		String place = req.getParameter("place");
		model.addAttribute("place",place);
		
		return "chatting/location";
	}
	@RequestMapping("/chatting/topPlace.woo")
	public String topPlace(Model model, HttpServletRequest req) {
		ParameterVO parameterVO = new ParameterVO();
		parameterVO.setPlace(req.getParameter("place"));
		parameterVO.setLatTxt((req.getParameter("latitude")==null)? 0 : Double.parseDouble(req.getParameter("latitude")));
		parameterVO.setLngTxt((req.getParameter("longitude")==null)? 0 : Double.parseDouble(req.getParameter("longitude")));
		ArrayList<WooJusoVO> searchLists  = sqlSession.getMapper(WooChatImpl.class).searchPlace(parameterVO);
		model.addAttribute("parameterVO", parameterVO);
		model.addAttribute("searchLists",searchLists);
		return "chatting/topPlace";
	}
	@RequestMapping("/chatting/saveMessageDB.woo")
	public void saveMessageDB(HttpServletRequest req){
		String chatting = req.getParameter("chatting");
		String chatroomidx = req.getParameter("chatroomidx");
		String id = req.getParameter("id");
		List<String> prohiditionlists = sqlSession.getMapper(WooProhiditionImpl.class).selectProhiditionList();
		
		for(String prohidition : prohiditionlists) {
			if(chatting.contains(prohidition)) {
				sqlSession.getMapper(WooMemberImpl.class).prohidition(id, prohidition);
			}
		}
		
		WooChattingVO wooChattingVO = new WooChattingVO();
		wooChattingVO.setChatroomidx(chatroomidx);
		wooChattingVO.setChatting(chatting);
		wooChattingVO.setId(id);
		sqlSession.getMapper(WooChatImpl.class).saveMessage(wooChattingVO);
		
		List<WooChattingVO> chatList = sqlSession.getMapper(WooChatImpl.class).selectLastChat(chatroomidx);
		Timestamp lastChat = null;
		if(chatList.size()>0) {
			lastChat = chatList.get(chatList.size()-1).getChatDate();
		}
		sqlSession.getMapper(WooChatImpl.class).updateLastChatTime(chatroomidx, lastChat);
	}
	
}
