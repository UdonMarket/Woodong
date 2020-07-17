package com.kosmo.woodong;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import model.MemberVO;
import model.MybatisMemberImpl;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class AdminController {
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/admin.woo")
	public String admin1() {
		return "admin/main/adminHome";
	}

	@RequestMapping("/admin/admin.woo")
	public String admin2() {
		return "admin/main/admin";
	}

	@RequestMapping("/admin/login.woo")
	public String login() {
		return "admin/member/login";
	}

	@RequestMapping("/admin/memberTable.woo")
	public String member_list(Model model, HttpServletRequest req) {
		MemberVO memberVO = new MemberVO();
		memberVO.setSearchField(req.getParameter("searchField"));
		memberVO.setSearchTxt(req.getParameter("searchTxt"));
		int totalRecordCount = ((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class))
				.getTotalCount(memberVO);
		int pageSize = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.pageSize"));
		int blockPage = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.blockPage"));
		int totalPage = (int) Math.ceil((double) totalRecordCount / (double) pageSize);
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;
		memberVO.setStart(start);
		memberVO.setEnd(end);
		ArrayList<MemberVO> lists = ((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class))
				.listPage(memberVO);
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
				req.getContextPath() + "/admin/memberTable.woo?");
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("lists", lists);
		return "admin/main/memberTable";
	}

	@RequestMapping("/admin/delete.woo")
	public String delete(HttpServletRequest req) {
		((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class)).delete(req.getParameter("delete"));
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("LoginNG", "삭제되었습니다.");
		
		return "admin/main/memberTable";
	}
}