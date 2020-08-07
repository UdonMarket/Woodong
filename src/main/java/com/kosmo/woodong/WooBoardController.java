package com.kosmo.woodong;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import model.FileVO;
import model.ParameterVO;
import model.WooBoardImpl;
import model.WooBoardListImpl;
import model.WooBoardListVO;
import model.WooBoardVO;
import model.WooMemberImpl;
import model.WooMypageImpl;
import model.WooProhiditionImpl;
import util.VerifyRecaptcha;
import util.review;
import util.FileUtils;

@Controller
public class WooBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(WooBoardController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	//1. 상품게시판 진입
	@RequestMapping("/product/productList.woo")
	public String productList(Model model, HttpServletRequest req, Principal principal) {
		try {
			String dong = sqlSession.getMapper(WooMemberImpl.class).getDong(principal.getName());
			model.addAttribute("dong", dong.substring(0, dong.lastIndexOf(" ")));
		}
		catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("dong", "동네인증을 해주세요");
			return "redirect:../member/myPlace.woo";
		}
		String location = ".." + req.getServletPath();
		List<WooBoardListVO> blists = ((WooBoardListImpl) sqlSession.getMapper(WooBoardListImpl.class))
				.selectBoard(location);
		
		String mode = req.getParameter("mode")==null ? "common" : req.getParameter("mode");
		ParameterVO parameterVO = new ParameterVO();
		parameterVO.setLatTxt((req.getParameter("lat")==null)? 0 : Double.parseDouble(req.getParameter("lat")));
		parameterVO.setLngTxt((req.getParameter("lon")==null)? 0 : Double.parseDouble(req.getParameter("lon")));
		parameterVO.setBname(req.getParameter("bname"));
		
		parameterVO.setSearchField(req.getParameter("searchField"));
		parameterVO.setSearchTxt(req.getParameter("searchTxt")); 
		parameterVO.setIspay(req.getParameter("ispay"));
		parameterVO.setPriceStart(req.getParameter("priceStart")); 
		parameterVO.setPriceEnd(req.getParameter("priceEnd"));
		parameterVO.setPstate(req.getParameter("pstate"));
		parameterVO.setOrder(req.getParameter("order"));
		parameterVO.setBname(req.getParameter("bname"));
		
		
		model.addAttribute("blists", blists);
		model.addAttribute("parameterVO", parameterVO);
		model.addAttribute("mode", mode);
		// 지도 리스트
		if("map".equals(mode)) {
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
		
		String user_id = "";
		ParameterVO parameterVO = new ParameterVO();
		if(principal!=null) {
			user_id = principal.getName();
			parameterVO.setId(user_id);
			String juso = sqlSession.getMapper(WooMemberImpl.class).selectMember(parameterVO).getAddr();
			parameterVO.setJuso(juso.substring(0, juso.lastIndexOf(" ")));
		}
		
		ModelAndView mv = new ModelAndView();
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

		parameterVO.setBname(req.getParameter("bname"));
		parameterVO.setSearchField(req.getParameter("searchField"));
		parameterVO.setSearchTxt(req.getParameter("searchTxt")); 
		parameterVO.setIspay(req.getParameter("ispay"));
		parameterVO.setPriceStart(req.getParameter("priceStart")); 
		parameterVO.setPriceEnd(req.getParameter("priceEnd"));
		parameterVO.setPstate(req.getParameter("pstate"));
		parameterVO.setOrder(req.getParameter("order"));
		parameterVO.setStart(start);
		parameterVO.setEnd(end);
		int total = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).getTotalCount(parameterVO);
		ArrayList<WooBoardVO> lists = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).listPage(parameterVO);
		Iterator itr = lists.iterator();
		//소영 추가부분
		try {
			if(user_id!=null) {
				mv.addObject("user_id", user_id);
				List<String> str = sqlSession.getMapper(WooMypageImpl.class).selectLike(user_id);
				for (int i = 0; i < lists.size(); i++) {
					for (int j = 0; j < str.size(); j++) {
						if(str.get(j).equals(lists.get(i).getBoardidx())) {
							lists.get(i).setLike_check(1);
						}
					}
				}
			}
		}
		catch (Exception e) {
		}
		String boardidx = "";
		while (itr.hasNext()) {
			WooBoardVO dto = (WooBoardVO) itr.next();
			String temp = dto.getContents().replace("\r\n", "<br/>");
			dto.setContents(temp);
			boardidx = dto.getBoardidx();
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
		} else {
			mv.addObject("state", "true");
		}

		mv.setViewName("product/ajaxList");
		mv.addObject("lists", lists);
		mv.addObject("parameterVO", parameterVO);
		
		return mv;
	}

	//3.상품리스트 상세보기 
	@RequestMapping("/product/productView.woo")
	public String productView(Model model, HttpServletRequest req,Principal principal, HttpServletResponse response) {
		
		String boardidx = req.getParameter("boardidx");
		String nowPage = req.getParameter("nowPage");
		String user_id="";
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> getGrade = new HashMap<String, Object>();
		int userGrade = 1;
		String seller_id = sqlSession.getMapper(WooBoardImpl.class).selectId(boardidx);
		String udong = "";
		
		try {
			map = review.revireScore(sqlSession, seller_id);
			
			if(principal!=null) {
				user_id = principal.getName();
				getGrade = review.revireScore(sqlSession, user_id);
				userGrade = Integer.parseInt(getGrade.get("getUserGrade").toString());//게시글 등급별 공개설정
			}else {
				userGrade = 1;
			}
			//상세보기
			WooBoardVO dto = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).view(boardidx);
			dto.setContents(dto.getContents().replace("\r\n","<br/>"));//엔터 처리
			
			//게시글 등급별 공개설정
			if(dto.getId().equals(user_id)){  }
			else if(userGrade < dto.getPublicSet()) {
				switch (dto.getPublicSet()) {
				case 2:
					udong="따뜻한 일반우동";
					break;
				case 3:
					udong="차가운 튀김우동";
					break;
				case 4:
					udong="따뜻한 튀김우동";
					break;
				}
			}
			//조회수 처리
			int applyRow = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).visitcount(boardidx);
			//파일 불러오기
			ArrayList<FileVO> uploadFileList = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).viewFile(boardidx);
			//판매상태 update  
			String sellingStatus = sqlSession.getMapper(WooBoardImpl.class).selectSellingStatus(boardidx);
			
			model.addAttribute("user_id", user_id); 
			model.addAttribute("memberVO",map.get("memberVO"));
			model.addAttribute("score",map.get("score"));
			model.addAttribute("udongGrade",map.get("udongGrade"));
			model.addAttribute("avg_score",map.get("avg_score"));
			model.addAttribute("userGrade",userGrade);
			model.addAttribute("viewRow", dto);
			model.addAttribute("uploadFileList", uploadFileList);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("sellingStatus", sellingStatus);
		} catch (Exception e){ }
			
		return "product/productView";
	}
	//4-1.글쓰기 폼으로 진입
	@RequestMapping("/product/productWrite.woo")
	public String productWrite(Principal principal,Model model) {
		
		String prohiditionlists = sqlSession.getMapper(WooProhiditionImpl.class).selectProhiditionList();
		String[] prohidition = prohiditionlists.split(",");
		List<WooBoardListVO> selectlist = new ArrayList<WooBoardListVO>();
		String user_id="";
		try {
			user_id = principal.getName();
			selectlist = ((WooBoardListImpl) sqlSession.getMapper(WooBoardListImpl.class)).selectBname("../product/productList.woo");
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("prohidition", prohidition);
		model.addAttribute("selectlist", selectlist);
		model.addAttribute("user_id",user_id);
		return "product/productWrite";
	}

	//4-2.글쓰기 처리
	@RequestMapping(method = RequestMethod.POST,headers = "content-type=multipart/*", value="/product/writeAction.woo" )
	public String productWriteAction(Principal principal, WooBoardVO wooBoardVO,MultipartHttpServletRequest mreq){
								
		logger.info("productWriteAction");
		logger.debug("productWriteAction");
		String user_id="";
		try {
			user_id = principal.getName();
			wooBoardVO.setId(user_id);
			sqlSession.getMapper(WooBoardImpl.class).write(wooBoardVO);
			List<Map<String, Object>> list = FileUtils.parseInsertFileInfo(wooBoardVO, mreq); 
			Map<String, Object> map = new HashMap<String, Object>();
			
			for(int i=0; i<list.size(); i++){
				map = list.get(i);
				sqlSession.getMapper(WooBoardImpl.class).insertFile(map);//file table insert 
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:productList.woo?nowPage=1";
	}
	//5-1.글 수정 폼진입
	@RequestMapping(method = RequestMethod.POST, value="/product/productUpdate.woo")
	public String productUpdate(Model model , HttpServletRequest req,Principal principal) {
		String prohiditionlists = sqlSession.getMapper(WooProhiditionImpl.class).selectProhiditionList();
		String[] prohidition = prohiditionlists.split(",");
		logger.info("update");
		logger.debug("update");
		String boardidx = req.getParameter("boardidx");
		String nowPage = req.getParameter("nowPage");
		String bname = req.getParameter("bname");
		String user_id = "";
		List<WooBoardListVO> selectlist = new ArrayList<WooBoardListVO>();
		try {
			user_id = principal.getName();
			WooBoardVO dto = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).view(boardidx);
			if(!user_id.equals(dto.getId())) {//로그인한 아이디와 글 작성자의 아이디 비교
				return "redirect:productList.woo";
			}
			dto.setContents(dto.getContents().replace("\r\n","<br/>"));
			selectlist = ((WooBoardListImpl) sqlSession.getMapper(WooBoardListImpl.class)).selectBname("../product/productList.woo");
			ArrayList<FileVO> uploadFileList = ((WooBoardImpl) this.sqlSession.getMapper(WooBoardImpl.class)).viewFile(boardidx);
			model.addAttribute("prohidition", prohidition);
			model.addAttribute("viewRow", dto);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("bname", bname);
			model.addAttribute("selectlist", selectlist);
			model.addAttribute("uploadFileList", uploadFileList);
		} catch (Exception e) {e.printStackTrace();}
		return "product/productUpdate";
	}
	//5-2.글 수정 처리 하기
	@RequestMapping(method = RequestMethod.POST,headers = "content-type=multipart/*", value="/product/updateAction.woo")
	public String productupdateAction(WooBoardVO wooBoardVO ,Principal principal, 
			 @RequestParam(value="fileNoDel[]") String[] files,
			 @RequestParam(value="fileNameDel[]") String[] fileNames,MultipartHttpServletRequest mreq){
			 
		logger.info("updateAction");
		logger.debug("updateAction");
		String user_id = "";
		String boardidx = wooBoardVO.getBoardidx();
		
		try {
			user_id = principal.getName();
			wooBoardVO.setId(user_id);
			int applyRow = sqlSession.getMapper(WooBoardImpl.class).update(wooBoardVO);
			List<Map<String, Object>> list = FileUtils.parseUpdateFileInfo(wooBoardVO,files,fileNames, mreq); 
			Map<String, Object> map = new HashMap<String, Object>();
			int size = list.size();
			for(int i=0; i<size; i++){ 
				map = list.get(i);
				if(map.get("IS_NEW").equals("Y")) {//파일테이블에 insert
					sqlSession.getMapper(WooBoardImpl.class).insertFile(map);
				}
				else {//파일테이블에 update
					sqlSession.getMapper(WooBoardImpl.class).updateFile(map);
				}
			}		
		} catch (Exception e) {e.printStackTrace();}
		return "redirect:./productView.woo?boardidx="+boardidx;
	}
	//6.글 삭제하기
	@RequestMapping("/product/productDelete.woo")
	public String productDelete(HttpServletRequest req ,Model model, Principal principal) {
		
		logger.info("delete");
		ParameterVO parameterVO = new ParameterVO();
		String boardidx = req.getParameter("boardidx");
		String id = req.getParameter("id");
		String user_id = "";
		try {
			user_id = principal.getName();
			if(user_id.equals(id)) {
				parameterVO.setId(user_id);
				parameterVO.setBoardidx(boardidx);//id와 boardidx 로 게시글 삭제
				sqlSession.getMapper(WooBoardImpl.class).delete(parameterVO);
			}
		} catch (Exception e) {e.printStackTrace();}
		return "redirect:./productList.woo";
	}
	
	//끌올기능
	@RequestMapping("/product/productJump.woo")
	public String productJump(HttpServletRequest req ,Model model, Principal principal) {
		logger.info("productJump");
		logger.debug("productJump");
		ParameterVO parameterVO = new ParameterVO();
		String boardidx = req.getParameter("boardidx");
		String user_id = "";
		try {
			user_id = principal.getName();
				parameterVO.setId(user_id);
				parameterVO.setBoardidx(boardidx);//id와 boardidx 로 게시글 삭제
				int applyRow = sqlSession.getMapper(WooBoardImpl.class).jump(parameterVO);
		} catch (Exception e) {e.printStackTrace();}
		return "redirect:../product/productList.woo";
	}

	// 7.최근본 상품 처리중 쿠키값을 사이드바에 넘겨주기
	@ResponseBody
	@RequestMapping(value = "/product/itemSave.woo")
	public List<WooBoardVO> itemSave(Model model, HttpServletRequest req , HttpServletResponse response) {
		
		logger.info("itemSave");
		logger.debug("itemSave");
		
		String boardidx = req.getParameter("boardidx");
		List<WooBoardVO> list = new ArrayList<WooBoardVO>();
		
		String preCookie = "";
		// 쿠키를 읽어온다.
		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (Cookie ck : cookies) {
				if (ck.getName().contains("boardidx")) {
					preCookie = ck.getValue();
				}
			}
		}
		if(boardidx!=null){
		
			List<String> cookielist = new ArrayList<String>(); 
			if(!preCookie.isEmpty()) {
				String[] cookiesave = preCookie.split("/");
				for (int i = 0; i < cookiesave.length; i++) {
					cookielist.add(cookiesave[i]);
				}
			}
			
				 
			if(cookielist!=null && cookielist.size()!=0){
				for(int i=0;i<cookielist.size();i++) {
					if(cookielist.get(i).equals(boardidx)) {
						cookielist.remove(i);
					}
				}
				if(cookielist.size()>2) {
					cookielist.remove(0);
				}
			}
				cookielist.add(boardidx);
				preCookie = "";
			
			
			for(int i=0;i<cookielist.size();i++) {
				preCookie += cookielist.get(i)+"/";
			}
			// 쿠키생성
			Cookie cookie = new Cookie("boardidx", preCookie);
			cookie.setPath("/");
			response.addCookie(cookie);
		
		}
		if(!preCookie.isEmpty()) { 
			String[] cookiesave = preCookie.split("/");
			for (int i = 0; i < cookiesave.length; i++) {
				WooBoardVO dto = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).view(cookiesave[i]);
				ArrayList<FileVO> uploadFileList = ((WooBoardImpl) this.sqlSession.getMapper(WooBoardImpl.class)).viewFile(cookiesave[i]);
				dto.setBoardidx(cookiesave[i]);
				
				if (!uploadFileList.isEmpty() && uploadFileList.size() != 0) {
					String image = uploadFileList.get(0).getSave_name();
					dto.setImagefile(image);
				}
				list.add(dto);
			}
			
		}
		return list;
	}
	
		//3-1.Ajax 상품리스트 상세보기 
		@RequestMapping("/product/ajaxproductView.woo")
		public String ajaxproductView(Model model, HttpServletRequest req,Principal principal, HttpServletResponse response) {
			
			String boardidx = req.getParameter("boardidx");
			String nowPage = req.getParameter("nowPage");
			String user_id="";
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> getGrade = new HashMap<String, Object>();
			int userGrade = 1;
			String seller_id = sqlSession.getMapper(WooBoardImpl.class).selectId(boardidx);
			map = review.revireScore(sqlSession, seller_id);
			
			try {
				if(principal!=null) {
					user_id = principal.getName();
					getGrade = review.revireScore(sqlSession, user_id);
					userGrade = Integer.parseInt(getGrade.get("getUserGrade").toString());//게시글 등급별 공개설정
				}else {
					userGrade = 1;
				}
				
				//상세보기
				WooBoardVO dto = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).view(boardidx);
				dto.setContents(dto.getContents().replace("\r\n","<br/>"));//엔터 처리
				
				String udong = "";
				
				if(user_id.equals(dto.getId())){  }
				else if(userGrade < dto.getPublicSet()) {
					model.addAttribute("check", 1);
				}
				else {
					model.addAttribute("check", 0);
				}
				//조회수 처리
				int applyRow = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).visitcount(boardidx);
				//파일 불러오기
				ArrayList<FileVO> uploadFileList = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).viewFile(boardidx);
				//판매상태 update  
				String sellingStatus = sqlSession.getMapper(WooBoardImpl.class).selectSellingStatus(boardidx);
				
				model.addAttribute("user_id", user_id); 
				model.addAttribute("memberVO",map.get("memberVO"));
				model.addAttribute("score",map.get("score"));
				model.addAttribute("udongGrade",map.get("udongGrade"));
				model.addAttribute("avg_score",map.get("avg_score"));
				model.addAttribute("publicSet", userGrade); 
				////////////////////////////////////////////쿠키 start
			
				
				//////////////////////////////////////////////////////////////쿠키 end
				model.addAttribute("viewRow", dto);
				model.addAttribute("uploadFileList", uploadFileList);
				model.addAttribute("nowPage", nowPage);
				model.addAttribute("sellingStatus", sellingStatus);
			} catch (Exception e){ }
			
			return "product/ajaxproductView";
		}
		
		//구글 Captcha API
	    @RequestMapping(value = "/product/VerifyRecaptcha")
	    @ResponseBody
	    public Map<String, Object> VerifyRecaptcha(HttpServletRequest request) {
	 		
	 		Map<String, Object>map = new HashMap<String, Object>();
	 		VerifyRecaptcha.setSecretKey("6LcN9rgZAAAAAPwE96NXGabUAl-5JL9d8hye3VdQ");//API비밀키
	        String gRecaptchaResponse = request.getParameter("recaptcha");
	        
	        try {
	            if(VerifyRecaptcha.verify(gRecaptchaResponse)) {//0 = 성공, 1 = 실패, -1 = 오류
	            	map.put("msg",0);//성공
	            }
	            else {
	            	map.put("msg",1);//실패
	            }
	        } catch (IOException e) {
	        	e.printStackTrace();
	        	map.put("msg",-1);//오류
	            return map;
	        }
	        return map;
	    }
	    

}
