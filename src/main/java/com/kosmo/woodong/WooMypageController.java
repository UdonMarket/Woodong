package com.kosmo.woodong;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import model.FileVO;
import model.WooMemberVO;
import model.WooMypageImpl;
import model.WooMyreviewVO;
import model.ParameterVO;
import model.WooBoardImpl;
import model.WooBoardVO;
import util.PagingUtil;

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
		
		ArrayList<String> review_score = sqlSession.getMapper(WooMypageImpl.class).review_score(user_id);
		double review_scoreSum = 0;
		for(int i=0; i<review_score.size(); i++) {
			review_scoreSum += Double.parseDouble(review_score.get(i));
		}
		WooMemberVO memberVO = sqlSession.getMapper(WooMypageImpl.class).myInfo(user_id);
		
		int trade_count = Integer.parseInt(memberVO.getTrade_count());
		
		double avg_score1 = 0;
		if(trade_count==0) {
			avg_score1 = 1;
		}
		else {
			avg_score1 = review_scoreSum / (double)trade_count;
		}
		double avg_score2 = ((double)Math.round(avg_score1*10)/10);
		int avg_score_update = sqlSession.getMapper(WooMypageImpl.class).avg_score_update(avg_score2, user_id);	
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
		model.addAttribute("udongGrade", udongGrade);
		
		String mode = req.getParameter("mode");
		if(mode ==  null) mode = "";
		String dealMode = req.getParameter("dealMode");
		
		ParameterVO parameterVO = new ParameterVO();
		parameterVO.setMode(mode);
		parameterVO.setDealMode(dealMode);
		
		int pageSize = 2;
		int blockPage = 5;

		// 현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum 구하기
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;

		parameterVO.setStart(start);
		parameterVO.setEnd(end);

		parameterVO.setUser_id(user_id);
		String str = sqlSession.getMapper(WooMypageImpl.class).selectLike(user_id);
		String[] splitStr = str.split("#");
		List<String> list = new ArrayList<String>();

		for (int i = 0; i < splitStr.length; i++) {
			list.add(splitStr[i]);
		}

		parameterVO.setList(list);
		
		int totalRecordCount = sqlSession.getMapper(WooMypageImpl.class).getTotalCount(parameterVO);
		
		
		ArrayList<WooBoardVO> likeList = sqlSession.getMapper(WooMypageImpl.class).selectBoard(parameterVO);
		ArrayList<WooMyreviewVO> riviewList = sqlSession.getMapper(WooMypageImpl.class).selectReview(parameterVO);
		for(WooMyreviewVO rv : riviewList) { 
			
			String idx = rv.getBoardidx();
			System.out.println("12131" + idx);
			ArrayList<FileVO> uploadFileList = sqlSession.getMapper(WooBoardImpl.class).viewFile(idx);
			//사진 중 첫번째 사진만 저장.
			String image = uploadFileList.get(0).getSave_name();
			rv.setImagefile(image);
			System.out.println("image : " + image);
		}
		for(WooBoardVO rv : likeList) { 
			
			String idx = rv.getBoardidx();
			System.out.println("12131" + idx);
			ArrayList<FileVO> uploadFileList = sqlSession.getMapper(WooBoardImpl.class).viewFile(idx);
			//사진 중 첫번째 사진만 저장.
			String image = uploadFileList.get(0).getSave_name();
			rv.setImagefile(image);
			System.out.println("image : " + image);
			String dealtype = sqlSession.getMapper(WooMypageImpl.class).dealtype(idx);
			rv.setDeal_type(dealtype);
		}
		
		for (WooBoardVO vo : likeList) {
			// 내용에 대해 줄바꿈 처리
			String temp = vo.getContents().replace("\r\n", "<br/>");
			vo.setContents(temp);
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
			System.out.println("12131" + idx);
			ArrayList<FileVO> uploadFileList = sqlSession.getMapper(WooBoardImpl.class).viewFile(idx);
			//사진 중 첫번째 사진만 저장.
			String image = uploadFileList.get(0).getSave_name();
			rv.setImagefile(image);
			System.out.println("image : " + image);
		}
		model.addAttribute("sellerRiviewList", sellerRiviewList);
		}
		
		model.addAttribute("score", score);
		model.addAttribute("seller_avgscore", avg_score);
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
			System.out.println("buy들어감");
			pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					"../mypage/myPage.woo?mode=buy&");
			page = "mypage/myList_B";
		}
		else if(mode.equals("review")) {
			if("seller".equals(dealPosition)) {
				totalRecordCount = sqlSession.getMapper(WooMypageImpl.class).getTotalCountSellerReview(parameterVO);
				System.out.println("totalRecordCount 1 :" + totalRecordCount);
				System.out.println("seller 페이지 이동");
				page = "mypage/sellerReview";
				pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
						"../mypage/myPage.woo?mode=review&dealPosition=seller&seller_id="+seller_id+"&");
			}
			else if("buyer".equals(dealPosition)){
				totalRecordCount = sqlSession.getMapper(WooMypageImpl.class).getTotalCountBuyerReview(parameterVO);
				System.out.println("totalRecordCount 2 : " + totalRecordCount);
				System.out.println("후기페이지 이동");
				page = "mypage/myReview";
				pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
						"../mypage/myPage.woo?mode=review&dealPosition=buyer&");
			}
			System.out.println("리뷰에 보낼 user_id" + user_id);
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
		System.out.println("like_flag : " + like_flag);
		
		if(like_flag.equals("-1")) {
			
			int likecountUpdate = sqlSession.getMapper(WooMypageImpl.class).likeCount_minus(idx);
			System.out.println("관심목록에서 취소시 likecount +1:" + likecountUpdate);
	
			String str = sqlSession.getMapper(WooMypageImpl.class).selectLike(user_id);
	
			String[] splitStr = str.split("#");
	
			List<String> list = new ArrayList<String>();
	
			for (int i = 0; i < splitStr.length; i++) {
				list.add(splitStr[i]);
			}
	
			for (int i = 0; i < list.size(); i++) {
	
				if (list.get(i).equals(idx)) {
	
					list.remove(i);
					String new_goodsStr = "";
					for (int j = 0; j < list.size(); j++) {
						new_goodsStr += list.get(j) + "#";
	
					}
					int update1 = sqlSession.getMapper(WooMypageImpl.class).updateLike(new_goodsStr, user_id);
					break;
				}
	
			}
			if("likemode".equals(req.getParameter("likemode"))) {
				System.out.println(req.getParameter("likemode"));
				System.out.println("페이지이동전");
				page = "mypage/myList_L";
			}
			else {
				System.out.println("에러페이지");
				page = "product/productList";
			}
		}
		else if(like_flag.equals("1")){
			
			int likecountUpdate = sqlSession.getMapper(WooMypageImpl.class).likeCount_puls(idx);
			System.out.println("카테고리에서 좋아요 클릭시 likecount +1:" + likecountUpdate);
			
			String back_str = sqlSession.getMapper(WooMypageImpl.class).selectLike(user_id);
			String str = back_str + req.getParameter("str");

			int update = sqlSession.getMapper(WooMypageImpl.class).updateLike(str, user_id);
			model.addAttribute("update", update);

			page = "product/productList";
		}
		return page;
		
	}
	
	// 후기페이지
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
		System.out.println("팝업" + boardidx); 
		System.out.println("후기전달 title : " + title); 
		System.out.println("후기전달 id : " + id); 
		
		model.addAttribute("boardidx", boardidx);
		model.addAttribute("title", title);
		model.addAttribute("id", id);
		
		return "mypage/reviewPop";
	}
	

	
	
	//리뷰팝업에서 contents DB저장
	@RequestMapping(value="/mypage/writeReviewContents.woo", method = RequestMethod.POST)
	public String writeReviewContents(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName();
		
		System.out.println("글내용 : " + req.getParameter("contents"));
		System.out.println("글idx" + req.getParameter("write_idx"));
		String id = req.getParameter("id");
		String title = req.getParameter("title");
		String juso = req.getParameter("juso");
		String latitude = req.getParameter("latitude");
		String longitude = req.getParameter("longitude");
		String boardidx = req.getParameter("write_idx");
		String contents = req.getParameter("contents");
		System.out.println(juso);
		System.out.println(latitude);
		System.out.println(longitude);
		
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
		System.out.println("review contents update : " + update1);
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
			System.out.println("buyer페이지");
			page = "redirect:myPage.woo?mode=review&dealPosition=buyer";
		}
		int update = sqlSession.getMapper(WooMypageImpl.class).default_reviewScore(idx);
		System.out.println("삭제성공" + update);
		
		return page;
	}

	
}
