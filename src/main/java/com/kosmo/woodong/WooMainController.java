package com.kosmo.woodong;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import model.FileVO;
import model.ParameterVO;
import model.WooBoardImpl;
import model.WooBoardListImpl;
import model.WooBoardListVO;
import model.WooBoardVO;
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
	// 메인화면
	@RequestMapping("/main/main1.woo")
	public String main1(Model model, HttpServletRequest req, Principal principal) {
		
		ParameterVO parameterVO = new ParameterVO();
		ArrayList<WooBoardVO> searchLists = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).list(parameterVO);
		
		
		for(WooBoardVO vo : searchLists) {
			String idx = vo.getBoardidx();
			String temp = vo.getContents().replace("\r\n", "<br/>");
			vo.setContents(temp);
			ArrayList<FileVO> uploadFileList = ((WooBoardImpl)sqlSession.getMapper(WooBoardImpl.class)).viewFile(idx);
	
		 	String image = uploadFileList.get(0).getSave_name();
			vo.setImagefile(image);
			
		}
		System.out.println(searchLists.size());
		model.addAttribute("searchLists",searchLists);
		model.addAttribute("parameterVO",parameterVO);
		
		
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
	public String login(Principal principal, Model model, HttpSession session) {
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		model.addAttribute("url", naverAuthUrl);
		return "member/login";
	}
	
	// 아이디 비밀번호 찾기
	@RequestMapping("/member/idFind.woo")
	public String idFind() {
		return "member/idFind";
	}
	@RequestMapping("/member/pwFind.woo")
	public String pwFind() {
		return "member/pwFind";
	}	
	@RequestMapping("/main/popUp.woo")
	public String popUp() {
		return "main/popUp";
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
