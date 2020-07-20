package model;

import java.util.List;

import org.springframework.stereotype.Service;
@Service
public interface BoardListImpl {
	int selectOrder(String location);

	void createboard(BoardListDTO boardListDTO);

	List<BoardListDTO> selectBoard(String location);
	
	//bname 검색
	List<BoardListDTO> selectBname();
}