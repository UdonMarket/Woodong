package com.kosmo.woodong;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import model.BoardListDTO;
import model.BoardListImpl;
import model.MemberVO;
import model.MybatisMemberImpl;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class AdminController {
	@Autowired
	private SqlSession sqlSession;
	
	// main
	@RequestMapping("/admin.woo")
	public String admin1() {
		return "admin/main/adminHome";
	}

	@RequestMapping("/admin/admin.woo")
	public String admin2() {
		return "admin/main/admin";
	}

	// member
	@RequestMapping("/admin/login.woo")
	public String login() {
		return "admin/member/login";
	}

	@RequestMapping("/admin/memberTable.woo")
	public String member_list(Model model, HttpServletRequest req) {
		MemberVO memberVO = new MemberVO();
		memberVO.setSearchField(req.getParameter("searchField"));
		memberVO.setSearchTxt(req.getParameter("searchTxt"));
		memberVO.setGrade(req.getParameter("grade"));
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
		return "admin/member/memberTable";
	}

	@RequestMapping("/admin/delete.woo")
	public String delete(HttpServletRequest req) {
		((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class)).delete(req.getParameter("id"));
		return "redirect:../member/memberTable.woo";
	}
	
	// board
	@RequestMapping("/admin/addBoard.woo")
	public String addBoard(Model model, HttpServletRequest req) {
		
		String location = ".." + req.getServletPath();
		System.out.println(location);
		List<BoardListDTO> blists = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class)).selectBoard(location);
		
		model.addAttribute("blists", blists);
		
		return "admin/board/addBoard";
	}
	@RequestMapping("/admin/addBoardAction.woo")
	public String addBoardAction(Model model, BoardListDTO boardListDTO) {
		
		boardListDTO.setRequestname(boardListDTO.getLocation() + "?bname=" + boardListDTO.getBname() + "&");
		System.out.println(boardListDTO.getLocation());
		int border = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class))
				.selectOrder(boardListDTO.getLocation());
		boardListDTO.setBoardorder(String.valueOf(border + 1));
		((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class)).createboard(boardListDTO);
		
		return "redirect:../admin/addBoard.woo";
	}
}