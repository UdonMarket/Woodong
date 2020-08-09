package com.kosmo.woodong;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.WooMemberVO;
import model.WooMypageImpl;
import util.review;
import model.WooMemberImpl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WooMemberController {
	@Autowired
	private SqlSession sqlSession;
	
	// 회원가입
	@RequestMapping("/member/join.woo")
	public String join() {
		return "member/join";
	}
	
	// 회원가입 처리
	@ResponseBody
	@RequestMapping(value = "/member/joinAction.woo", method = { RequestMethod.POST })
	public Map<String, Object> joinAction(HttpServletRequest req, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		WooMemberVO memberVO = new WooMemberVO();
		
		memberVO.setId(req.getParameter("email"));
		memberVO.setPass(req.getParameter("pass"));
		memberVO.setMobile(req.getParameter("mobile"));
		
		int res = ((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class)).regist(memberVO);
		
		if (res == 0) {
			map.put("JoinResult", 0);
			map.put("msg", "회원가입 실패");
		} else {
			map.put("JoinResult", 1);
			map.put("msg", "회원가입 성공");
		}
		
		return map;
	}
	
	// 회원정보 수정
	@RequestMapping("/member/memberModify.woo")
	public String memberModify(Principal principal, Model model) {
		
		String user_id = "";
		
		user_id = principal.getName();
		
		Map<String, Object> map = review.revireScore(sqlSession, user_id);
		
		model.addAttribute("memberVO", map.get("memberVO"));
		model.addAttribute("udongGrade", map.get("udongGrade"));
		model.addAttribute("score", map.get("score"));
		return "member/memberModify";
	}
	
	// 회원정보 수정 처리
	@RequestMapping(value = "/member/memberModifyAction.woo", method = { RequestMethod.POST })
	public String memberModifyAction(HttpServletRequest req, Authentication authentication) {
		sqlSession.getMapper(WooMemberImpl.class).changeInfomation(req.getParameter("tel"), req.getParameter("pw"), authentication.getName());
		return "member/memberModify";
	}
		
	// 비밀번호 확인 - 탈퇴하기 진입전
	@RequestMapping("/member/passwordform.woo")
	public String passwordform(Authentication authentication) {
		return "member/passwordform";
	}
	
	// 비밀번호 확인처리 과정
	@RequestMapping("/member/passwordAction.woo")
	public String passwordAction(HttpServletRequest req, Authentication authentication, Model model) {
		WooMemberVO memberVO = ((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class))
				.passwordAction(authentication.getName(), req.getParameter("password"));
		model.addAttribute("memberVO", memberVO);
		String page = null;
		if (memberVO != null) {
			page = "member/withdraw";
		} else {
			page = "member/passwordform";
		}
		return page;
	}

	// 회원 탈퇴
	@RequestMapping("/member/memberWithdraw.woo")
	public String memberWithdraw(Authentication authentication) {
		return "member/withdraw";
	}
	
	@RequestMapping("/member/memberWithdrawAction.woo")
	public String memberWithdrawAction(HttpServletRequest req, Authentication authentication) {
		
		sqlSession.getMapper(WooMemberImpl.class).deleteMemberAction(authentication.getName(), req.getParameter("pass"));
		
		ModelAndView mv = new ModelAndView();
			mv.addObject("LoginNG", "삭제되었습니다.");
		
		HttpSession session = req.getSession();
		session.invalidate();
		
		return "redirect:main/main";
	}
	
	//동네인증 
	@RequestMapping("/member/myPlace.woo")
	public String myPlace(Model model, HttpServletRequest req, HttpSession sessoin, Principal principal) {
		
		
		String user_id = "";
		
		user_id = principal.getName();
		
		Map<String, Object> map = review.revireScore(sqlSession, user_id);
		
		
		WooMemberVO memberVO = (WooMemberVO)map.get("memberVO");
		if(memberVO.getAddr().equals("x")) {
			memberVO.setAddr(null);
		}
		
		model.addAttribute("memberVO", map.get("memberVO"));
		model.addAttribute("udongGrade", map.get("udongGrade"));
		model.addAttribute("score", map.get("score"));
		return "member/myPlace";
	}
	
	@RequestMapping("/member/myPlaceAction.woo")
	public String myPlaceAction(HttpServletRequest req, Principal principal) {
		String juso = req.getParameter("selectJuso").substring(0, req.getParameter("selectJuso").lastIndexOf(" "));
		
		sqlSession.getMapper(WooMemberImpl.class).modify(juso, principal.getName());
		
		return "redirect:myPlace.woo";
	}

	//동네인증 거리계산
	@RequestMapping("/member/myPlaceDistance.woo")
	@ResponseBody
	public Map<String, Object> myPlaceDistance(HttpServletRequest req) {
		Map<String, Object> map = new HashMap<String, Object>();
		double lat = Double.parseDouble(req.getParameter("lat"));
		double lng = Double.parseDouble(req.getParameter("lng"));
		double clat = Double.parseDouble(req.getParameter("clat"));
		double clng = Double.parseDouble(req.getParameter("clng"));
		int distance = sqlSession.getMapper(WooMemberImpl.class).distance(lat, lng, clat, clng);
		
		map.put("distance", distance);
		return map;
	}
	
	
	
}
