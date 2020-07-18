package com.kosmo.woodong;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import model.BoardListVO;
import model.BoardListImpl;
import model.ParameterVO;
import model.WooBoardDAOImpl;
import model.WooBoardVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WooBoardController {
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/product/productList.woo")
	public String board(Model model, HttpServletRequest req) {
		
		String location = ".." + req.getServletPath();
		System.out.println(location);
		List<BoardListVO> blists = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class))
				.selectBoard(location);
		model.addAttribute("blists", blists);
		
		return "product/productList";
	}

	@RequestMapping("/product/ajaxList.woo")
	public ModelAndView list(Model model, HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		ParameterVO parameterDTO = new ParameterVO();
		int pageSize = 15;
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		System.out.println("nowPage : " + nowPage);
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		int total = ((WooBoardDAOImpl) this.sqlSession.getMapper(WooBoardDAOImpl.class)).getTotalCount(parameterDTO);
		ArrayList<WooBoardVO> lists = ((WooBoardDAOImpl) this.sqlSession.getMapper(WooBoardDAOImpl.class))
				.listPage(parameterDTO);
		Iterator var12 = lists.iterator();

		while (var12.hasNext()) {
			WooBoardVO dto = (WooBoardVO) var12.next();
			String temp = dto.getContent().replace("\r\n", "<br/>");
			dto.setContent(temp);
		}

		System.out.println("total : " + total);
		if (start > total) {
			mv.addObject("state", "false");
		} else {
			mv.addObject("state", "true");
		}

		mv.setViewName("product/ajaxList");
		mv.addObject("lists", lists);
		return mv;
	}

	@RequestMapping("/product/productView.woo")
	public String productView(Model model, HttpServletRequest req) {
		String idx = req.getParameter("idx");
		String nowPage = req.getParameter("nowPage");
		new WooBoardVO();
		WooBoardVO dto = ((WooBoardDAOImpl) this.sqlSession.getMapper(WooBoardDAOImpl.class)).view(idx);
		dto.setContent(dto.getContent().replace("\r\n", "<br/>"));
		model.addAttribute("viewRow", dto);
		model.addAttribute("nowPage", nowPage);
		return "product/productView";
	}

	@RequestMapping("/product/productWrite.woo")
	public String productWrite() {
		return "product/productWrite";
	}

	@RequestMapping("/product/writeAction.woo")
	public String productWriteAction() {
		return "redirect:productList.do?nowPage=1";
	}
	
	@RequestMapping("/community/community.woo")
	public String community(Model model, HttpServletRequest req) {
		String location = ".." + req.getServletPath();
		List<BoardListVO> blists = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class))
				.selectBoard(location);
		model.addAttribute("blists", blists);
		return "community/community";
	}
}