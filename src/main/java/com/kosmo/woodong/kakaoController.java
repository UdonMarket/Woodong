package com.kosmo.woodong;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;

import kakaologin.kakao_restapi;
import model.WooMemberVO;
import model.WooMemberImpl;

@Controller
public class kakaoController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private kakao_restapi kakao_restapi = new kakao_restapi();
    
	@RequestMapping(value = "/oauth", produces = "application/json", method = { RequestMethod.GET, RequestMethod.POST })
	public String kakaoLogin(@RequestParam("code") String code, Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
	    System.out.println("로그인 할때 임시 코드값");
	    //카카오 홈페이지에서 받은 결과 코드
	    System.out.println(code);
	    System.out.println("로그인 후 결과값");
	   
	    //카카오 rest api 객체 선언
	    kakao_restapi kr = new kakao_restapi();
	   
	    //결과값을 node에 담아줌(코드)
	    JsonNode node = kr.getAccessToken(code);
	    //결과값 출력
	    System.out.println(node);
	    //노드 안에 있는 access_token값을 꺼내 문자열로 변환
	    String token = node.get("access_token").toString();
	    JsonNode accessToken = node.get("access_token");
	    JsonNode userInfo = kakao_restapi.getKakaoUserInfo(accessToken);
	    //유저정보 카카오에서 가져오기 Get properties
	    JsonNode properties = userInfo.path("properties"); 
	    JsonNode kakao_account = userInfo.path("kakao_account"); 
	    
	    //사용자 이메일 얻어오기
	    String kemail = null;
	    kemail = kakao_account.path("email").asText(); 
	    System.out.println(kemail);
	    session.setAttribute("kemail", kemail);
	    //세션에 담아준다.
	    session.setAttribute("token", token);
	    
	    //////////
	    WooMemberVO memberVO = new WooMemberVO();
		String pw = "1";
		String phoneNum = "010-1234-5678";
		memberVO.setId(kemail);
		memberVO.setPass(pw);
		memberVO.setMobile(phoneNum);
		try {
		((WooMemberImpl)this.sqlSession.getMapper(WooMemberImpl.class))
		.kakaoLoginAction(memberVO);
		model.addAttribute("name", kemail);
		return "member/kakaologinAction";
		}
		catch (Exception e) {
			model.addAttribute("name", kemail);
			return "member/kakaologinAction";
		}
	    
	    //////////
	   // return "redirect:member/login.woo";
	}
	
	@RequestMapping(value = "/logout", produces = "application/json")
	public String Logout(HttpSession session) {
	    //kakao restapi 객체 선언
	    kakao_restapi kr = new kakao_restapi();
	    //노드에 로그아웃한 결과값음 담아줌 매개변수는 세션에 잇는 token을 가져와 문자열로 변환
	    JsonNode node = kr.Logout(session.getAttribute("token").toString());
	    //결과 값 출력
	    System.out.println("로그인 후 반환되는 아이디 : " + node.get("id"));
	    return "home";
	}    
}
