package com.kosmo.woodong;

import java.io.IOException;
import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import model.MemberVO;
import model.MybatisMemberImpl;
import naverlogin.NaverLoginBO;

@Controller
public class MainController {

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@RequestMapping("/member/join01.woo")
	public String join01() {
		return "member/join01";
	}

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

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		 **/
		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		// 3. 데이터 파싱
		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		System.out.println(response_obj);
		// response의 nickname값 파싱
		String id = (String) response_obj.get("id");
		String email = (String) response_obj.get("email");
		MemberVO memberVO = new MemberVO();
		String pw = "1";
		String phoneNum = "010-1234-5678";
		memberVO.setId(email);
		memberVO.setPass(pw);
		memberVO.setMobile(phoneNum);
		try {
		((MybatisMemberImpl)this.sqlSession.getMapper(MybatisMemberImpl.class))
		.naverLoginAction(memberVO);
		model.addAttribute("name", email);
		return "member/naverloginAction";
		}
		catch (Exception e) {
			model.addAttribute("name", email);
			return "member/naverloginAction";
		}
		
	}
	
	@Autowired
	private SqlSession sqlSession;
	

	// 로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session) throws IOException {
		System.out.println("여기는 logout");
		session.invalidate();
		return "main/main";
	}

	@RequestMapping("/member/accessDenied.woo")
	public String securityIndex2AccessDenied() {
		return "member/accessDenied";
	}

	@RequestMapping("/member/join02.woo")
	public String join02() {
		return "member/join02";
	}

	@RequestMapping("/member/modify.woo")
	public String join03() {
		return "member/modify";
	}

	@RequestMapping("/member/idpwfind.woo")
	public String idpwfind() {
		return "member/idpwfind";
	}

	@RequestMapping("/main/main.woo")
	public String main(Principal principal, Model model, Authentication authentication) {
		return "main/main";
	}

	@RequestMapping("/main/chatting.woo")
	public String chatting(Principal principal, HttpSession session) {
		session.setAttribute("id", principal.getName());
		return "main/chatting";
	}

	@RequestMapping("/main/chat_main.woo")
	public String chat_main() {
		return "main/chat_main";
	}

	@RequestMapping("/about/about.woo")
	public String about() {
		return "about/about";
	}

	@RequestMapping("/mypage/myList.woo")
	public String mylist() {
		return "mypage/myList";
	}

	@RequestMapping("/community/notice.woo")
	public String notice() {
		return "community/notice";
	}

	@RequestMapping("/board/write.woo")
	public String write() {
		return "board/write";
	}

}