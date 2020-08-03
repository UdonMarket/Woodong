package model;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;


@Service
public interface WooBoardListImpl {
	
	int selectMaxOrder(String location);
	
	String selectLocation(String idx);
	
	int selectorder(String idx);
	
	List<Map<String, Object>> selectLocationOrder();
	
	void createboard(WooBoardListVO boardListVO);

	List<WooBoardListVO> selectBoard(String location);
	
	void editboard(WooBoardListVO boardListVO);
	
	void deleteboard(String idx);
	
	void updateOrder(String location, int boardorder);
	
	void updateOrder1(String idx);
	void updateOrder2(ParameterVO parameterVO);
	void updateOrder3(WooBoardListVO boardListVO);
	//bname 검색 
	List<WooBoardListVO> selectBname(String location);
	
	String selectOneBname(String board);
	
	void updateBoardBname(String reBname, String bname);
	
}
