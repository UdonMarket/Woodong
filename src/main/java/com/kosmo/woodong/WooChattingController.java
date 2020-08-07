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
import org.springframework.web.bind.annotation.RequestMethod;
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
		WooChatRoomVO wooChatRoomVO = new WooChatRoomVO();
		System.out.println("1");
		if(chatroomidx!=null) {
			wooChatRoomVO = sqlSession.getMapper(WooChatImpl.class).selectRoomVO(chatroomidx);
			System.out.println("존재");
		}
		else {
			String sellerid = req.getParameter("sellerid");
			String boardidx = req.getParameter("boardidx");
			wooChatRoomVO.setBoardidx(boardidx);
			wooChatRoomVO.setBuyerid(user_id);
			wooChatRoomVO.setSellerid(sellerid);
			WooChatRoomVO roomCheck = sqlSession.getMapper(WooChatImpl.class).selectChatRoom(wooChatRoomVO);
			if(roomCheck!=null && !"".equals(roomCheck.getChatroomidx())) {
				chatroomidx = roomCheck.getChatroomidx();
				wooChatRoomVO = roomCheck;
				System.out.println("존재222");
			}
			else {
				sqlSession.getMapper(WooChatImpl.class).createChatroom(wooChatRoomVO);
	      chatroomidx = String.valueOf(wooChatRoomVO.getSeq_woo_chatroom());
				wooChatRoomVO = sqlSession.getMapper(WooChatImpl.class).selectRoomVO(chatroomidx);
				System.out.println("생성");

			}
			
		}
		List<WooChattingVO> chatList = sqlSession.getMapper(WooChatImpl.class).selectChatting(chatroomidx);
		WooBoardVO wooBoardVO = sqlSession.getMapper(WooBoardImpl.class).view(wooChatRoomVO.getBoardidx());
		
		session.setAttribute("id", user_id);
		model.addAttribute("deal_type", wooBoardVO.getDeal_type());
		model.addAttribute("wooChatRoomVO", wooChatRoomVO);
		model.addAttribute("chatList", chatList);
		model.addAttribute("userid", user_id);
		model.addAttribute("chatroomidx", chatroomidx);
		
		return "chatting/chatting";
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
	@RequestMapping(value="/chatting/saveMessageDB.woo")
	public void saveMessageDB(HttpServletRequest req){
		String chatting = req.getParameter("chatting");
		String chatroomidx = req.getParameter("chatroomidx");
		String id = req.getParameter("id");
		String prohiditionlists = sqlSession.getMapper(WooProhiditionImpl.class).selectProhiditionList();
		
		String[] prohidition = prohiditionlists.split(",");
		
		for(String pro : prohidition) {
			if(chatting.contains(pro)) {
				sqlSession.getMapper(WooMemberImpl.class).prohidition(id, pro);
				sqlSession.getMapper(WooChatImpl.class).prohidition(chatroomidx);
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
	
	@RequestMapping(value="/chatting/updateStatus.woo")
	public void updateStatus(HttpServletRequest req) {
		System.out.println("진입");
		String boardidx = req.getParameter("boardidx");
		String deal_type = req.getParameter("deal_type");
		
		WooChatRoomVO wooChatRoomVO = sqlSession.getMapper(WooChatImpl.class).selectBuyer(boardidx);
		
		WooBoardVO wooBoardVO = new WooBoardVO();
		wooBoardVO.setBoardidx(boardidx);
		wooBoardVO.setDeal_type(deal_type);
		wooBoardVO.setBuyer_id(wooChatRoomVO.getBuyerid());
		sqlSession.getMapper(WooBoardImpl.class).updateDeal(wooBoardVO);
	}
	
	@RequestMapping("/chatting/saveLastTime")
	public void saveLastTime() {
		System.out.println(":dsasdadsasa");
	}
	
}
