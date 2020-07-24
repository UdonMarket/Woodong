package com.kosmo.woodong;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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

import model.BoardListImpl;
import model.BoardListVO;
import model.FileVO;
import model.MypageDAOImpl;
import model.ParameterVO;
import model.WooBoardDAOImpl;
import model.WooBoardVO;
import oracle.net.aso.p;

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
		List<BoardListVO> blists = ((BoardListImpl) sqlSession.getMapper(BoardListImpl.class))
				.selectBoard(location);
		model.addAttribute("blists", blists);
		
		String mode = req.getParameter("mode")==null ? "common" : req.getParameter("mode");
		ParameterVO parameterVO = new ParameterVO();
		parameterVO.setLatTxt((req.getParameter("lat")==null)? 0 : Double.parseDouble(req.getParameter("lat")));
		parameterVO.setLngTxt((req.getParameter("lon")==null)? 0 : Double.parseDouble(req.getParameter("lon")));
		parameterVO.setBname(req.getParameter("bname"));
		model.addAttribute("mode", mode);
		model.addAttribute("parameterVO", parameterVO);
		if(mode.equals("map")) {
			//폼값받기
			ArrayList<WooBoardVO> searchLists  = sqlSession.getMapper(WooBoardDAOImpl.class).searchRadius(parameterVO);
			for(WooBoardVO vo : searchLists) {
				String idx = vo.getIdx();
				ArrayList<FileVO> uploadFileList = ((WooBoardDAOImpl)sqlSession.getMapper(WooBoardDAOImpl.class)).viewFile(idx);
		
			 	String image = uploadFileList.get(0).getSave_name();
				vo.setImagefile(image);
				
			}
			model.addAttribute("searchLists",searchLists);
			return "product/productListMap";
		}
		else {
			return "product/productList";
		}
	}

	//2. 상품게시판 (리스트) ajax 처리
	@RequestMapping("/product/ajaxList.woo")
	public ModelAndView list(Model model, HttpServletRequest req, Principal principal) {
		
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
		
		int total = ((WooBoardDAOImpl) sqlSession.getMapper(WooBoardDAOImpl.class)).getTotalCount(parameterVO);
		
		ArrayList<WooBoardVO> lists = ((WooBoardDAOImpl) sqlSession.getMapper(WooBoardDAOImpl.class)).listPage(parameterVO);
				
		
		Iterator itr = lists.iterator();

		//소영 추가부분
		String user_id = principal.getName();

		String str = sqlSession.getMapper(MypageDAOImpl.class).selectLike(user_id);
		String[] splitStr = str.split("#");

		for (int i = 0; i < lists.size(); i++) {
				for (int j = 0; j < splitStr.length; j++) {
				if(splitStr[j].equals(lists.get(i).getIdx())) {
					lists.get(i).setLike_check(1);
				}
			}
		}

		while (itr.hasNext()) {
			WooBoardVO dto = (WooBoardVO) itr.next();
			String temp = dto.getContents().replace("\r\n", "<br/>");
			dto.setContents(temp);
			String idx = dto.getIdx();
			
			ArrayList<FileVO> uploadFileList = ((WooBoardDAOImpl) this.sqlSession.getMapper(WooBoardDAOImpl.class)).viewFile(idx);
			
			if(!uploadFileList.isEmpty() && uploadFileList.size()!=0) {
				//리스트에서 대표이미지 설정
				String image =  uploadFileList.get(0).getSave_name(); 
				dto.setImagefile(image);
			}
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
		//
		String idx = req.getParameter("idx");
		String nowPage = req.getParameter("nowPage");
		
		//상세보기
		WooBoardVO dto = ((WooBoardDAOImpl) sqlSession.getMapper(WooBoardDAOImpl.class)).view(idx);
		
		//조회수 처리
		int applyRow = ((WooBoardDAOImpl) sqlSession.getMapper(WooBoardDAOImpl.class)).visitcount(idx);

		//파일 불러오기
		ArrayList<FileVO> uploadFileList = ((WooBoardDAOImpl) sqlSession.getMapper(WooBoardDAOImpl.class)).viewFile(idx);
		
		dto.setContents(dto.getContents().replace("\r\n","<br/>"));
		
		model.addAttribute("viewRow", dto);
		//
		model.addAttribute("uploadFileList", uploadFileList);
		model.addAttribute("nowPage", nowPage);
		
		return "product/productView";
	}

	//4-1.글쓰기 폼으로 진입
	@RequestMapping("/product/productWrite.woo")
	public String productWrite(Principal principal,Model model) {
		
		List<BoardListVO> selectlist = null;
		String user_id="";
		try {
			user_id = principal.getName();
			System.out.println("글쓰기 진입 user_id : "+user_id);
			selectlist = ((BoardListImpl) sqlSession.getMapper(BoardListImpl.class)).selectBname();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("selectlist", selectlist);
		model.addAttribute("user_id",user_id);
		return "product/productWrite";
	}

	//4-2.글쓰기 처리
	@RequestMapping(method = RequestMethod.POST,headers = "content-type=multipart/*", value="/product/writeAction.woo"  )
	public String productWriteAction(Principal principal, WooBoardVO wooBoardVO ,
								MultipartHttpServletRequest mreq) throws Exception {
		
		logger.info("productWriteAction");
		logger.debug("productWriteAction");
		
		String user_id="";
		user_id = principal.getName();
		wooBoardVO.setId(user_id);
		
		int applyRow = sqlSession.getMapper(WooBoardDAOImpl.class).write(wooBoardVO);
		
		List<Map<String, Object>> list = new util.FileUtils().parseInsertFileInfo(wooBoardVO, mreq); 
		
		Map<String, Object> map = null;
		int size = list.size();
		//파일테이블에 insert
		for(int i=0; i<size; i++){ 
			map = list.get(i);
			sqlSession.getMapper(WooBoardDAOImpl.class).insertFile(map);
		}
			
		return "redirect:productList.woo?nowPage=1";
	}
	
	//5-1.글 수정하기
	@RequestMapping(method = RequestMethod.POST, value="/product/productUpdate.woo")
	public String update(Model model , HttpServletRequest req,Principal principal) {
		
		logger.info("modify");
		logger.debug("modify");
		String idx = req.getParameter("idx");
		String nowPage = req.getParameter("nowPage");
		String bname = req.getParameter("bname");
		String user_id = "";
		List<BoardListVO> selectlist = null;
		
		try {
			user_id = principal.getName();
			//woo_board DB에서  select
			WooBoardVO dto = ((WooBoardDAOImpl) sqlSession.getMapper(WooBoardDAOImpl.class)).view(idx);
			
			// 로그인한 아이디와 글 작성자의 아이디 비교
			if(!user_id.equals(dto.getId())) {
				return "redirect:productList.woo";
			}
			
			//bname 가져오기
			selectlist = ((BoardListImpl) sqlSession.getMapper(BoardListImpl.class)).selectBname();
			
			//파일 불러오기
			ArrayList<FileVO> uploadFileList = ((WooBoardDAOImpl) this.sqlSession.getMapper(WooBoardDAOImpl.class)).viewFile(idx);
			//엔터 처리
			dto.setContents(dto.getContents().replace("\r\n","<br/>"));
			
			model.addAttribute("viewRow", dto);
			model.addAttribute("uploadFileList", uploadFileList);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("bname", bname);
			model.addAttribute("selectlist", selectlist);
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "product/productUpdate";
	}
	
	
	//5-2.글 수정 처리 하기
	@RequestMapping(method = RequestMethod.POST,headers = "content-type=multipart/*", value="/product/updateAction.woo")
	public String updateAction(WooBoardVO wooBoardVO , MultipartHttpServletRequest req, Principal principal){
		
		logger.info("modifyAction");
		logger.debug("modifyAction");
		String user_id = "";
		
		try {
			user_id = principal.getName();
			wooBoardVO.setId(user_id);
			int applyRow = sqlSession.getMapper(WooBoardDAOImpl.class).modify(wooBoardVO);
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:./productView.woo";
	}
	
	//6.글 삭제하기
	@RequestMapping("/product/productDelete.woo")
	public String delete(HttpServletRequest req , Principal principal) {
		
		ParameterVO parameterVO = new ParameterVO();
		logger.info("delete");
		logger.debug("delete");
		String idx = req.getParameter("idx");
		String user_id = "";
		
		//로그인 확인
		try {
			user_id = principal.getName();
			parameterVO.setId(user_id);
			parameterVO.setIdx(idx);
			int applyRow = sqlSession.getMapper(WooBoardDAOImpl.class).delete(parameterVO);
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:./productList.woo";
	}
	
	
}
