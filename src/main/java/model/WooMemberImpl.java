package model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface WooMemberImpl {
	int regist(WooMemberVO var1);

	ArrayList<WooMemberVO> listPage(WooMemberVO var1);

	int getTotalCount(WooMemberVO var1);

	int delete(String var1);

	WooMemberVO passwordAction(String var1, String var2);

	void changeInfomation(String var1, String var2, String var3);

	void deleteMemberAction(String var1, String var2);

	WooMemberVO myInfo(String var1);
	
	WooMemberVO view(String var1);
	
	WooMemberVO startModify(String var1);
	
	void modify(String var1, String var2);
	
	int distance(double var1, double var2, double var3, double var4);
	
	void deleteMember(ParameterVO parameterVO);
	 
	WooMemberVO idFind(String str1);

	WooMemberVO pwFind(String str1);
}
