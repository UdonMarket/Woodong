package com.kosmo.woodong;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import model.WooBoardListImpl;
import model.WooBoardListVO;
import model.WooMemberImpl;
import model.WooMemberVO;
import naverlogin.NaverLoginBO;

@Controller
public class WooMainController {

	@Autowired
	private SqlSession sqlSession;

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

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
		List<WooBoardListVO> blists = ((WooBoardListImpl) this.sqlSession.getMapper(WooBoardListImpl.class))
				.selectBoard(location);
		model.addAttribute("blists", blists);
		return "community/community";
	}

	// 로그인
	@RequestMapping("/member/login.woo")
	public String login(Principal principal, Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		model.addAttribute("url", naverAuthUrl);

		// Cookie 검사
		String value = null;
		boolean find = false;

		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("USER_ID")) {
					value = cookie.getValue();
					find = true;
					break;
				}
			}
		} else {
			
		}

		if (find == true) {
			model.addAttribute("user_id", value);
		}

		return "member/login";
	}

	// 아이디 비밀번호 찾기
	@RequestMapping("/member/idFind.woo")
	public String idFind() {
		return "member/idFind";
	}

	// 아이디 찾기처리
	@ResponseBody
	@RequestMapping(value = "/member/idFindProc.woo", method = { RequestMethod.POST })
	public Map<String, Object> idFind(HttpServletRequest req, Model model) {
		WooMemberVO vo = ((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class))
				.idFind(req.getParameter("mobile"));
		String id = vo.getId();
		System.out.println(id);
		model.addAttribute("id", id);
		Map map = new HashMap<String, Object>();
		map.put("id", id);

		return map;
	}

	@RequestMapping("/member/pwFind.woo")
	public String pwFind() {
		return "member/pwFind";
	}

	// 패스워드 찾기처리
	@ResponseBody
	@RequestMapping(value = "/member/pwFindProc.woo", method = { RequestMethod.POST })
	public Map<String, Object> pwFind(HttpServletRequest req, Model model) {
		WooMemberVO vo = ((WooMemberImpl) this.sqlSession.getMapper(WooMemberImpl.class))
				.pwFind(req.getParameter("mobile"));
		String pw = vo.getPass();
		System.out.println(pw);
		String mobile = req.getParameter("mobile");
		Map map = new HashMap<String, Object>();
		map.put("pw", pw);
		map.put("mobile", mobile);

		return map;
	}

	// 아이디저장-쿠키
	@ResponseBody
	@RequestMapping("/member/idSave.woo")
	public Map<String, Object> idSave(HttpServletRequest req, Model model, Authentication authentication,
			HttpServletResponse response) {
		String chk = req.getParameter("chk");
		System.out.println(chk);
		String user_id = req.getParameter("id");
		System.out.println(user_id);
		int num = Integer.parseInt(req.getParameter("num"));
		System.out.println(num);

		Cookie ck = new Cookie("USER_ID", user_id);
		if (num%2==0) {
			ck.setPath("/");
			ck.setMaxAge(60 * 60 * 24 * 100);
			response.addCookie(ck);
		}
		else {
			Cookie myCookie = new Cookie("USER_ID", null);
			myCookie.setMaxAge(0); // 쿠키의 expiration 타임을 0으로 하여 없앤다.
			myCookie.setPath("/"); // 모든 경로에서 삭제 됬음을 알린다.
			response.addCookie(myCookie);
		}
		
		
		Map map = new HashMap<String, Object>();
		map.put("user_id", user_id);
		map.put("num", num);
		

		return map;
	}

	@RequestMapping("/member/accessDenied.woo")
	public String accessDenied() {
		return "member/accessDenied";
	}

	@RequestMapping("/board/write.woo")
	public String write() {
		return "board/write";
	}
}
