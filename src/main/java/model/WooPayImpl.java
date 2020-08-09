package model;

import java.util.ArrayList;

public interface WooPayImpl {
	
	//결제 진행 후 DB저장
	public void woopay(WooPayVO var1);
	//결제 완료시 결제완료로 업데이트
	public void woopaySave(String board_idx,String idx);
	//거래내역 게시물 퐁 갯수
	public int getTotalCount(ParameterVO parameterVO);
	//거래내역 총 리스트
	public ArrayList<WooPayVO> listPage(ParameterVO parameterVO);
	//거래내역 삭제처리
	public int deleteBoard(ParameterVO parameterVO);   
}
