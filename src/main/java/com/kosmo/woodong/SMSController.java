package com.kosmo.woodong;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import sms.Coolsms;

public class SMSController {
	@ResponseBody
	   @RequestMapping(value = "/sendSms.do", method = RequestMethod.POST)
	     public String sendSms(HttpServletRequest request) throws Exception {

	       String api_key = "NCSOLY9RS2UEFNGR";
	       String api_secret = "QXKQSZFVZEDF2R0H2RUFKFF4VNK3PN9U";

	       Coolsms coolsms = new Coolsms(api_key, api_secret);
	       
	       HashMap<String, String> set = new HashMap<String, String>();

	       set.put("to", (String)request.getParameter("to")); // 받는 사람
	       set.put("from", "01084300233"); // 발신번호
	       set.put("text", "안녕하세요 인증번호는 ["+(String)request.getParameter("text")+"]입니다"); // 문자내용
	       set.put("type", "sms"); // 문자 타입

	       JSONObject obj = (JSONObject) coolsms.send(set);
		   System.out.println(obj.toString());
	       return "member/myProfile_modify";
	     }
	
	@RequestMapping(value ="/member/smsSendingStart.woo")
	public String smsSendingStart() {
		
		/* return "member/smsSending"; */
		return "redirect:member/smsSendig";
	}
}
