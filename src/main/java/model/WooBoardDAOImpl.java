package model;

import java.util.ArrayList;

//우동 게시판 
public interface WooBoardDAOImpl {
	
	//1. 게시물 갯수 카운트
	public int getTotalCount(ParameterVO parameterVO);

	//2. start 와 end 에 해당하는 게시물 가져오기 (페이지 처리 & 검색 처리 ) 
	public ArrayList<WooBoardVO> listPage(ParameterVO parameterVO);

	//3. 상세보기
	public WooBoardVO view(String idx);
	
	//3-1. 조회수 처리하기
	public int visitcount(String idx);
	

	//4.글쓰기
	public int write (WooBoardVO wooBoardVO);
	
	//5.수정처리하기
	public int modify(WooBoardVO wooBoardVO);

	//6.삭제하기
	public int delete(ParameterVO parameterVO);   
}