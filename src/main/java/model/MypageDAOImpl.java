package model;

import java.util.ArrayList;

public interface MypageDAOImpl {
	
	ArrayList<String> review_score(String user_id);
	
	MemberVO myInfo(String var1);
	
	String selectLike(String var1);

	int updateLike(String var1, String var2);

	ArrayList<WooBoardVO> selectBoard(ParameterVO var1);

	int getTotalCount(ParameterVO var1);

	int likeCheck(String var1);

	int selectLikeCheck(String var1);

	int likeCount_minus(String var2);
	
	int likeCount_puls(String var2);
	
	public int updateLikeBoard(String new_goodsStr, String user_id);
	
	public int update_reviewTable(ParameterVO parameterVO);
	
	public int update_reviewContents(String contents, String idx);
	
	public int update_reviewScore(String cal_reviewPoint, String write_idx);
	
	public int avg_score_update(double avg_score);
}

