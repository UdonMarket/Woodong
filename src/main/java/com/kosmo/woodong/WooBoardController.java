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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import model.FileVO;
import model.ParameterVO;
import model.WooBoardImpl;
import model.WooBoardListImpl;
import model.WooBoardListVO;
import model.WooBoardVO;
import model.WooMemberVO;
import model.WooMypageImpl;

@Controller
public class WooBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(WooBoardController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	//1. 상품게시판 진입
	@RequestMapping("/product/productList.woo")
	public String productList(Model model, HttpServletRequest req) {
		logger.info("productList");
		
		String location = ".." + req.getServletPath();
		List<WooBoardListVO> blists = ((WooBoardListImpl) sqlSession.getMapper(WooBoardListImpl.class))
				.selectBoard(location);
		model.addAttribute("blists", blists);
		
		String mode = req.getParameter("mode")==null ? "common" : req.getParameter("mode");
		ParameterVO parameterVO = new ParameterVO();
		parameterVO.setLatTxt((req.getParameter("lat")==null)? 0 : Double.parseDouble(req.getParameter("lat")));
		parameterVO.setLngTxt((req.getParameter("lon")==null)? 0 : Double.parseDouble(req.getParameter("lon")));
		parameterVO.setBname(req.getParameter("bname"));
		model.addAttribute("mode", mode);
		model.addAttribute("parameterVO", parameterVO);
		
		// 지도 리스트
		if(mode.equals("map")) {
			//폼값받기
			ArrayList<String> list = new ArrayList<String>();
			if(req.getParameter("bname")!=null && !"".equals(req.getParameter("bname"))) {
				list.add(req.getParameter("bname"));
			}
			else {
				blists = sqlSession.getMapper(WooBoardListImpl.class).selectBname("../product/productList.woo");
				for(WooBoardListVO lists : blists) {
					list.add(lists.getBname());
				}
			}
			System.out.println("list크기 : " + list.size());
			parameterVO.setList(list);
			ArrayList<WooBoardVO> searchLists  = sqlSession.getMapper(WooBoardImpl.class).searchRadius(parameterVO);
			
			for(WooBoardVO vo : searchLists) {
				String idx = vo.getBoardidx();
				ArrayList<FileVO> uploadFileList = ((WooBoardImpl)sqlSession.getMapper(WooBoardImpl.class)).viewFile(idx);
				if(!uploadFileList.isEmpty() && uploadFileList.size()!=0) {
			 	String image = uploadFileList.get(0).getSave_name();
				vo.setImagefile(image);
				}
				
			}
			model.addAttribute("searchLists",searchLists);
			return "product/productListMap";
		}
		// 일반 리스트
		else {
			return "product/productList";
		}
	}

	//2. 상품게시판 (리스트) ajax 처리
	@RequestMapping("/product/ajaxList.woo")
	public ModelAndView ajaxList(Model model, HttpServletRequest req, Principal principal) {
		
		ModelAndView mv = new ModelAndView();
		ParameterVO parameterVO = new ParameterVO();
		ArrayList<String> list = new ArrayList<String>();
		List<WooBoardListVO> bnamelists = null;
		if(req.getParameter("bname")!=null && !"".equals(req.getParameter("bname"))) {
			list.add(req.getParameter("bname"));
		}
		else {
			bnamelists = sqlSession.getMapper(WooBoardListImpl.class).selectBname("../product/productList.woo");
			for(WooBoardListVO lists : bnamelists) {
				list.add(lists.getBname());
			}
		}
		
		parameterVO.setList(list);
		System.out.println("list크기 : " + list.size());
		int pageSize = 15;
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;
		
		if(nowPage==1) {
			start = 1;
			end = 15;
		}
		
		parameterVO.setStart(start);
		parameterVO.setEnd(end);
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		
		int total = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).getTotalCount(parameterVO);
		ArrayList<WooBoardVO> lists = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).listPage(parameterVO);
		Iterator itr = lists.iterator();
		//소영 추가부분
		String user_id = "";
		if(principal!=null) {
			user_id = principal.getName();
			mv.addObject("user_id", user_id);
			String str = sqlSession.getMapper(WooMypageImpl.class).selectLike(user_id);
			String[] splitStr = str.split("#");
			
			for (int i = 0; i < lists.size(); i++) {
				for (int j = 0; j < splitStr.length; j++) {
					if(splitStr[j].equals(lists.get(i).getBoardidx())) {
						lists.get(i).setLike_check(1);
					}
				}
			}
		}
		String boardidx = "";
		while (itr.hasNext()) {
			WooBoardVO dto = (WooBoardVO) itr.next();
			String temp = dto.getContents().replace("\r\n", "<br/>");
			dto.setContents(temp);
			boardidx = dto.getBoardidx();
			System.out.println("1 : " + boardidx);
			ArrayList<FileVO> uploadFileList = ((WooBoardImpl) this.sqlSession.getMapper(WooBoardImpl.class)).viewFile(boardidx);
			if(!uploadFileList.isEmpty() && uploadFileList.size()!=0) {
				//리스트에서 대표이미지 설정
				String image =  uploadFileList.get(0).getSave_name(); 
				dto.setImagefile(image);
			}
		}
		
		System.out.println("total : " + total);
		
		//DB에 있는 게시물의 total 과 start를 비교하여 state 설정
		if (start > total) {
			mv.addObject("state", "false");
			System.out.println("state : false");
		} else {
			mv.addObject("state", "true");
			System.out.println("state : true");
		}

		mv.setViewName("product/ajaxList");
		mv.addObject("lists", lists);
		
		return mv;
	}

	//3.상품리스트 상세보기 
	@RequestMapping("/product/productView.woo")
	public String productView(Model model, HttpServletRequest req) {
		
		String boardidx = req.getParameter("boardidx");
		String nowPage = req.getParameter("nowPage");
		
		String seller_id = sqlSession.getMapper(WooBoardImpl.class).selectId(boardidx);
		System.out.println("seller_id" + seller_id);
		
		
		ArrayList<String> review_score  = sqlSession.getMapper(WooMypageImpl.class).review_score(seller_id);
		double review_scoreSum = 0;
		for(int i=0; i<review_score.size(); i++) {
			review_scoreSum += Double.parseDouble(review_score.get(i));
		}
		System.out.println("review_scoreSum" + review_scoreSum);
		WooMemberVO memberVO = sqlSession.getMapper(WooMypageImpl.class).myInfo(seller_id);
		
		int trade_count = Integer.parseInt(memberVO.getTrade_count());
		double avg_score1 = 0;
		if(trade_count==0) {
			avg_score1 = 1;
		}
		else {
			avg_score1 = review_scoreSum / (double)trade_count;
		}
		double avg_score2 = ((double)Math.round(avg_score1*10)/10);
		int avg_score_update = sqlSession.getMapper(WooMypageImpl.class).avg_score_update(avg_score2, seller_id);	
		double avg_score = Double.parseDouble(memberVO.getAvg_score());

		String score = "";

		int full = (int) avg_score % 5;
		int half = (int) ((avg_score - full) * 10);
		for (int i = 1; i <= full; i++) {
			score += "<img src='../resources/img/그냥튀김우동.png' alt='' />";
		}
		if (half < 5) {
			for (int j = full + 1; j <= 5; j++) {
				score += "<img src='../resources/img/회색우동.png' alt='' />";
			}
		} else {
			score += "<img src='../resources/img/반쪽우동.png' alt='' />";
			for (int j = full + 2; j <= 5; j++) {
				score += "<img src='../resources/img/회색우동.png' alt='' />";
			}
		}

		String udongGrade = "";

		if (trade_count < 5) {
			udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
		} else if (trade_count >= 5 && trade_count < 10) {
			if (avg_score >= 1 && avg_score < 2)
				udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
			else
				udongGrade += "<img src='../resources/img/빨간일반.png' alt='' />";
		} else if (trade_count >= 10 && trade_count < 15) {
			if (avg_score >= 1 && avg_score < 2)
				udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
			else if (avg_score >= 2 && avg_score < 4)
				udongGrade += "<img src='../resources/img/빨간일반.png' alt='' />";
			else
				udongGrade += "<img src='../resources/img/파랑온도계.png' alt='' />";
		} else if (trade_count >= 15) {
			if (avg_score >= 1 && avg_score < 2)
				udongGrade += "<img src='../resources/img/파랑일반.png' alt='' />";
			else if (avg_score >= 2 && avg_score < 4)
				udongGrade += "<img src='../resources/img/빨간일반.png' alt='' />";
			else
				udongGrade += "<img src='../resources/img/빨간온도계.png' alt='' />";
		}

		model.addAttribute("memberVO", memberVO);
		model.addAttribute("score", score);
		model.addAttribute("udongGrade", udongGrade);
		
		
		//상세보기
		WooBoardVO dto = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).view(boardidx);
		
		//조회수 처리
		int applyRow = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).visitcount(boardidx);

		//파일 불러오기
		ArrayList<FileVO> uploadFileList = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).viewFile(boardidx);
		
		dto.setContents(dto.getContents().replace("\r\n","<br/>"));
		
		model.addAttribute("viewRow", dto);
		model.addAttribute("uploadFileList", uploadFileList);
		model.addAttribute("nowPage", nowPage);
		
		return "product/productView";
	}

	//4-1.글쓰기 폼으로 진입
	@RequestMapping("/product/productWrite.woo")
	public String productWrite(Principal principal,Model model) {
		
		List<WooBoardListVO> selectlist = null;
		String user_id="";
		try {
			user_id = principal.getName();
			System.out.println("글쓰기 진입 user_id : "+user_id);
			selectlist = ((WooBoardListImpl) sqlSession.getMapper(WooBoardListImpl.class)).selectBname("../product/productList.woo");
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
		try {
			user_id = principal.getName();
			wooBoardVO.setId(user_id);
			
			int applyRow = sqlSession.getMapper(WooBoardImpl.class).write(wooBoardVO);
			
			List<Map<String, Object>> list = new util.FileUtils().parseInsertFileInfo(wooBoardVO, mreq); 
			
			Map<String, Object> map = null;
			int size = list.size();
			//파일테이블에 insert
			for(int i=0; i<size; i++){ 
				map = list.get(i);
				sqlSession.getMapper(WooBoardImpl.class).insertFile(map);
			}
		}
		catch (Exception e) {
		}
		return "redirect:productList.woo?nowPage=1";
	}
	
	//5-1.글 수정 폼진입
	@RequestMapping(method = RequestMethod.POST, value="/product/productUpdate.woo")
	public String productUpdate(Model model , HttpServletRequest req,Principal principal) {
		
		logger.info("update");
		logger.debug("update");
		String boardidx = req.getParameter("boardidx");
		String nowPage = req.getParameter("nowPage");
		String bname = req.getParameter("bname");
		String user_id = "";
		List<WooBoardListVO> selectlist = null;
		try {
			user_id = principal.getName();
			//woo_board DB에서  select
			WooBoardVO dto = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).view(boardidx);
			
			// 로그인한 아이디와 글 작성자의 아이디 비교
			if(!user_id.equals(dto.getId())) {
				return "redirect:productList.woo";
			}
			//엔터 처리
			dto.setContents(dto.getContents().replace("\r\n","<br/>"));
			
			//bname 가져오기
			selectlist = ((WooBoardListImpl) sqlSession.getMapper(WooBoardListImpl.class)).selectBname("../product/productList.woo");
			
			//파일 불러오기
			ArrayList<FileVO> uploadFileList = ((WooBoardImpl) this.sqlSession.getMapper(WooBoardImpl.class)).viewFile(boardidx);
			int listsize = uploadFileList.size();
			
			
			model.addAttribute("viewRow", dto);
			model.addAttribute("uploadFileList", uploadFileList);
			model.addAttribute("listsize", listsize);
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
	public String updateAction(WooBoardVO wooBoardVO ,Principal principal,
			 @RequestParam(value="fileNoDel[]") String[] files,
			 @RequestParam(value="fileNameDel[]") String[] fileNames,MultipartHttpServletRequest mreq){
			 
		
		logger.info("updateAction");
		logger.debug("updateAction");
		String user_id = "";
		
		String boardidx = wooBoardVO.getBoardidx();
		System.out.println("boardidx "+boardidx);
		
		try {
			user_id = principal.getName();
			wooBoardVO.setId(user_id);
			//price 에서 , 삭제
			wooBoardVO.setPrice(wooBoardVO.getPrice().replace(",",""));
			int applyRow = sqlSession.getMapper(WooBoardImpl.class).update(wooBoardVO);
			System.out.println("files "+files[0]);
			System.out.println("filesNames "+fileNames[0]);
			List<Map<String, Object>> list = new util.FileUtils().parseUpdateFileInfo(wooBoardVO,files,fileNames, mreq); 
			
			Map<String, Object> map = null;
			int size = list.size();
			
			for(int i=0; i<size; i++){ 
				map = list.get(i);
				if(map.get("IS_NEW").equals("Y")) {
					//파일테이블에 insert
					sqlSession.getMapper(WooBoardImpl.class).insertFile(map);
				}
				else {
					//파일테이블에 update
					sqlSession.getMapper(WooBoardImpl.class).updateFile(map);
				}
			}		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:./productView.woo?boardidx="+boardidx;
	}
	
	//6.글 삭제하기
	@RequestMapping("/product/productDelete.woo")
	public String productDelete(HttpServletRequest req , Principal principal) {
		
		ParameterVO parameterVO = new ParameterVO();
		logger.info("delete");
		logger.debug("delete");
		String boardidx = req.getParameter("boardidx");
		String user_id = "";
		
		//로그인 확인
		try {
			user_id = principal.getName();
			parameterVO.setId(user_id);
			parameterVO.setBoardidx(boardidx);
			int applyRow = sqlSession.getMapper(WooBoardImpl.class).delete(parameterVO);
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:./productList.woo";
	}
}
