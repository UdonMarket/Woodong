package com.kosmo.woodong;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import model.WooMemberImpl;
import model.WooMemberVO;
import sms.Coolsms;

@Controller
public class SMSController {
	@Autowired
	private SqlSession sqlSession;
	/*
	 * @RequestMapping(value ="/member/smsSendingStart.woo") public String
	 * smsSendingStart() {
	 * 
	 * return "member/smsSending"; return "redirect:member/smsSendig"; }
	 */

	@ResponseBody
	@RequestMapping(value = "/member/sendSms.do", method = RequestMethod.POST)
	public String sendSms(HttpServletRequest request) throws Exception {
		System.out.println("222");
		String api_key = "NCSOLY9RS2UEFNGR";
		String api_secret = "QXKQSZFVZEDF2R0H2RUFKFF4VNK3PN9U";

		Coolsms coolsms = new Coolsms(api_key, api_secret);

		HashMap<String, String> set = new HashMap<String, String>();

		set.put("to", (String) request.getParameter("to")); // 받는 사람
		set.put("from", "01084300233"); // 발신번호
		set.put("text", "안녕하세요 인증번호는 [" + (String) request.getParameter("text") + "]입니다"); // 문자내용
		set.put("type", "sms"); // 문자 타입

		JSONObject obj = (JSONObject) coolsms.send(set);
		System.out.println(obj.toString());
		return "member/memberModify";
	}

	
	@ResponseBody
	@RequestMapping(value = "/member/pwAccess.woo")
	public Map<String, String> pwAccess(HttpServletRequest request) throws Exception {
		System.out.println("222");
		String api_key = "NCSOLY9RS2UEFNGR";
		String api_secret = "QXKQSZFVZEDF2R0H2RUFKFF4VNK3PN9U";

		Coolsms coolsms = new Coolsms(api_key, api_secret);
		
		WooMemberVO vo = ((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class))
				.pwFind(request.getParameter("mobile"));
		String pw = vo.getPass();
		System.out.println(pw);
		
		HashMap<String, String> set = new HashMap<String, String>();

		set.put("to", (String) request.getParameter("mobile")); // 받는 사람
		set.put("from", "01084300233"); // 발신번호
		set.put("text", "안녕하세요 비밀번호는 [" + pw + "]입니다"); // 문자내용
		set.put("type", "sms"); // 문자 타입

		JSONObject obj = (JSONObject) coolsms.send(set);
		System.out.println(obj.toString());
		return set;
	}
}
