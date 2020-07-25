package model;

import java.util.ArrayList;
import java.util.Map;

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
	
	//3-2.파일 리스트
	public ArrayList<FileVO> viewFile(String idx);

	//4.글쓰기
	public int write (WooBoardVO wooBoardVO);
	
	//4-1 . 첨부파일 업로드
	public int insertFile(Map<String,Object> map);
	
	//5.수정처리하기
	public int modify(WooBoardVO wooBoardVO);

	//6.삭제하기
	public int delete(ParameterVO parameterVO);   
	
	//판매자 id 가져오기
	public String selectId(String idx);

	//7.내주변 상품 찾아오기
	public ArrayList<WooBoardVO> searchRadius(ParameterVO parameterVO);

}
