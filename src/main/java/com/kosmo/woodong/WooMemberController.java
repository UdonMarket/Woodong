package com.kosmo.woodong;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.WooMemberVO;
import model.WooMemberImpl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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
	@RequestMapping("/member/joinAction.woo")
	public String joinAction(HttpServletRequest req) {
		System.out.println("test");
		WooMemberVO memberVO = new WooMemberVO();
		memberVO.setId(req.getParameter("email"));
		memberVO.setPass(req.getParameter("pass"));
		memberVO.setMobile(req.getParameter("mobile"));
		((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class)).regist(memberVO);
		return "main/main";
	}
	
	// 회원 정보 수정
	@RequestMapping("/member/memberModify.woo")
	public String memberModify(Authentication authentication) {
		return authentication.getName() == null ? "redirect:login.do" : "member/memberModify";
	}
	
	@RequestMapping("/member/memberModifyAction.woo")
	public String memberModifyAction(HttpServletRequest req, Authentication authentication) {
		if (authentication.getName() == null) {
			return "redirect:login.do";
		} else {
			((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class))
					.changeInfomation(req.getParameter("tel"), req.getParameter("pw"), authentication.getName());
			return "member/memberModify";
		}
	}
		
	// 비밀번호 확인
	@RequestMapping("/member/passwordform.woo")
	public String passwordform(Authentication authentication) {
		return authentication.getName() == null ? "redirect:login.do" : "member/passwordform";
	}
	
	@RequestMapping("/member/passwordAction.woo")
	public String passwordAction(HttpServletRequest req, Authentication authentication, Model model) {
		if (authentication.getName() == null) {
			return "redirect:login.do";
		} else {
			WooMemberVO memberVO = ((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class))
					.passwordAction(authentication.getName(), req.getParameter("password"));
			model.addAttribute("memberVO", memberVO);
			String page = null;
			if (memberVO != null) {
				page = "member/memberModify";
			} else {
				page = "member/passwordform";
			}

			return page;
		}
	}

	// 회원 탈퇴
	@RequestMapping("/member/memberWithdraw.woo")
	public String memberWithdraw(Authentication authentication) {
		if(authentication.getName() == null) {
			return "redirect:login.do";
		}
		return "member/withdraw";
	}
	
	@RequestMapping("/member/memberWithdrawAction.woo")
	public String memberWithdrawAction(HttpServletRequest req, Authentication authentication) {
		if (authentication.getName() == null) {
			return "redirect:login.do";
		} 
		else {
			((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class))
					.deleteMemberAction(authentication.getName(), req.getParameter("pass"));
			
			ModelAndView mv = new ModelAndView();
				mv.addObject("LoginNG", "삭제되었습니다.");
			
			return "main/main";
		}
	}
	
	//동네인증 
	@RequestMapping("/member/myPlace.woo")
	public String myPlace(Model model, HttpServletRequest req, HttpSession sessoin, Authentication authentication) {
		
		if (authentication.getName() == null) {
			return "redirect:login.woo";
		} else {
			String id = authentication.getName();
			WooMemberVO dto = ((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class)).view(id);
			model.addAttribute("dto", dto);
			
			return "member/myPlace";
		}
		
	}
	@RequestMapping("/member/myPlaceAction.woo")
	public String myPlaceAction(HttpServletRequest req, Authentication authentication) {
		System.out.println(req.getParameter("addr"));
		System.out.println(authentication.getName());
		if (authentication.getName() == null) {
			return "redirect:login.woo";
		} else {
			((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class))
			.modify(req.getParameter("selectJuso"), authentication.getName());
			
			return "redirect:myPlace.woo";
		}
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
