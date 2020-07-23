package com.kosmo.woodong;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import model.BoardListVO;
import model.Listaaa;
import model.BoardListImpl;
import model.MemberVO;
import model.MybatisMemberImpl;
import model.ParameterVO;
import oracle.net.aso.p;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
@Transactional(rollbackFor = {Exception.class})
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
		int totalRecordCount = sqlSession.getMapper(MybatisMemberImpl.class).getTotalCount(memberVO);
		int pageSize = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.pageSize"));
		int blockPage = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.blockPage"));
		int totalPage = (int) Math.ceil((double) totalRecordCount / (double) pageSize);
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;
		memberVO.setStart(start);
		memberVO.setEnd(end);
		ArrayList<MemberVO> lists = sqlSession.getMapper(MybatisMemberImpl.class).listPage(memberVO);
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
				req.getContextPath() + "/admin/memberTable.woo?");
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("lists", lists);
		return "admin/member/memberTable";
	}

	@RequestMapping("/admin/delete.woo")
	public String delete(HttpServletRequest req) {
		sqlSession.getMapper(MybatisMemberImpl.class).delete(req.getParameter("delete"));
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("LoginNG", "삭제되었습니다.");
		
		return "redirect:../admin/memberTable.woo";
	}
	
	// board
	@RequestMapping("/admin/addBoard.woo")
	public String addBoard(Model model, HttpServletRequest req) {
		
		String location = ".." + req.getServletPath();
		
		List<BoardListVO> blists = sqlSession.getMapper(BoardListImpl.class).selectBoard(location);
		List<Map<String, Object>> locationOrder = sqlSession.getMapper(BoardListImpl.class).selectLocationOrder();
		model.addAttribute("blists", blists);
		model.addAttribute("locationOrder", locationOrder);
		
		return "admin/board/addBoard";
	}
	@RequestMapping("/admin/addBoardAction.woo")
	public String addBoardAction(BoardListVO boardListVO) {
		boardListVO.setRequestname(boardListVO.getLocation() + "?bname=" + boardListVO.getBname() + "&");
		int boardorder = sqlSession.getMapper(BoardListImpl.class).selectMaxOrder(boardListVO.getLocation());
		boardListVO.setBoardorder(boardorder+1);
		sqlSession.getMapper(BoardListImpl.class).createboard(boardListVO);
		
		return "redirect:../admin/addBoard.woo";
	}
	

	@RequestMapping("/admin/editBoard.woo")
	public String editBoard(BoardListVO boardListVO){
		try {
			if(boardListVO.getLocation().equals(sqlSession.getMapper(BoardListImpl.class).selectLocation(boardListVO.getIdx()))) {
				int boardorder = sqlSession.getMapper(BoardListImpl.class).selectorder(boardListVO.getIdx());
				if(boardorder!=boardListVO.getBoardorder()) {
					ParameterVO parameterVO = new ParameterVO();
					parameterVO.setLocationname(boardListVO.getLocationname());
					if(boardorder>boardListVO.getBoardorder()) {
						parameterVO.setStart(boardListVO.getBoardorder());
						parameterVO.setEnd(boardorder);
						parameterVO.setNum(1);
					}
					else {
						parameterVO.setStart(boardorder);
						parameterVO.setEnd(boardListVO.getBoardorder());
						parameterVO.setNum(-1);
					}
					sqlSession.getMapper(BoardListImpl.class).updateOrder1(boardListVO.getIdx());
					sqlSession.getMapper(BoardListImpl.class).updateOrder2(parameterVO);
					sqlSession.getMapper(BoardListImpl.class).updateOrder3(boardListVO);
				}
				boardListVO.setRequestname(boardListVO.getLocation() + "?bname=" + boardListVO.getBname() + "&");
				sqlSession.getMapper(BoardListImpl.class).editboard(boardListVO);
			}
			else {
				// 원래 location
				String location = sqlSession.getMapper(BoardListImpl.class).selectLocation(boardListVO.getIdx());
				// 원래 order
				int order = sqlSession.getMapper(BoardListImpl.class).selectorder(boardListVO.getIdx());
				sqlSession.getMapper(BoardListImpl.class).selectMaxOrder(location);
				// 새로운 카테고리의 boardorder 최댓값
				int boardorder = sqlSession.getMapper(BoardListImpl.class).selectMaxOrder(boardListVO.getLocation());
				boardListVO.setBoardorder(boardorder+1);
				boardListVO.setRequestname(boardListVO.getLocation() + "?bname=" + boardListVO.getBname() + "&");
				sqlSession.getMapper(BoardListImpl.class).editboard(boardListVO);
				// 뺴는거(제일 마지막)
				sqlSession.getMapper(BoardListImpl.class).updateOrder(location, order);
			}
		}
		catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return "redirect:../admin/addBoard.woo";
	}
	
	@RequestMapping("/admin/deleteBoard.woo")
	public String deleteBoard(BoardListVO boardListVO) {
		
		sqlSession.getMapper(BoardListImpl.class).deleteboard(boardListVO.getIdx());
		
		sqlSession.getMapper(BoardListImpl.class).updateOrder(boardListVO.getLocation(), boardListVO.getBoardorder());
		
		return "redirect:../admin/addBoard.woo";
	}
	
	@RequestMapping("/admin/boardTable.woo")
	public String boardTable() {
		return "admin/board/boardTable";
	}

}
