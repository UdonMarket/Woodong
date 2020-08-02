
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
import model.WooMypageImpl;
import model.WooProhiditionImpl;
import util.FileUtils;
import util.VerifyRecaptcha;
import util.review;

@Controller
public class WooBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(WooBoardController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	//1. 상품게시판 진입
	@RequestMapping("/product/productList.woo")
	public String productList(Model model, HttpServletRequest req) {
		logger.info("productList");
		logger.debug("productList");
		
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
		
		logger.info("ajaxList");
		logger.debug("ajaxList");
		
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
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		
		int total = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).getTotalCount(parameterVO);
		ArrayList<WooBoardVO> lists = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).listPage(parameterVO);
		Iterator itr = lists.iterator();
		//소영 추가부분
		String user_id = "";
		try {
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
			System.out.println("state : false");
		} else {
			mv.addObject("state", "true");
			System.out.println("state : true");
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
    String seller_id = sqlSession.getMapper(WooBoardImpl.class).selectId(boardidx);
		
		try {
			
			user_id=principal.getName();
      //회원 등급 계산 
			map = review.revireScore(sqlSession, seller_id);
			getGrade = review.revireScore(sqlSession, user_id);
			//상세보기
			WooBoardVO dto = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).view(boardidx);
			dto.setContents(dto.getContents().replace("\r\n","<br/>"));//엔터 처리
			
			//게시글 등급별 공개설정
			int userGrade = Integer.parseInt(getGrade.get("getUserGrade").toString());
			if(user_id.equals(dto.getId())){  }
			else if(userGrade < dto.getPublicSet()) {
				String udong = "";
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
				model.addAttribute("msg", "작성자가 공개 설정한 등급은 "+udong+" 입니다."); 
				model.addAttribute("url", "../product/productList.woo"); 
				return "include/alert";
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
			model.addAttribute("publicSet",userGrade);
			////////////////////////////////////////////쿠키 start
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
			List<String> cookielist = new ArrayList<String>(); 
			if(!preCookie.isEmpty()) {
				String[] cookiesave = preCookie.split("/");
				for (int i = 0; i < cookiesave.length; i++) {
					cookielist.add(cookiesave[i]);
				}
			}
			preCookie = "";//preCookie 비워줌
			
			if(cookielist!=null && cookielist.size()!=0){
				for(int i=0;i<cookielist.size();i++) {
					if(cookielist.get(i).equals(boardidx)) {
						cookielist.remove(i);
					}
				}
				if(cookielist.size()>3) {
					cookielist.remove(0);
				}
			}
			cookielist.add(boardidx);
			for(int i=0;i<cookielist.size();i++) {
				preCookie += cookielist.get(i)+"/";
			}
			// 쿠키생성
			Cookie cookie = new Cookie("boardidx", preCookie);
			cookie.setPath("/");
			response.addCookie(cookie);
			
			//////////////////////////////////////////////////////////////쿠키 end
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
    
		List<String> prohiditionlists = sqlSession.getMapper(WooProhiditionImpl.class).selectProhiditionList();
		List<WooBoardListVO> selectlist = new ArrayList<WooBoardListVO>();
		String user_id="";
		try {
			user_id = principal.getName();
			selectlist = ((WooBoardListImpl) sqlSession.getMapper(WooBoardListImpl.class)).selectBname("../product/productList.woo");
		} catch (Exception e) {
			e.printStackTrace();
		}
    model.addAttribute("prohidition", prohiditionlists);
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
			int size = list.size();
			for(int i=0; i<size; i++){//file table insert 
				map = list.get(i);
				if(map.get("threeYN").equals("Y")) {
					sqlSession.getMapper(WooBoardImpl.class).insertTDFile(map);//3D 파일 업로드 Y
				}
				else{
					sqlSession.getMapper(WooBoardImpl.class).insertFile(map);
				}
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
			//내용 엔터 처리
			dto.setContents(dto.getContents().replace("\r\n","<br/>"));
			//bname 가져오기
			selectlist = ((WooBoardListImpl) sqlSession.getMapper(WooBoardListImpl.class)).selectBname("../product/productList.woo");
			//파일 table 에서 select
			ArrayList<FileVO> uploadFileList = ((WooBoardImpl) this.sqlSession.getMapper(WooBoardImpl.class)).viewFile(boardidx);
			
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
			else {
				model.addAttribute("msg", "작성자 본인만 삭제 가능합니다."); 
				model.addAttribute("url", "../product/productView.woo?boardidx="+boardidx); 
				return "include/alert";
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
		String id = req.getParameter("id");
		String user_id = "";
		try {
			user_id = principal.getName();
			if(user_id.equals(id)) {
				parameterVO.setId(user_id);
				parameterVO.setBoardidx(boardidx);//id와 boardidx 로 게시글 삭제
				int applyRow = sqlSession.getMapper(WooBoardImpl.class).jump(parameterVO);
			}
		} catch (Exception e) {e.printStackTrace();}
		model.addAttribute("msg", "끌올 완료 !"); 
		model.addAttribute("url", "../product/productList.woo"); 
		return "include/alert";
	}

	// 7.최근본 상품 처리중 쿠키값을 사이드바에 넘겨주기
	@ResponseBody
	@RequestMapping(value = "/product/itemSave.woo")
	public List<WooBoardVO> itemSave(Model model, HttpServletRequest req) {
		
		List<WooBoardVO> list = new ArrayList<WooBoardVO>();

		// 쿠키를 읽어온다.
		String preCookie = "";
		Cookie[] cookies = req.getCookies();
		if (cookies != null && cookies.length<4) {
			for (Cookie ck : cookies) {
				if (ck.getName().contains("boardidx")) {
					preCookie = ck.getValue();
				}
			}
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
			
			logger.info("ajaxproductView");
			logger.debug("ajaxproductView");
			
			String boardidx = req.getParameter("boardidx");
			String nowPage = req.getParameter("nowPage");
			String user_id="";
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> getGrade = new HashMap<String, Object>();
			
			try {
				String seller_id = sqlSession.getMapper(WooBoardImpl.class).selectId(boardidx);
				user_id=principal.getName();
				map = review.revireScore(sqlSession, seller_id);
				getGrade = review.revireScore(sqlSession, user_id);
				//상세보기
				WooBoardVO dto = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).view(boardidx);
				dto.setContents(dto.getContents().replace("\r\n","<br/>"));//엔터 처리
				
				//게시글 등급별 공개설정
				int userGrade = Integer.parseInt(getGrade.get("getUserGrade").toString());
				if(user_id.equals(dto.getId())){  }
				else if(userGrade < dto.getPublicSet()) {
					String udong = "";
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
					model.addAttribute("msg", "작성자가 공개 설정한 등급은 "+udong+" 입니다."); 
					model.addAttribute("url", "../product/productList.woo"); 
					return "include/alert";
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
				model.addAttribute("publicSet",userGrade);
				////////////////////////////////////////////쿠키 start
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
				List<String> cookielist = new ArrayList<String>(); 
				if(!preCookie.isEmpty()) {
					String[] cookiesave = preCookie.split("/");
					for (int i = 0; i < cookiesave.length; i++) {
						cookielist.add(cookiesave[i]);
					}
				}
				preCookie = "";//preCookie 비워줌
				
				if(cookielist!=null && cookielist.size()!=0){
					for(int i=0;i<cookielist.size();i++) {
						if(cookielist.get(i).equals(boardidx)) {
							cookielist.remove(i);
						}
					}
					if(cookielist.size()>3) {
						cookielist.remove(0);
					}
				}
				cookielist.add(boardidx);
				for(int i=0;i<cookielist.size();i++) {
					preCookie += cookielist.get(i)+"/";
				}
				// 쿠키생성
				Cookie cookie = new Cookie("boardidx", preCookie);
				cookie.setPath("/");
				response.addCookie(cookie);
				
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
	        System.out.println(gRecaptchaResponse);
	        
	        try {
	            if(VerifyRecaptcha.verify(gRecaptchaResponse)) {//0 = 성공, 1 = 실패, -1 = 오류
	            	map.put("msg",0);//성공
	            }
	            else {
	            	map.put("msg",1);//실패
	            }
	        } catch (IOException e) {
	        	map.put("msg",-1);//오류
	            return map;
	        }
	        return map;
    }

}
=======
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
import model.WooMemberVO;
import model.WooMypageImpl;
import model.WooProhiditionImpl;
import util.VerifyRecaptcha;
import util.EnvFileReader;
import util.review;

@Controller
public class WooBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(WooBoardController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	//1. 상품게시판 진입
	@RequestMapping("/product/productList.woo")
	public String productList(Model model, HttpServletRequest req) {
		logger.info("productList");
		logger.debug("productList");
		
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
		
		logger.info("ajaxList");
		logger.debug("ajaxList");
		
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
		int pageSize = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.pageSize"));
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
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		
		int total = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).getTotalCount(parameterVO);
		ArrayList<WooBoardVO> lists = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).listPage(parameterVO);
		Iterator itr = lists.iterator();
		//소영 추가부분
		String user_id = "";
		try {
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
			System.out.println("state : false");
		} else {
			mv.addObject("state", "true");
			System.out.println("state : true");
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
		String user_id="";
		String nowPage = req.getParameter("nowPage");
		String seller_id = sqlSession.getMapper(WooBoardImpl.class).selectId(boardidx);
		
		try {
			if(principal!=null) {
			user_id=principal.getName();
			model.addAttribute("user_id", user_id); 
			}
		} catch (Exception e) {}
		
		//회원 등급 계산 start
		Map<String, Object> map = review.revireScore(sqlSession, seller_id);
		Map<String, Object> publicSet = review.revireScore(sqlSession, user_id);
		
		
		model.addAttribute("memberVO", map.get("memberVO"));
		model.addAttribute("udongGrade", map.get("udongGrade"));
		model.addAttribute("score", map.get("score"));
		
		//상세보기
		WooBoardVO dto = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).view(boardidx);
		
		//조회수 처리
		int applyRow = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).visitcount(boardidx);

		//파일 불러오기
		ArrayList<FileVO> uploadFileList = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).viewFile(boardidx);
		
		dto.setContents(dto.getContents().replace("\r\n","<br/>"));
		try {
			if(principal!=null) {
			user_id=principal.getName();
			model.addAttribute("user_id", user_id); 
			}
		} catch (Exception e) {}

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
		
		List<String> cookielist = new ArrayList<String>(); 
		if(!preCookie.isEmpty()) {
			String[] cookiesave = preCookie.split("/");
			for (int i = 0; i < cookiesave.length; i++) {
				cookielist.add(cookiesave[i]);
			}
		}
		preCookie = "";//preCookie 비워줌
		
		if(cookielist!=null && cookielist.size()!=0){
			for(int i=0;i<cookielist.size();i++) {
				if(cookielist.get(i).equals(boardidx)) {
					cookielist.remove(i);
				}
			}
			if(cookielist.size()>3) {
				cookielist.remove(0);
			}
		}
		
		cookielist.add(boardidx);
		for(int i=0;i<cookielist.size();i++) {
			preCookie += cookielist.get(i)+"/";
		}
		// 쿠키생성
		Cookie cookie = new Cookie("boardidx", preCookie);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		////////////////////////////////////////////////////////////////쿠키
		model.addAttribute("viewRow", dto);
		model.addAttribute("uploadFileList", uploadFileList);
		model.addAttribute("nowPage", nowPage);
		
		//판매상태 update  
		String sellingStatus = sqlSession.getMapper(WooBoardImpl.class).selectSellingStatus(boardidx);
		model.addAttribute("sellingStatus", sellingStatus);
		
		return "product/productView";
	}
	//4-1.글쓰기 폼으로 진입
	@RequestMapping("/product/productWrite.woo")
	public String productWrite(Principal principal,Model model) {
		
		List<String> prohiditionlists = sqlSession.getMapper(WooProhiditionImpl.class).selectProhiditionList();
		
		
		List<WooBoardListVO> selectlist = null;
		String user_id="";
		try {
			user_id = principal.getName();
			selectlist = ((WooBoardListImpl) sqlSession.getMapper(WooBoardListImpl.class)).selectBname("../product/productList.woo");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("prohidition", prohiditionlists);
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
			int applyRow = sqlSession.getMapper(WooBoardImpl.class).write(wooBoardVO);
			List<Map<String, Object>> list = new util.FileUtils().parseInsertFileInfo(wooBoardVO, mreq); 
			Map<String, Object> map = null;
			int size = list.size();
			for(int i=0; i<size; i++){//file table insert 
				map = list.get(i);
				if(map.get("threeYN").equals("Y")) {
					sqlSession.getMapper(WooBoardImpl.class).insertTDFile(map);//3D 파일 업로드 Y
				}
				else{
					sqlSession.getMapper(WooBoardImpl.class).insertFile(map);
				}
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
		
		logger.info("update");
		logger.debug("update");
		String boardidx = req.getParameter("boardidx");
		String nowPage = req.getParameter("nowPage");
		String bname = req.getParameter("bname");
		String user_id = "";
		List<WooBoardListVO> selectlist = null;
		try {
			user_id = principal.getName();
			WooBoardVO dto = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).view(boardidx);
			if(!user_id.equals(dto.getId())) {//로그인한 아이디와 글 작성자의 아이디 비교
				return "redirect:productList.woo";
			}
			//내용 엔터 처리
			dto.setContents(dto.getContents().replace("\r\n","<br/>"));
			//bname 가져오기
			selectlist = ((WooBoardListImpl) sqlSession.getMapper(WooBoardListImpl.class)).selectBname("../product/productList.woo");
			//파일 table 에서 select
			ArrayList<FileVO> uploadFileList = ((WooBoardImpl) this.sqlSession.getMapper(WooBoardImpl.class)).viewFile(boardidx);
			
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
			List<Map<String, Object>> list = new util.FileUtils().parseUpdateFileInfo(wooBoardVO,files,fileNames, mreq); 
			Map<String, Object> map = null;
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
	public String productDelete(HttpServletRequest req , Principal principal) {
		
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
			int applyRow = sqlSession.getMapper(WooBoardImpl.class).delete(parameterVO);
			}
			else {
				return"redirect:./productView.woo?boardidx="+boardidx;
			}
		} catch (Exception e) {e.printStackTrace();}
		return "redirect:./productList.woo";
	}
	
	//끌올기능
	@RequestMapping("/product/productJump.woo")
	public String productJump(HttpServletRequest req , Principal principal) {
		
		logger.info("productJump");
		logger.debug("productJump");
		ParameterVO parameterVO = new ParameterVO();
		String boardidx = req.getParameter("boardidx");
		String id = req.getParameter("id");
		String user_id = "";
		try {
			user_id = principal.getName();
			if(user_id.equals(id)) {
				parameterVO.setId(user_id);
				parameterVO.setBoardidx(boardidx);//id와 boardidx 로 게시글 삭제
				int applyRow = sqlSession.getMapper(WooBoardImpl.class).jump(parameterVO);
			}
			else {
				return"redirect:./productView.woo?boardidx="+boardidx;
			}
		} catch (Exception e) {e.printStackTrace();}
		return "redirect:./productList.woo";
	}

	// 7.최근본 상품 처리중 쿠키값을 사이드바에 넘겨주기
	@ResponseBody
	@RequestMapping(value = "/product/itemSave.woo")
	public List<WooBoardVO> itemSave(Model model, HttpServletRequest req) {
		
		List<WooBoardVO> list = new ArrayList<WooBoardVO>();

		// 쿠키를 읽어온다.
		String preCookie = "";
		Cookie[] cookies = req.getCookies();
		if (cookies != null && cookies.length<4) {
			for (Cookie ck : cookies) {
				if (ck.getName().contains("boardidx")) {
					preCookie = ck.getValue();
				}
			}
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
			
			logger.info("ajaxproductView");
			logger.debug("ajaxproductView");
			
			String boardidx = req.getParameter("boardidx");
			String user_id="";
			String nowPage = req.getParameter("nowPage");
			String seller_id = sqlSession.getMapper(WooBoardImpl.class).selectId(boardidx);
			
			//회원 등급 계산 start
			ArrayList<String> review_score  = sqlSession.getMapper(WooMypageImpl.class).review_score(seller_id);
			double review_scoreSum = 0;
			for(int i=0; i<review_score.size(); i++) {
				review_scoreSum += Double.parseDouble(review_score.get(i));
			}
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
			//회원 등급 계산 end
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
			try {
				if(principal!=null) {
				user_id=principal.getName();
				model.addAttribute("user_id", user_id); 
				}
			} catch (Exception e) {}
			////////////////////////////////////////////쿠키
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
			List<String> cookielist = new ArrayList<String>(); 
			if(!preCookie.isEmpty()) {
				String[] cookiesave = preCookie.split("/");
				for (int i = 0; i < cookiesave.length; i++) {
					cookielist.add(cookiesave[i]);
				}
			}
			preCookie = "";//preCookie 비워줌
			
			if(cookielist!=null && cookielist.size()!=0){
				for(int i=0;i<cookielist.size();i++) {
					if(cookielist.get(i).equals(boardidx)) {
						cookielist.remove(i);
					}
				}
				if(cookielist.size()>3) {
					cookielist.remove(0);
				}
			}
			
			cookielist.add(boardidx);
			for(int i=0;i<cookielist.size();i++) {
				preCookie += cookielist.get(i)+"/";
			}
			// 쿠키생성
			Cookie cookie = new Cookie("boardidx", preCookie);
			cookie.setPath("/");
			response.addCookie(cookie);
			////////////////////////////////////////////////////////////////쿠키
			model.addAttribute("viewRow", dto);
			model.addAttribute("uploadFileList", uploadFileList);
			model.addAttribute("nowPage", nowPage);
			
			//소영 추가(판매상태) 
			String sellingStatus = sqlSession.getMapper(WooBoardImpl.class).selectSellingStatus(boardidx);
			model.addAttribute("sellingStatus", sellingStatus);
			
			return "product/ajaxproductView";
		}
		
		//구글 Captcha API
	    @RequestMapping(value = "/product/VerifyRecaptcha")
	    @ResponseBody
	    public Map<String, Object> VerifyRecaptcha(HttpServletRequest request) {
	 		
	 		Map<String, Object>map = new HashMap<String, Object>();
	 		VerifyRecaptcha.setSecretKey("6LcN9rgZAAAAAPwE96NXGabUAl-5JL9d8hye3VdQ");//API비밀키
	        String gRecaptchaResponse = request.getParameter("recaptcha");
	        System.out.println(gRecaptchaResponse);
	        
	        try {
	            if(VerifyRecaptcha.verify(gRecaptchaResponse)) {//0 = 성공, 1 = 실패, -1 = 오류
	            	map.put("msg",0);//성공
	            }
	            else {
	            	map.put("msg",1);//실패
	            }
	        } catch (IOException e) {
	        	map.put("msg",-1);//오류
	            return map;
	        }
	        return map;
    }

}

