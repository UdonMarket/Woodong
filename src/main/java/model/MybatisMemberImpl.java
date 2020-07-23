package model;

import java.util.ArrayList;
import org.springframework.stereotype.Service;

@Service
public interface MybatisMemberImpl {
	void regist(MemberVO var1);

	ArrayList<MemberVO> listPage(MemberVO var1);

	int getTotalCount(MemberVO var1);

	int delete(String var1);

	MemberVO passwordAction(String var1, String var2);

	void changeInfomation(String var1, String var2, String var3);

	void deleteMemberAction(String var1, String var2);

	MemberVO myInfo(String var1);
	
	MemberVO view(String var1);
	
	void modify(String var1, String var2);
	
	int distance(double var1, double var2, double var3, double var4);
	 
}