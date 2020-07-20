package com.kosmo.woodong;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import model.BoardListDTO;
import model.BoardListImpl;
import model.ParameterVO;
import model.WooBoardDAOImpl;
import model.WooBoardVO;

@Controller
public class WooBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(WooBoardController.class);
	
	
	@Autowired
	private SqlSession sqlSession;
	

	//1. 상품게시판 진입
	@RequestMapping("/product/productList.woo")
	public String board(Model model, HttpServletRequest req) {
		logger.info("board");
		
		String location = ".." + req.getServletPath();
		System.out.println(location);
		List<BoardListDTO> blists = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class))
				.selectBoard(location);
		model.addAttribute("blists", blists);
		
		return "product/productList";
	}

	//2. 상품게시판 (리스트) ajax 처리
	@RequestMapping("/product/ajaxList.woo")
	public ModelAndView list(Model model, HttpServletRequest req) {
		
		ModelAndView mv = new ModelAndView();
		ParameterVO parameterVO = new ParameterVO();
		
		int pageSize = 15;
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		
		System.out.println("nowPage : " + nowPage);
		
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;
		
		parameterVO.setStart(start);
		parameterVO.setEnd(end);
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		
		int total = ((WooBoardDAOImpl) this.sqlSession.getMapper(WooBoardDAOImpl.class)).getTotalCount(parameterVO);
		
		ArrayList<WooBoardVO> lists = ((WooBoardDAOImpl) this.sqlSession.getMapper(WooBoardDAOImpl.class))
				.listPage(parameterVO);
		
		Iterator itr = lists.iterator();

		while (itr.hasNext()) {
			WooBoardVO dto = (WooBoardVO) itr.next();
			String temp = dto.getContents().replace("\r\n", "<br/>");
			dto.setContents(temp);
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

	//3.상품리스트 상세보기 
	@RequestMapping("/product/productView.woo")
	public String productView(Model model, HttpServletRequest req) {
		
		String idx = req.getParameter("idx");
		String nowPage = req.getParameter("nowPage");
		
		//상세보기
		WooBoardVO dto = ((WooBoardDAOImpl) this.sqlSession.getMapper(WooBoardDAOImpl.class)).view(idx);
		//조회수 처리
		int applyRow = ((WooBoardDAOImpl) this.sqlSession.getMapper(WooBoardDAOImpl.class)).visitcount(idx);
		
		System.out.println("상품리스트 상세보기 : "+applyRow);	
		dto.setContents(dto.getContents().replace("\r\n","<br/>"));
		
		model.addAttribute("viewRow", dto);
		model.addAttribute("nowPage", nowPage);
		
		return "product/productView";
	}

	//4-1.글쓰기 폼으로 진입
	@RequestMapping("/product/productWrite.woo")
	public String productWrite(Principal principal,Model model) {
		
		List<BoardListDTO> selectlist = null;
		String user_id="";
		try {
			user_id = principal.getName();
			System.out.println("글쓰기 진입 user_id : "+user_id);
			selectlist = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class))
					.selectBname();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("selectlist", selectlist);
		model.addAttribute("user_id",user_id);
		return "product/productWrite";
	}

	//4-2.글쓰기 처리
	@RequestMapping(method = RequestMethod.POST, value="/product/writeAction.woo")
	public String productWriteAction(Principal principal, WooBoardVO wooBoardVO ,
								MultipartHttpServletRequest req) throws Exception {
		
		
		String user_id="";
		user_id = principal.getName();
		wooBoardVO.setId(user_id);
		
		List<Map<String, Object>> lists = new util.FileUtils().parseInsertFileInfo(wooBoardVO, req); 
		int applyRow = sqlSession.getMapper(WooBoardDAOImpl.class).write(wooBoardVO);
		
			
		return "redirect:productList.woo?nowPage=1";
	}
	
	//5-1.글 수정하기
	@RequestMapping("/product/modify.woo")
	public String modify(Model model , MultipartHttpServletRequest req) {
		
		
		
		return "product/modify";
	}
	//5-2.글 수정 처리 하기
	@RequestMapping("/product/modifyAction.woo")
	public String modifyAction(){
		
		
		
		return "redirect:./productList.woo";
	}
	//6.글 삭제하기
	@RequestMapping("/product/delete.woo")
	public String delete(HttpServletRequest req , Principal principal) {
		
		ParameterVO parameterVO = new ParameterVO();
		
		String user_id = "";
		String board_idx = "";
		//로그인 확인
		try {
			user_id = principal.getName();
			parameterVO.setUser_id(user_id);
			System.out.println("user_id : "+user_id);
			
			board_idx = req.getParameter("idx");
			parameterVO.setBoard_idx(board_idx);
			
			int applyRow = sqlSession.getMapper(WooBoardDAOImpl.class).delete(parameterVO);
					
			System.out.println("삭제 처리 된 레코드 수 :" + applyRow);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:./productList.woo";
	}
	
	
	
	//커뮤니티 게시판 진입
	@RequestMapping("/community/community.woo")
	public String community(Model model, HttpServletRequest req) {
		String location = ".." + req.getServletPath();
		List<BoardListDTO> blists = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class))
				.selectBoard(location);
		model.addAttribute("blists", blists);
		return "community/community";
	}
	
}