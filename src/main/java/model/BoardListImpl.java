package model;

import java.util.List;

public interface BoardListImpl {
	int selectOrder(String var1);

	void createboard(BoardListDTO var1);

	List<BoardListDTO> selectBoard(String var1);
}