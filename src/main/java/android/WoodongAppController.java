package android;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import model.FileVO;
import model.ParameterVO;
import model.WooBoardImpl;
import model.WooBoardListImpl;
import model.WooBoardListVO;
import model.WooBoardVO;
import model.WooMypageImpl;

@Controller
public class WoodongAppController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/android/WooAppProductList.woo")
	@ResponseBody
	public Map<String, Object> ajaxList(Model model, HttpServletRequest req, Principal principal) {
		Map<String, Object> boardList = new HashMap<String, Object>();
		
		ParameterVO parameterVO = new ParameterVO();
		ArrayList<String> list = new ArrayList<String>();
		List<WooBoardListVO> bnamelists = null;
		if(req.getParameter("bname")!=null && !"".equals(req.getParameter("bname"))) {
			list.add(req.getParameter("bname"));
		}
		else {
			bnamelists = sqlSession.getMapper(WooBoardListImpl.class).selectBname("../product/productList.woo");
			for(WooBoardListVO lists : bnamelists) {
				list.add(lists.getBname());
			}
		}
		
		parameterVO.setList(list);
		int pageSize = 15;
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;
		
		if(nowPage==1) {
			start = 1;
			end = 15;
		}
		
		parameterVO.setStart(start);
		parameterVO.setEnd(end);
		
		int total = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).getTotalCount(parameterVO);
		ArrayList<WooBoardVO> lists = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).listPage(parameterVO);
		Iterator itr = lists.iterator();
		//소영 추가부분
		String user_id = "";
		if(principal!=null) {
			user_id = principal.getName();
			boardList.put("user_id", user_id);
			List<String> str = sqlSession.getMapper(WooMypageImpl.class).selectLike(user_id);
			for (int i = 0; i < lists.size(); i++) {
				for (int j = 0; j < str.size(); j++) {
					if(str.get(j).equals(lists.get(i).getBoardidx())) {
						lists.get(i).setLike_check(1);
					}
				}
			}
		}
		
		String boardidx = "";
		while (itr.hasNext()) {
			WooBoardVO dto = (WooBoardVO) itr.next();
			String temp = dto.getContents().replace("\r\n", "<br/>");
			dto.setContents(temp);
			boardidx = dto.getBoardidx();
			ArrayList<FileVO> uploadFileList = ((WooBoardImpl) this.sqlSession.getMapper(WooBoardImpl.class)).viewFile(boardidx);
			if(!uploadFileList.isEmpty() && uploadFileList.size()!=0) {
				//리스트에서 대표이미지 설정
				String image =  uploadFileList.get(0).getSave_name(); 
				dto.setImagefile(image);
			}
		}
		
		
		//DB에 있는 게시물의 total 과 start를 비교하여 state 설정
		if (start > total) {
			boardList.put("state", "false");
		} else {
			boardList.put("state", "true");
		}

		boardList.put("lists", lists);
		
		
		return boardList;
	}

}
