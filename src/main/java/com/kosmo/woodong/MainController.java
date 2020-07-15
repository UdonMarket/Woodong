package com.kosmo.woodong;

import java.security.Principal;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	@RequestMapping("/member/join01.woo")
	public String join01() {
		return "member/join01";
	}

	@RequestMapping("/member/login.woo")
	public String securityIndex2Login(Principal principal, Model model) {
		return "member/login";
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

	@RequestMapping("/write.woo")
	public String write() {
		return "write";
	}
}