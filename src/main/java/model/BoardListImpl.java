package model;

import java.util.List;

public interface BoardListImpl {
	int selectOrder(String location);

	void createboard(BoardListVO boardListDTO);

	List<BoardListVO> selectBoard(String location);
	
	void editboard(BoardListVO boardListVO);
}