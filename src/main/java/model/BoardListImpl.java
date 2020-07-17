package model;

import java.util.List;

public interface BoardListImpl {
	int selectOrder(String location);

	void createboard(BoardListDTO boardListDTO);

	List<BoardListDTO> selectBoard(String location);
}