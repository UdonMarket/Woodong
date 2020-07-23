package com.kosmo.woodong;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.MemberVO;
import model.MybatisMemberImpl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/member/join.woo")
	public String join() {
		return "member/join";
	}

	@RequestMapping("/member/addMember.woo")
	public String addMember(HttpServletRequest req) {
		System.out.println("test");
		MemberVO memberVO = new MemberVO();
		memberVO.setId(req.getParameter("email"));
		memberVO.setPass(req.getParameter("pass"));
		memberVO.setMobile(req.getParameter("mobile"));
		((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class)).regist(memberVO);
		return "main/main";
	}

	@RequestMapping("/member/myProfile_modify.woo")
	public String myProfile_modify(Authentication authentication) {
		return authentication.getName() == null ? "redirect:login.do" : "member/myProfile_modify";
	}

	@RequestMapping("/member/passwordform.woo")
	public String passwordform(Authentication authentication) {
		return authentication.getName() == null ? "redirect:login.do" : "member/passwordform";
	}

	@RequestMapping("/member/passwordAction.woo")
	public String passwordAction(HttpServletRequest req, Authentication authentication, Model model) {
		if (authentication.getName() == null) {
			return "redirect:login.do";
		} else {
			MemberVO memberVO = ((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class))
					.passwordAction(authentication.getName(), req.getParameter("password"));
			model.addAttribute("memberVO", memberVO);
			String page = null;
			if (memberVO != null) {
				page = "member/myProfile_modify";
			} else {
				page = "member/passwordform";
			}

			return page;
		}
	}

	//회원정보수정
	@RequestMapping("/member/changeInfomation.woo")
	public String changeInfomation(HttpServletRequest req, Authentication authentication) {
		if (authentication.getName() == null) {
			return "redirect:login.do";
		} else {
			((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class))
					.changeInfomation(req.getParameter("tel"), req.getParameter("pw"), authentication.getName());
			return "member/myProfile_modify";
		}
	}

	@RequestMapping("/member/deleteMember.woo")
	public String deleteMember(Authentication authentication) {
		if(authentication.getName() == null) {
			return "redirect:login.do";
		}
		return "member/withdraw";
	}
	
	//동네인증 
	@RequestMapping("/member/myPlace.woo")
	public String myPlace(Model model, HttpServletRequest req, HttpSession sessoin, Authentication authentication) {
		
		if (authentication.getName() == null) {
			return "redirect:login.woo";
		} else {
			String id = authentication.getName();
			MemberVO dto = ((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class)).view(id);
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
			((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class))
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
		int distance = sqlSession.getMapper(MybatisMemberImpl.class).distance(lat, lng, clat, clng);
		
		map.put("distance", distance);
		return map;
	}
	//회원삭제
	@RequestMapping("/member/deleteMemberAction")
	public String deleteMemberAction(HttpServletRequest req, Authentication authentication) {
		if (authentication.getName() == null) {
			return "redirect:login.do";
		} 
		else {
			((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class))
					.deleteMemberAction(authentication.getName(), req.getParameter("pass"));
			
			ModelAndView mv = new ModelAndView();
				mv.addObject("LoginNG", "삭제되었습니다.");
			
			return "main/main";
		}
	}
}
