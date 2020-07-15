package com.kosmo.woodong;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import model.MemberVO;
import model.MybatisMemberImpl;
import model.MypageDAOImpl;
import model.ParameterVO;
import model.WooBoardVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import util.PagingUtil;

@Controller
public class MypageController {
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/mypage/myPage.woo")
	public String mypage(Model model, HttpServletRequest req, Principal principal) {
		String user_id = principal.getName();
		System.out.println(user_id);
		MemberVO memberVO = ((MybatisMemberImpl) this.sqlSession.getMapper(MybatisMemberImpl.class)).myInfo(user_id);
		double avg_score = Double.parseDouble(memberVO.getAvg_score());
		int trade_count = Integer.parseInt(memberVO.getTrade_count());
		String score = "";
		int full = (int) avg_score % 5;
		int half = (int) ((avg_score - (double) full) * 10.0D);

		int j;
		for (j = 1; j <= full; ++j) {
			score = score + "<img src='../resources/img/그냥튀김우동.png' alt='' />";
		}

		if (half < 5) {
			for (j = full + 1; j <= 5; ++j) {
				score = score + "<img src='../resources/img/회색우동.png' alt='' />";
			}
		} else {
			score = score + "<img src='../resources/img/반쪽우동.png' alt='' />";

			for (j = full + 2; j <= 5; ++j) {
				score = score + "<img src='../resources/img/회색우동.png' alt='' />";
			}
		}

		String udongGrade = "";
		if (trade_count < 5) {
			udongGrade = udongGrade + "<img src='../resources/img/파랑일반.png' alt='' />";
		} else if (trade_count >= 5 && trade_count < 10) {
			if (avg_score >= 1.0D && avg_score < 2.0D) {
				udongGrade = udongGrade + "<img src='../resources/img/파랑일반.png' alt='' />";
			} else {
				udongGrade = udongGrade + "<img src='../resources/img/빨간일반.png' alt='' />";
			}
		} else if (trade_count >= 10 && trade_count < 15) {
			if (avg_score >= 1.0D && avg_score < 2.0D) {
				udongGrade = udongGrade + "<img src='../resources/img/파랑일반.png' alt='' />";
			} else if (avg_score >= 2.0D && avg_score < 4.0D) {
				udongGrade = udongGrade + "<img src='../resources/img/빨간일반.png' alt='' />";
			} else {
				udongGrade = udongGrade + "<img src='../resources/img/파랑온도계.png' alt='' />";
			}
		} else if (trade_count >= 15) {
			if (avg_score >= 1.0D && avg_score < 2.0D) {
				udongGrade = udongGrade + "<img src='../resources/img/파랑일반.png' alt='' />";
			} else if (avg_score >= 2.0D && avg_score < 4.0D) {
				udongGrade = udongGrade + "<img src='../resources/img/빨간일반.png' alt='' />";
			} else {
				udongGrade = udongGrade + "<img src='../resources/img/빨간온도계.png' alt='' />";
			}
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
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;
		parameterVO.setStart(start);
		parameterVO.setEnd(end);
		String user_id = principal.getName();
		String str = ((MypageDAOImpl) this.sqlSession.getMapper(MypageDAOImpl.class)).selectLike(user_id);
		String[] splitStr = str.split("#");
		List<String> list = new ArrayList();

		int totalRecordCount;
		for (totalRecordCount = 0; totalRecordCount < splitStr.length; ++totalRecordCount) {
			list.add(splitStr[totalRecordCount]);
		}

		parameterVO.setList(list);
		totalRecordCount = ((MypageDAOImpl) this.sqlSession.getMapper(MypageDAOImpl.class)).getTotalCount(parameterVO);
		ArrayList<WooBoardVO> likeList = ((MypageDAOImpl) this.sqlSession.getMapper(MypageDAOImpl.class))
				.selectBoard(parameterVO);
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
				"../mypage/myList_L.woo?");
		model.addAttribute("pagingImg", pagingImg);
		System.out.println(pagingImg);
		Iterator var18 = likeList.iterator();

		while (var18.hasNext()) {
			WooBoardVO vo = (WooBoardVO) var18.next();
			String temp = vo.getContent().replace("\r\n", "<br/>");
			vo.setContent(temp);
		}

		model.addAttribute("likeList", likeList);
		return "mypage/myList_L";
	}

	@RequestMapping("/mypage/like_toggle.woo")
	@ResponseBody
	public Map<String, Object> likeToggle(Model model, HttpServletRequest req, Principal principal) {
		String idx = req.getParameter("idx");
		System.out.println(idx);
		String user_id = principal.getName();
		int update = ((MypageDAOImpl) this.sqlSession.getMapper(MypageDAOImpl.class)).likeCheck(idx);
		System.out.println("update" + update);
		int like_check = ((MypageDAOImpl) this.sqlSession.getMapper(MypageDAOImpl.class)).selectLikeCheck(idx);
		System.out.println(like_check);
		int likecountUpdate = ((MypageDAOImpl) this.sqlSession.getMapper(MypageDAOImpl.class))
				.likeCount_puls_minus(like_check, idx);
		System.out.println(likecountUpdate);
		Map<String, Object> LikeMap = new HashMap();
		LikeMap.put("like_check", like_check);
		return LikeMap;
	}

	@RequestMapping({"/mypage/myReview.woo"})
	public String myreview() {
		return "mypage/myReview";
	}

	@RequestMapping({"/mypage/myProduct.woo"})
	public String myproduct() {
		return "mypage/myProduct";
	}

	@RequestMapping("/product/ajaxLike.woo")
	public String like(Model model, HttpServletRequest req, Principal principal) {
		String user_id = principal.getName();
		String back_str = ((MypageDAOImpl) this.sqlSession.getMapper(MypageDAOImpl.class)).selectLike(user_id);
		String str = back_str + req.getParameter("str");
		int update = ((MypageDAOImpl) this.sqlSession.getMapper(MypageDAOImpl.class)).updateLike(str, user_id);
		model.addAttribute("update", update);
		return "product/ajaxList";
	}
}