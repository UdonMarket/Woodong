package com.kosmo.woodong;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
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

import model.MemberVO;
import model.MybatisMemberImpl;
import model.MypageDAOImpl;
import model.ParameterVO;
import model.WooBoardDAOImpl;
import model.WooBoardVO;
import util.PagingUtil;

@Controller
public class MypageController {

	@Autowired
	private SqlSession sqlSession;

	// 마이페이지
	// 나의우동 평점, 등급 그림 바뀌기
	@RequestMapping("/mypage/myList_L.woo")
	public String mylist_l(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName();
		
		ArrayList<String> review_score  = sqlSession.getMapper(MypageDAOImpl.class).review_score(user_id);
		double review_scoreSum = 0;
		for(int i=0; i<review_score.size(); i++) {
			System.out.println(review_score.get(i));
			review_scoreSum += Double.parseDouble(review_score.get(i));
			System.out.println("total" + review_scoreSum);
		}
		MemberVO memberVO = sqlSession.getMapper(MypageDAOImpl.class).myInfo(user_id);

		int trade_count = Integer.parseInt(memberVO.getTrade_count());
		
		double avg_score1 = review_scoreSum / (double)trade_count;
		System.out.println("업데이트 할 avg_score1 : " + avg_score1);
		double avg_score2 = ((double)Math.round(avg_score1*10)/10);
		System.out.println("업데이트 할 avg_score2 : " + avg_score2);
		int avg_score_update = sqlSession.getMapper(MypageDAOImpl.class).avg_score_update(avg_score2, user_id);	
		double avg_score = Double.parseDouble(memberVO.getAvg_score());
		System.out.println("업데이트 된avg_score : " + avg_score);

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
		
		
		
		String mode = req.getParameter("mode");
		if(mode ==  null) mode = "";
		String dealMode = req.getParameter("dealMode");
		System.out.println(mode);
		System.out.println(dealMode);
		
		ParameterVO parameterVO = new ParameterVO();
		parameterVO.setMode(mode);
		parameterVO.setDealMode(dealMode);
		
		int pageSize = 6;
		int blockPage = 5;

		// 현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum 구하기
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;

		parameterVO.setStart(start);
		parameterVO.setEnd(end);
		System.out.println(start);
		System.out.println(end);

		parameterVO.setUser_id(user_id);
		System.out.println(user_id);
		String str = sqlSession.getMapper(MypageDAOImpl.class).selectLike(user_id);

		String[] splitStr = str.split("#");

		List<String> list = new ArrayList<String>();

		for (int i = 0; i < splitStr.length; i++) {
			list.add(splitStr[i]);
		}

		parameterVO.setList(list);
		System.out.println("gettotal");
		int totalRecordCount = sqlSession.getMapper(MypageDAOImpl.class).getTotalCount(parameterVO);
		ArrayList<WooBoardVO> likeList = sqlSession.getMapper(MypageDAOImpl.class).selectBoard(parameterVO);
		System.out.println("selectBaord");
		
		

		for (WooBoardVO vo : likeList) {
			// 내용에 대해 줄바꿈 처리
			String temp = vo.getContents().replace("\r\n", "<br/>");
			vo.setContents(temp);
		}

		model.addAttribute("likeList", likeList);
		
		String pagingImg = "";
		String page = "";
		
		if(mode.equals("deal")) {
			pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					"../mypage/myList_L.woo?");
			page = "mypage/myList_W";
		}
		else if(mode.equals("sell")) {
			pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					"../mypage/myList_L.woo?");
			page = "mypage/myList_S";
		}
		else if(mode.equals("buy")) {
			System.out.println("buy들어감");
			pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					"../mypage/myList_L.woo?");
			page = "mypage/myList_B";
		}
