package mybatis;

import java.util.List;

public interface CreateBoardImpl {
	int selectOrder(String var1);

	void createboard(CreateBoardDTO var1);

	List<CreateBoardDTO> selectBoard(String var1);
}