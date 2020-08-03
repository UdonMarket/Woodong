package com.kosmo.woodong;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import model.FileVO;
import model.WooMypageImpl;
import model.WooMyreviewVO;
import model.ParameterVO;
import model.WooBoardImpl;
import model.WooBoardVO;
import util.EnvFileReader;
import util.PagingUtil;
import util.review;

@Controller
public class WooMypageController {

	@Autowired
	private SqlSession sqlSession;

	// 마이페이지
	// 나의우동 평점, 등급 그림 바뀌기
	@RequestMapping("/mypage/myPage.woo")
	public String myPage(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = "";
		
		if(req.getParameter("seller_id") == null) {
			 user_id = principal.getName();
		}
		else {
			user_id = req.getParameter("seller_id");
			model.addAttribute("realUser_id", principal.getName());
		}
		
		Map<String, Object> map = review.revireScore(sqlSession, user_id);
		
		model.addAttribute("memberVO", map.get("memberVO"));
		model.addAttribute("udongGrade", map.get("udongGrade"));
		model.addAttribute("score", map.get("score"));
		
		String mode = req.getParameter("mode");
		if(mode ==  null) mode = "";
		String dealMode = req.getParameter("dealMode");
		
		ParameterVO parameterVO = new ParameterVO();
		parameterVO.setMode(mode);
		parameterVO.setDealMode(dealMode);
		
		int pageSize = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.pageSize"));
		int blockPage = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.blockPage"));

		// 현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum 구하기
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;

		parameterVO.setStart(start);
		parameterVO.setEnd(end);

		parameterVO.setUser_id(user_id);
		List<String> list = sqlSession.getMapper(WooMypageImpl.class).selectLike(user_id);
		parameterVO.setList(list);
		
		int totalRecordCount = sqlSession.getMapper(WooMypageImpl.class).getTotalCount(parameterVO);
		
		ArrayList<WooBoardVO> likeList = sqlSession.getMapper(WooMypageImpl.class).selectBoard(parameterVO);
		ArrayList<WooMyreviewVO> riviewList = sqlSession.getMapper(WooMypageImpl.class).selectReview(parameterVO);
		for(WooMyreviewVO rv : riviewList) { 
			
			String idx = rv.getBoardidx();
			ArrayList<FileVO> uploadFileList = sqlSession.getMapper(WooBoardImpl.class).viewFile(idx);
			//사진 중 첫번째 사진만 저장.
			try {
				String image = uploadFileList.get(0).getSave_name();
				rv.setImagefile(image);
			}
			catch (Exception e) {
			}
		} 
		for(WooBoardVO rv : likeList) { 
			
			String idx = rv.getBoardidx();
			ArrayList<FileVO> uploadFileList = sqlSession.getMapper(WooBoardImpl.class).viewFile(idx);
			//사진 중 첫번째 사진만 저장.

      try {
			String image = uploadFileList.get(0).getSave_name();
			rv.setImagefile(image);
        }
	      catch (Exception e) {
	      }
			String dealtype = sqlSession.getMapper(WooMypageImpl.class).dealtype(idx);
			rv.setDeal_type(dealtype);
		}
		model.addAttribute("likeList", likeList);
		model.addAttribute("riviewList", riviewList);
		String pagingImg = "";
		String page = "";
		
		String dealPosition = req.getParameter("dealPosition");
		String seller_id = req.getParameter("seller_id");
		if(seller_id != null) {
			parameterVO.setSeller_id(seller_id);
			ArrayList<WooMyreviewVO> sellerRiviewList = sqlSession.getMapper(WooMypageImpl.class).sellerReview(parameterVO);
		for(WooMyreviewVO rv : sellerRiviewList) { 
			
			String idx = rv.getBoardidx();
			ArrayList<FileVO> uploadFileList = sqlSession.getMapper(WooBoardImpl.class).viewFile(idx);
			//사진 중 첫번째 사진만 저장.
			try {
				String image = uploadFileList.get(0).getSave_name();
				rv.setImagefile(image);
			}
			catch (Exception e) {
			}
		}
		model.addAttribute("sellerRiviewList", sellerRiviewList);
		}
		
		model.addAttribute("seller_avgscore", map.get("avg_score"));
		if(mode.equals("deal")) {
			if(dealMode.equals("sell")) {
				pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
						"../mypage/myPage.woo?mode=deal&dealMode=sell&");
			}
			else {
				pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
						"../mypage/myPage.woo?mode=deal&dealMode=buy&");
			}
			page = "mypage/myList_W";
		}
		else if(mode.equals("sell")) {
			pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					"../mypage/myPage.woo?mode=sell&");
			page = "mypage/myList_S";
		}
		else if(mode.equals("buy")) {
			pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					"../mypage/myPage.woo?mode=buy&");
			page = "mypage/myList_B";
		}
		else if(mode.equals("review")) {
			if("seller".equals(dealPosition)) {
				totalRecordCount = sqlSession.getMapper(WooMypageImpl.class).getTotalCountSellerReview(parameterVO);
				page = "mypage/sellerReview";
				pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
						"../mypage/myPage.woo?mode=review&dealPosition=seller&seller_id="+seller_id+"&");
			}
			else if("buyer".equals(dealPosition)){
				totalRecordCount = sqlSession.getMapper(WooMypageImpl.class).getTotalCountBuyerReview(parameterVO);
				page = "mypage/myReview";
				pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
						"../mypage/myPage.woo?mode=review&dealPosition=buyer&");
			}
			model.addAttribute("user_id", user_id);
		}
		else if(mode.equals("like")){
			pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					"../mypage/myPage.woo?mode=like&");
			page = "mypage/myList_L";
		}
		else {
			page =  "mypage/myPage";
		}
		
		model.addAttribute("pagingImg", pagingImg);
		return page;
	}
	
	
	
	// 좋아요 
	@RequestMapping("/mypage/likeToggle.woo")
	@ResponseBody
	public String likeToggle(Model model, HttpServletRequest req, Principal principal) {
		String idx = req.getParameter("idx");
		String like_flag = req.getParameter("like_flag");
		String user_id = principal.getName();
		String page = "";
		
		if(like_flag.equals("-1")) {
			
			int likecountUpdate = sqlSession.getMapper(WooMypageImpl.class).likeCount_minus(idx);
			
			sqlSession.getMapper(WooMypageImpl.class).deleteLike(user_id, idx);
			
			if("likemode".equals(req.getParameter("likemode"))) {
				page = "mypage/myList_L";
			}
			else {
				page = "product/productList";
			}
		}
		else if(like_flag.equals("1")){
			
			int likecountUpdate = sqlSession.getMapper(WooMypageImpl.class).likeCount_puls(idx);
			
			int update = sqlSession.getMapper(WooMypageImpl.class).updateLike(user_id, idx);
			
			model.addAttribute("update", update);

			page = "product/productList";
		}
		return page;
		
	}
	@RequestMapping("/mypage/myReview.woo")
	   public String myReview() {
	      return "mypage/myReview";
	   }
	   
	   // 리뷰작성글 팝업열기
	   @RequestMapping("/mypage/reviewPop.woo")
	   public String reviewPop(Model model, HttpServletRequest req) {
	      
	      String boardidx = req.getParameter("boardidx");
	      String title = req.getParameter("title");
	      String id = req.getParameter("id");
	      
	      model.addAttribute("boardidx", boardidx);
	      model.addAttribute("title", title);
	      model.addAttribute("id", id);
	      
	      return "mypage/reviewPop";
	   }

  
	   //리뷰팝업에서 contents DB저장
	   @RequestMapping(value="/mypage/writeReviewContents.woo", method = RequestMethod.POST)
	   public String writeReviewContents(Model model, HttpServletRequest req, Principal principal) {
	      
	      String user_id = principal.getName();
	      
	      String id = req.getParameter("id");
	      String title = req.getParameter("title");
	      String juso = req.getParameter("juso");
	      String latitude = req.getParameter("latitude");
	      String longitude = req.getParameter("longitude");
	      String boardidx = req.getParameter("write_idx");
	      String contents = req.getParameter("contents");
	      
	      ParameterVO parameterVO = new ParameterVO();
	      parameterVO.setUser_id(user_id);
	      parameterVO.setId(id);
	      parameterVO.setTitle(title);
	      parameterVO.setJuso(juso);
	      parameterVO.setLatitude(latitude);
	      parameterVO.setLongitude(longitude);
	      parameterVO.setBoardidx(boardidx);
	      parameterVO.setContents(contents);
	      
	      
	      int update1 = sqlSession.getMapper(WooMypageImpl.class).update_reviewContents(parameterVO);
	      int update = sqlSession.getMapper(WooMypageImpl.class).update_reviewScore(req.getParameter("cal_reviewPoint"), req.getParameter("write_idx"));
	      
	      return "mypage/myList_B_popclose";
	   }
	
	// 후기삭제
	@RequestMapping("/mypage/reviewDelete.woo")
	public String deleteReview(HttpServletRequest req) throws UnsupportedEncodingException {
		String page = "";
		String idx = req.getParameter("boardidx");
		int delete = sqlSession.getMapper(WooMypageImpl.class).delete(idx);
		String dealPosition = req.getParameter("dealPosition");
		String seller_id = req.getParameter("seller_id");
		String seller_avgscore = req.getParameter("seller_avgscore");
		String score = req.getParameter("score");
		
		if("seller".equals(dealPosition)) {
			String encodedParam = URLEncoder.encode(score, "UTF-8");
			page = "redirect:myPage.woo?mode=review&dealPosition=seller&seller_id=" + seller_id + "&seller_avgscore=" + seller_avgscore + "&score=" + encodedParam;
		}
		else if("buyer".equals(dealPosition)){
			page = "redirect:myPage.woo?mode=review&dealPosition=buyer";
		}
		int update = sqlSession.getMapper(WooMypageImpl.class).default_reviewScore(idx);
		
		return page;
	}

	
}
