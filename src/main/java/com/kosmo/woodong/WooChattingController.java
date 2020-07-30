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

@Controller
public class WooChattingController {
	
	@Autowired 
	private SqlSession sqlSession;
	
	// 채팅방 메인화면
	@RequestMapping("/chatting/chatMain.woo")
	public String chatMain(Principal principal, Model model) {
		String id = principal.getName();
		List<WooChatRoomVO> roomList = sqlSession.getMapper(WooChatImpl.class).selectRoom(id);
		
		ArrayList<String> review_score = sqlSession.getMapper(WooMypageImpl.class).review_score(id);
		double review_scoreSum = 0;
		for(int i=0; i<review_score.size(); i++) {
			review_scoreSum += Double.parseDouble(review_score.get(i));
		}
		WooMemberVO memberVO = sqlSession.getMapper(WooMypageImpl.class).myInfo(id);
		
		int trade_count = Integer.parseInt(memberVO.getTrade_count());
		
		double avg_score1 = 0;
		if(trade_count==0) {
			avg_score1 = 1;
		}
		else {
			avg_score1 = review_scoreSum / (double)trade_count;
		}
		double avg_score2 = ((double)Math.round(avg_score1*10)/10);
		int avg_score_update = sqlSession.getMapper(WooMypageImpl.class).avg_score_update(avg_score2, id);	
		double avg_score = Double.parseDouble(memberVO.getAvg_score());

		String score = "";

		int full = (int) avg_score % 5;
		int half = (int) ((avg_score - full) * 10);
		
		for (int i = 1; i <= full; i++) {
			score += "<img src='../resources/img/그냥튀김우동.png' alt='' />";
		}
		if (half < 5) {
			for (int j = full + 1; j <= 5; j++) {
				score += "<img src='../resources/img/회색우동.png' alt='' />";
			}
		} else {
			score += "<img src='../resources/img/반쪽우동.png' alt='' />";
			for (int j = full + 2; j <= 5; j++) {
				score += "<img src='../resources/img/회색우동.png' alt='' />";
			}
		}

		String udongGrade = "";

		if (trade_count < 5) {
			udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
		} else if (trade_count >= 5 && trade_count < 10) {
			if (avg_score >= 1 && avg_score < 2)
				udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
			else
				udongGrade += "<img src='../resources/img/빨간일반.png' alt='' />";
		} else if (trade_count >= 10 && trade_count < 15) {
			if (avg_score >= 1 && avg_score < 2)
				udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
			else if (avg_score >= 2 && avg_score < 4)
				udongGrade += "<img src='../resources/img/빨간일반.png' alt='' />";
			else
				udongGrade += "<img src='../resources/img/파랑온도계.png' alt='' />";
		} else if (trade_count >= 15) {
			if (avg_score >= 1 && avg_score < 2)
				udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
			else if (avg_score >= 2 && avg_score < 4)
				udongGrade += "<img src='../resources/img/빨간일반.png' alt='' />";
			else
				udongGrade += "<img src='../resources/img/빨간온도계.png' alt='' />";
		}
		
		
		for(WooChatRoomVO room : roomList) {
			List<WooChattingVO> chatList = sqlSession.getMapper(WooChatImpl.class).selectLastChat(room.getChatroomidx());
			if(chatList.size()>0) {
				room.setLastChat(chatList.get(chatList.size()-1).getChatting());
			}
		}
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("score", score);
		model.addAttribute("udongGrade", udongGrade);
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
				chatroomidx = String.valueOf(sqlSession.getMapper(WooChatImpl.class).createChatroom(wooChatRoomVO));
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
