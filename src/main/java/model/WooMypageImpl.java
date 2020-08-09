package model;

import java.util.ArrayList;
import java.util.List;

public interface WooMypageImpl {
	
	ArrayList<String> review_score(String user_id);
	
	//메인화면
	String review_score2(String idx);
	
	WooMemberVO myInfo(String var1);
	
	List<String> selectLike(String var1);

	int updateLike(String var1, String var2);
	void deleteLike(String id, String boardidx);
	ArrayList<WooBoardVO> selectBoard(ParameterVO var1);

	int getTotalCount(ParameterVO var1);
	
	//리뷰테이블 totalCount 추가
	int getTotalCountBuyerReview(ParameterVO var1);
	int getTotalCountSellerReview(ParameterVO var1);
	
	int likeCheck(String var1);

	int selectLikeCheck(String var1);

	int likeCount_minus(String var2);
	
	int likeCount_puls(String var2);
	
	public int updateLikeBoard(String new_goodsStr, String user_id);
	
	public int update_reviewTable(ParameterVO parameterVO);
	

	public int update_reviewContents(ParameterVO parameterVO);

	public int update_reviewScore(String cal_reviewPoint, String write_idx);
	
	public int avg_score_update(double avg_score, String user_id);
	
	ArrayList<WooMyreviewVO> selectReview(ParameterVO parameterVO);
	
	//메인화면
	ArrayList<WooMyreviewVO> selectReview2();
	
	ArrayList<WooMyreviewVO> sellerReview(ParameterVO parameterVO);
	
	public int delete(String idx);
	
	public int default_reviewScore(String idx);
	
	public String dealtype(String idx);
	
	public String selectphoneNum(String phoneNum);
	   
    public String selectregidateNum(String id);
   
    public int updateDealtype(String id, String idx);
	
	
}