//		else if(mode.equals("review")) {
//			pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
//					"../mypage/myReview.woo?");
//			page = "mypage/myReview";
//		}
		else if(mode.equals("like")){
			PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					"../mypage/myList_L.woo?");
			page = "mypage/myList_L";
		}
		else {
			page =  "mypage/myPage";
		}
		
		model.addAttribute("pagingImg", pagingImg);
		return page;
	}

	//좋아요 취소
	@RequestMapping("/mypage/like_toggle.woo")
	@ResponseBody
	public Map<String, Object> likeToggle(Model model, HttpServletRequest req, Principal principal) {
		String idx = req.getParameter("idx");
		System.out.println("idx:"+idx);
		String user_id = principal.getName();

		System.out.println("dsadsaldjlkasjd4");
		int likecountUpdate = sqlSession.getMapper(MypageDAOImpl.class).likeCount_minus(idx);
		System.out.println("관심목록에서 취소시 likecount +1:" + likecountUpdate);

		String str = sqlSession.getMapper(MypageDAOImpl.class).selectLike(user_id);

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
				int update1 = sqlSession.getMapper(MypageDAOImpl.class).updateLike(new_goodsStr, user_id);
				break;
			}

		}

		Map<String, Object> LikeMap = new HashMap<String, Object>();

		return LikeMap;
	}

	@RequestMapping("/mypage/myReview.woo")
	public String myreview() {
		return "mypage/myReview";
	}

	@RequestMapping("/mypage/myProduct.woo")
	public String myproduct() {
		return "mypage/myProduct";
	}

	// 좋아요 클릭시 DB에 해당 idx 업데이트 처리
	@RequestMapping("/product/ajaxLike.woo")
	public String like(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName();
		String idx = req.getParameter("idx");
		
		int likecountUpdate = sqlSession.getMapper(MypageDAOImpl.class).likeCount_puls(idx);
		System.out.println("카테고리에서 좋아요 클릭시 likecount +1:" + likecountUpdate);
		
		String back_str = sqlSession.getMapper(MypageDAOImpl.class).selectLike(user_id);
		String str = back_str + req.getParameter("str");

		int update = sqlSession.getMapper(MypageDAOImpl.class).updateLike(str, user_id);
		model.addAttribute("update", update);

		return "product/ajaxList";
	}
	
	//리뷰작성글 팝업열기
	@RequestMapping("/mypage/reviewPop.woo")
	public String reviewPop(Model model, HttpServletRequest req) {
		
		String idx = req.getParameter("idx");
		System.out.println("팝업" + idx); 
		
		model.addAttribute("idx", idx);
		
		return "mypage/reviewPop";
	}
	
	//리뷰버튼 클릭시 review테이블에 id, idx, title 저장
	@RequestMapping("/mypage/write_review.woo")
	public String write_review(Model model, HttpServletRequest req, Principal principal) {
			
		String user_id = principal.getName();
		String id = req.getParameter("id");
		String idx = req.getParameter("idx");
		String title = req.getParameter("title");
		
		ParameterVO parameterVO = new ParameterVO();
		parameterVO.setId(id);
		parameterVO.setIdx(idx);
		parameterVO.setTitle(title);
		parameterVO.setUser_id(user_id);
		
		int update = sqlSession.getMapper(MypageDAOImpl.class).update_reviewTable(parameterVO);
		System.out.println("review update : " + update);
		
		return "mypage/myList_B";
	}
	
	
	//리뷰팝업에서 contents DB저장
	@RequestMapping(value="/mypage/write_review_contents.woo", method = RequestMethod.POST)
	public String write_review_contents(Model model, HttpServletRequest req) {
		
		System.out.println("글내용 : " + req.getParameter("contents"));
		System.out.println("글idx" + req.getParameter("write_idx"));
		int update1 = sqlSession.getMapper(MypageDAOImpl.class).update_reviewContents(req.getParameter("contents"), req.getParameter("write_idx"));
		System.out.println("review contents update : " + update1);
		int update = sqlSession.getMapper(MypageDAOImpl.class).update_reviewScore(req.getParameter("cal_reviewPoint"), req.getParameter("write_idx"));
		
		return "mypage/myList_B_popclose";
	}
	
}
