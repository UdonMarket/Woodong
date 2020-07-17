package model;

import java.util.ArrayList;

public interface MypageDAOImpl {
	String selectLike(String var1);

	int updateLike(String var1, String var2);

	ArrayList<WooBoardVO> selectBoard(ParameterVO var1);

	int getTotalCount(ParameterVO var1);

	int likeCheck(String var1);

	int selectLikeCheck(String var1);

	int likeCount_puls_minus(int var1, String var2);
	
	public int updateLikeBoard(String new_goodsStr, String user_id);
}