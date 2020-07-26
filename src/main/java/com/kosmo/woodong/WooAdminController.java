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
import org.springframework.web.servlet.ModelAndView;

import model.WooBoardListVO;
import model.WooBoardListImpl;
import model.WooMemberVO;
import model.WooMemberImpl;
import model.ParameterVO;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
@Transactional(rollbackFor = {Exception.class})
public class WooAdminController {
	@Autowired
	private SqlSession sqlSession;
	
	// 메인화면
	@RequestMapping("/admin.woo")
	public String admin1() {
		return "admin/main/adminHome";
	}

	@RequestMapping("/admin/admin.woo")
	public String admin2() {
		return "admin/main/admin";
	}

	// 로그인
	@RequestMapping("/admin/login.woo")
	public String login() {
		return "admin/member/login";
	}
	
	// 멤버 관리
	@RequestMapping("/admin/memberTable.woo")
	public String memberTable(Model model, HttpServletRequest req) {
		WooMemberVO memberVO = new WooMemberVO();
		memberVO.setSearchField(req.getParameter("searchField"));
		memberVO.setSearchTxt(req.getParameter("searchTxt"));
		memberVO.setGrade(req.getParameter("grade"));
		int totalRecordCount = sqlSession.getMapper(WooMemberImpl.class).getTotalCount(memberVO);
		int pageSize = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.pageSize"));
		int blockPage = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.blockPage"));
		int totalPage = (int) Math.ceil((double) totalRecordCount / (double) pageSize);
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;
		memberVO.setStart(start);
		memberVO.setEnd(end);
		ArrayList<WooMemberVO> lists = sqlSession.getMapper(WooMemberImpl.class).listPage(memberVO);
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
				req.getContextPath() + "/admin/memberTable.woo?");
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("lists", lists);
		return "admin/member/memberTable";
	}
	
	// 멤버 삭제
	@RequestMapping("/admin/delete.woo")
	public String delete(HttpServletRequest req) {
		sqlSession.getMapper(WooMemberImpl.class).delete(req.getParameter("delete"));
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("LoginNG", "삭제되었습니다.");
		
		return "redirect:../admin/memberTable.woo";
	}
	
	// 다수의 멤버삭제
	@RequestMapping("/admin/memberDelete.woo")
	public String memberDelete(HttpServletRequest req) {
		String checkIdList = req.getParameter("checkId");
		ArrayList<String> idList = new ArrayList<String>();
		String[] checkIdArr = checkIdList.split("//");
		for(int i=0 ; i<checkIdArr.length-1 ; i++) {
			System.out.println(checkIdArr[i]);
			idList.add(checkIdArr[i]);
		}
		ParameterVO parameterVO = new ParameterVO();
		parameterVO.setList(idList);
		sqlSession.getMapper(WooMemberImpl.class).deleteMember(parameterVO);
		
		return "admin/board/memberTable";
	}
	
	// 게시판 생성
	@RequestMapping("/admin/addBoard.woo")
	public String addBoard(Model model, HttpServletRequest req) {
		
		String location = ".." + req.getServletPath();
		
		List<WooBoardListVO> blists = sqlSession.getMapper(WooBoardListImpl.class).selectBoard(location);
		List<Map<String, Object>> locationOrder = sqlSession.getMapper(WooBoardListImpl.class).selectLocationOrder();
		model.addAttribute("blists", blists);
		model.addAttribute("locationOrder", locationOrder);
		
		return "admin/board/addBoard";
	}
	
	@RequestMapping("/admin/addBoardAction.woo")
	public String addBoardAction(WooBoardListVO boardListVO) {
		boardListVO.setRequestname(boardListVO.getLocation() + "?bname=" + boardListVO.getBname() + "&");
		int boardorder = sqlSession.getMapper(WooBoardListImpl.class).selectMaxOrder(boardListVO.getLocation());
		boardListVO.setBoardorder(boardorder+1);
		sqlSession.getMapper(WooBoardListImpl.class).createboard(boardListVO);
		
		return "redirect:../admin/addBoard.woo";
	}
	
	// 게시판 수정
	@RequestMapping("/admin/editBoard.woo")
	public String editBoard(WooBoardListVO boardListVO){
		try {
			if(boardListVO.getLocation().equals(sqlSession.getMapper(WooBoardListImpl.class).selectLocation(boardListVO.getBoardlistidx()))) {
				int boardorder = sqlSession.getMapper(WooBoardListImpl.class).selectorder(boardListVO.getBoardlistidx());
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
					sqlSession.getMapper(WooBoardListImpl.class).updateOrder1(boardListVO.getBoardlistidx());
					sqlSession.getMapper(WooBoardListImpl.class).updateOrder2(parameterVO);
					sqlSession.getMapper(WooBoardListImpl.class).updateOrder3(boardListVO);
				}
				boardListVO.setRequestname(boardListVO.getLocation() + "?bname=" + boardListVO.getBname() + "&");
				sqlSession.getMapper(WooBoardListImpl.class).editboard(boardListVO);
			}
			else {
				// 원래 location
				String location = sqlSession.getMapper(WooBoardListImpl.class).selectLocation(boardListVO.getBoardlistidx());
				// 원래 order
				int order = sqlSession.getMapper(WooBoardListImpl.class).selectorder(boardListVO.getBoardlistidx());
				sqlSession.getMapper(WooBoardListImpl.class).selectMaxOrder(location);
				// 새로운 카테고리의 boardorder 최댓값
				int boardorder = sqlSession.getMapper(WooBoardListImpl.class).selectMaxOrder(boardListVO.getLocation());
				boardListVO.setBoardorder(boardorder+1);
				boardListVO.setRequestname(boardListVO.getLocation() + "?bname=" + boardListVO.getBname() + "&");
				sqlSession.getMapper(WooBoardListImpl.class).editboard(boardListVO);
				// 뺴는거(제일 마지막)
				sqlSession.getMapper(WooBoardListImpl.class).updateOrder(location, order);
			}
		}
		catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return "redirect:../admin/addBoard.woo";
	}
	
	// 게시판 삭제
	@RequestMapping("/admin/deleteBoard.woo")
	public String deleteBoard(WooBoardListVO boardListVO) {
		
		sqlSession.getMapper(WooBoardListImpl.class).deleteboard(boardListVO.getBoardlistidx());
		
		sqlSession.getMapper(WooBoardListImpl.class).updateOrder(boardListVO.getLocation(), boardListVO.getBoardorder());
		
		return "redirect:../admin/addBoard.woo";
	}
	
	// 게시판 관리
	@RequestMapping("/admin/boardTable.woo")
	public String boardTable() {
		return "admin/board/boardTable";
	}

}
