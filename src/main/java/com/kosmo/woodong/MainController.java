package com.kosmo.woodong;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import model.BoardListImpl;
import model.BoardListVO;

@Controller
public class MainController {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 메인화면
	@RequestMapping("/main/main.woo")
	public String main() {
		return "main/main";
	}
	// 소개
	@RequestMapping("/about/about.woo")
	public String about() {
		return "about/about";
	}

	// 커뮤니티
	@RequestMapping("/community/community.woo")
	public String community(Model model, HttpServletRequest req) {
		String location = ".." + req.getServletPath();
		List<BoardListVO> blists = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class))
				.selectBoard(location);
		model.addAttribute("blists", blists);
		return "community/community";
	}

	// 로그인
	@RequestMapping("/member/login.woo")
	public String securityIndex2Login(Principal principal, Model model) {
		return "member/login";
	}
	
	// 아이디 비밀번호 찾기
	@RequestMapping("/member/idFind.woo")
	public String idFind() {
		return "member/idFind";
	}
	@RequestMapping("/member/pwFind.woo")
	public String pwFind() {
		return "member/pwFind";
	}	
	
	// 채팅
	@RequestMapping("/main/chatting.woo")
	public String chatting(Principal principal, HttpSession session) {
		session.setAttribute("id", principal.getName());
		return "main/chatting";
	}
	@RequestMapping("/main/chat_main.woo")
	public String chat_main() {
		return "main/chat_main";
	}
		
	
	
	@RequestMapping("/member/accessDenied.woo")
	public String securityIndex2AccessDenied() {
		return "member/accessDenied";
	}
	
	@RequestMapping("/board/write.woo")
	public String write() {
		return "board/write";
	}
	

	
	
}
