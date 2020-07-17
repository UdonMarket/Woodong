package com.kosmo.woodong;

import javax.servlet.http.HttpServletRequest;
import model.MemberVO;
import model.MybatisMemberImpl;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
		return authentication.getName() == null ? "redirect:login.do" : "member/withdraw";
	}

	@RequestMapping("/member/deleteMemberAction")
	public String deleteMemberAction(HttpServletRequest req, Authentication authentication) {
		if (authentication.getName() == null) {
			return "redirect:login.do";
		} else {
			((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class))
					.deleteMemberAction(authentication.getName(), req.getParameter("pass"));
			return "main/main";
		}
	}
}