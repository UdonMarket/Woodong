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
	@RequestMapping("/mypage/myPage.woo")
	public String mypage(Model model, HttpServletRequest req, Principal principal) {
		String user_id = principal.getName();
		System.out.println(user_id);
		MemberVO memberVO = sqlSession.getMapper(MybatisMemberImpl.class).myInfo(user_id);

		double avg_score = Double.parseDouble(memberVO.getAvg_score());
		int trade_count = Integer.parseInt(memberVO.getTrade_count());

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

		return "mypage/myPage";
	}

	@RequestMapping("/mypage/myList_W.woo")
	public String mylist_w() {

		return "mypage/myList_W";
	}

	@RequestMapping("/mypage/myList_L.woo")
	public String mylist_l(Model model, HttpServletRequest req, Principal principal) {

		ParameterVO parameterVO = new ParameterVO();

		int pageSize = 9;
		int blockPage = 5;

		// 현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum 구하기
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;

		parameterVO.setStart(start);
		parameterVO.setEnd(end);

		String user_id = principal.getName();

		String str = sqlSession.getMapper(MypageDAOImpl.class).selectLike(user_id);

		String[] splitStr = str.split("#");

		List<String> list = new ArrayList<String>();

		for (int i = 0; i < splitStr.length; i++) {
			list.add(splitStr[i]);
		}

		parameterVO.setList(list);

		int totalRecordCount = sqlSession.getMapper(MypageDAOImpl.class).getTotalCount(parameterVO);

		ArrayList<WooBoardVO> likeList = sqlSession.getMapper(MypageDAOImpl.class).selectBoard(parameterVO);

		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
				"../mypage/myList_L.woo?");
		model.addAttribute("pagingImg", pagingImg);
		System.out.println(pagingImg);
		for (WooBoardVO vo : likeList) {
			// 내용에 대해 줄바꿈 처리
			String temp = vo.getContent().replace("\r\n", "<br/>");
			vo.setContent(temp);
		}

		model.addAttribute("likeList", likeList);

		return "mypage/myList_L";

	}

	// 좋아요 취소 토글
	@RequestMapping("/mypage/like_toggle.woo")
	@ResponseBody
	public Map<String, Object> likeToggle(Model model, HttpServletRequest req, Principal principal) {

		String idx = req.getParameter("idx");
		System.out.println(idx);
		String user_id = principal.getName();

		int update = sqlSession.getMapper(MypageDAOImpl.class).likeCheck(idx);
		System.out.println("update" + update);
		int like_check = sqlSession.getMapper(MypageDAOImpl.class).selectLikeCheck(idx);
		System.out.println(like_check);

		int likecountUpdate = sqlSession.getMapper(MypageDAOImpl.class).likeCount_puls_minus(like_check, idx);
		System.out.println(likecountUpdate);

		String str = sqlSession.getMapper(MypageDAOImpl.class).selectLike(user_id);

		String[] splitStr = str.split("#");

		List<String> list = new ArrayList<String>();

		for (int i = 0; i < splitStr.length; i++) {
			list.add(splitStr[i]);
		}

		for (int i = 0; i < list.size(); i++) {
 
			if (list.get(i).equals(idx)) {
				System.out.println("listgeti" + list.get(i));
				list.remove(i);
				String new_goodsStr = ""; 
				for (int j = 0; j < list.size(); j++) {
					new_goodsStr += list.get(j) + "#";

				}
				int update1 = sqlSession.getMapper(MypageDAOImpl.class).updateLikeBoard(new_goodsStr, user_id);
				break;
			}

		}

		Map<String, Object> LikeMap = new HashMap<String, Object>();

		LikeMap.put("like_check", like_check);
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

		String back_str = sqlSession.getMapper(MypageDAOImpl.class).selectLike(user_id);
		String str = back_str + req.getParameter("str");

		int update = sqlSession.getMapper(MypageDAOImpl.class).updateLike(str, user_id);
		model.addAttribute("update", update);

		return "product/ajaxList";
	}

}
