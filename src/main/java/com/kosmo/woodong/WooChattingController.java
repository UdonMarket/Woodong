package com.kosmo.woodong;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
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
	
	// 우동이
	@RequestMapping("/chatting/woodongtalk.woo")
	public String woodongtalk(Principal principal, HttpSession session, Model model) {
		String user_id = principal.getName();
		session.setAttribute("id", user_id);
		model.addAttribute("id", user_id);
		return "chatting/woodongtalk";
	}
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
}
