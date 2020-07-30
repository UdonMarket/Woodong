package com.kosmo.woodong;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import model.WooMemberVO;
import model.WooMemberImpl;
import naverlogin.NaverLoginBO;

@Controller
public class NaverController {
	
	@Autowired
	private SqlSession sqlSession;
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
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
		WooMemberVO memberVO = new WooMemberVO();
		String pw = "1";
		String phoneNum = "010-1234-5678";
		memberVO.setId(email);
		memberVO.setPass(pw);
		memberVO.setMobile(phoneNum);
		try {
		((WooMemberImpl)this.sqlSession.getMapper(WooMemberImpl.class))
		.regist(memberVO);
		model.addAttribute("name", email);
		return "member/naverloginAction";
		}
		catch (Exception e) {
			model.addAttribute("name", email);
			return "member/naverloginAction";
		}

	}
}
