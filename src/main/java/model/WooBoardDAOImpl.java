package model;

import java.util.ArrayList;

//
public interface WooBoardDAOImpl {
	int getTotalCount(ParameterVO var1);

	ArrayList<WooBoardVO> listPage(ParameterVO var1);

	WooBoardVO view(String var1);

	int modify(WooBoardVO var1);

	int delete(String var1, String var2);   
}