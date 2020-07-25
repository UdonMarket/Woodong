package model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;


@Service
public interface BoardListImpl {
	
	int selectMaxOrder(String location);
	
	String selectLocation(String idx);
	
	int selectorder(String idx);
	
	List<Map<String, Object>> selectLocationOrder();
	
	void createboard(BoardListVO boardListVO);

	List<BoardListVO> selectBoard(String location);
	
	void editboard(BoardListVO boardListVO);
	
	void deleteboard(String idx);
	
	void updateOrder(String location, int boardorder);
	
	void updateOrder1(String idx);
	void updateOrder2(ParameterVO parameterVO);
	void updateOrder3(BoardListVO boardListVO);
	//bname 검색
	List<BoardListVO> selectBname();
	
}
