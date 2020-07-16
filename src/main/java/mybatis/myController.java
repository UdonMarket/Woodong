package mybatis;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import model.BoardListDTO;
import model.BoardListImpl;

@Controller
public class myController {
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping({"/board/create1.woo"})
	public String aa(Model model, BoardListDTO createBoardDTO) {
		return "board/create";
	}

	@RequestMapping({"/board/create.woo"})
	public String list(Model model, BoardListDTO boardListDTO) {
		boardListDTO.setRequestname(boardListDTO.getLocation() + "?bname=" + boardListDTO.getBname() + "&");
		int border = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class))
				.selectOrder(boardListDTO.getLocation());
		boardListDTO.setBoardorder(String.valueOf(border + 1));
		((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class)).createboard(boardListDTO);
		return "board/create";
	}

	@RequestMapping({"/product/productList.woo"})
	public String productlist(Model model, HttpServletRequest req) {
		String blocation = ".." + req.getServletPath();
		System.out.println(blocation);
		List<BoardListDTO> lists = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class))
				.selectBoard(blocation);
		model.addAttribute("lists", lists);
		return "product/productList";
	}

	@RequestMapping({"/community/community.woo"})
	public String community(Model model, HttpServletRequest req) {
		String blocation = ".." + req.getServletPath();
		System.out.println(blocation);
		List<BoardListDTO> lists = ((BoardListImpl) this.sqlSession.getMapper(BoardListImpl.class))
				.selectBoard(blocation);
		model.addAttribute("lists", lists);
		return "community/notice";
	}
}