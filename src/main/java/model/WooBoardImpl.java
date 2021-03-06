package model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

//우동 게시판 
public interface WooBoardImpl {
	
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
	public void write (WooBoardVO wooBoardVO);
	
	//4-1 . 첨부파일 업로드
	public void insertFile(Map<String,Object> map);
	
	
	//5.수정하기
	public int update(WooBoardVO wooBoardVO);
	
	//4-1 . 첨부파일 수정
	public int updateFile(Map<String,Object> map);
	

	//6.삭제하기
	public void delete(ParameterVO parameterVO);   
	//7.끌올하기
	public int jump(ParameterVO parameterVO);   
	
	//판매자 id 가져오기 
	public String selectId(String idx);

	//7.내주변 상품 찾아오기
	public ArrayList<WooBoardVO> searchRadius(ParameterVO parameterVO);
	
	public void communityWrite(WooBoardVO wooBoardVO);
	
	public ArrayList<WooBoardVO> selectCommunity(ParameterVO parameterVO);
	
	public void communityEdit(WooBoardVO wooBoardVO);
	
	public void deleteBoard(ParameterVO parameterVO);
	
	//판매상태 가져오기
	public String selectSellingStatus(String idx);	
  
	public ArrayList<WooBoardVO> list(ParameterVO parameterVO);
	
	public ArrayList<ParameterVO> bnameProductCount(ParameterVO parameterVO);
}
