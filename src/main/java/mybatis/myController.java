package mybatis;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class myController {
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping({"/board/create1.woo"})
	public String aa(Model model, CreateBoardDTO createBoardDTO) {
		return "board/create";
	}

	@RequestMapping({"/board/create.woo"})
	public String list(Model model, CreateBoardDTO createBoardDTO) {
		createBoardDTO.setRequestname(createBoardDTO.getBlocation() + "?bname=" + createBoardDTO.getBname() + "&");
		int border = ((CreateBoardImpl) this.sqlSession.getMapper(CreateBoardImpl.class))
				.selectOrder(createBoardDTO.getBlocation());
		createBoardDTO.setBorder(String.valueOf(border + 1));
		((CreateBoardImpl) this.sqlSession.getMapper(CreateBoardImpl.class)).createboard(createBoardDTO);
		return "board/create";
	}

	@RequestMapping({"/product/productList.woo"})
	public String productlist(Model model, HttpServletRequest req) {
		String blocation = ".." + req.getServletPath();
		System.out.println(blocation);
		List<CreateBoardDTO> lists = ((CreateBoardImpl) this.sqlSession.getMapper(CreateBoardImpl.class))
				.selectBoard(blocation);
		model.addAttribute("lists", lists);
		return "product/productList";
	}

	@RequestMapping({"/community/community.woo"})
	public String community(Model model, HttpServletRequest req) {
		String blocation = ".." + req.getServletPath();
		System.out.println(blocation);
		List<CreateBoardDTO> lists = ((CreateBoardImpl) this.sqlSession.getMapper(CreateBoardImpl.class))
				.selectBoard(blocation);
		model.addAttribute("lists", lists);
		return "community/notice";
	}
}