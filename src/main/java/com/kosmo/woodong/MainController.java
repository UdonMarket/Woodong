package com.kosmo.woodong;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import model.BoardListImpl;
import model.BoardListVO;
import model.MemberVO;
import model.MybatisMemberImpl;
import naverlogin.NaverLoginBO;

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
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	// 로그인
	@RequestMapping("/member/login.woo")
	public String securityIndex2Login(Principal principal, Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		/* System.out.println("네이버:" + naverAuthUrl); */
		// 네이버
		model.addAttribute("url", naverAuthUrl);
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
	public String chatting(Principal principal, HttpSession session, Model model) {
		String user_id = principal.getName();
		session.setAttribute("id", user_id);
		model.addAttribute("id", user_id);
		return "main/chatting";
	}
	@RequestMapping("/member/accessDenied.woo")
	public String securityIndex2AccessDenied() {
		return "member/accessDenied";
	}
	
	@RequestMapping("/board/write.woo")
	public String write() {
		return "board/write";
	}
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
} 
