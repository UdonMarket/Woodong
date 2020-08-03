package com.kosmo.woodong;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import model.ParameterVO;
import model.WooPayImpl;
import model.WooPayVO;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class WooPayController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/product/woopay.woo")
	public String woopay(Authentication authentication, HttpServletRequest req, Model model) {
		
		String buyer_id = authentication.getName();
		String boardidx = req.getParameter("boardidx");
		String price = req.getParameter("price");
		String title = req.getParameter("title");
		String seller_id = req.getParameter("sellerID");
		
		model.addAttribute("buyer_id", buyer_id);
		model.addAttribute("boardidx", boardidx);
		model.addAttribute("price", price);
		model.addAttribute("title", title);
		model.addAttribute("seller_id", seller_id);
		
		return "product/wooPay";
	}
	
	
	  @ResponseBody
	  @RequestMapping(value = "/product/woopayAction.woo", method = { RequestMethod.POST })
	  	public String woopayAction(HttpServletRequest req, Authentication authentication){
		  WooPayVO vo = new WooPayVO();
	  
		  String buyer_id = authentication.getName();
		  vo.setMerchant_uid(req.getParameter("merchant_uid"));
		  vo.setProduct_name(req.getParameter("product_name"));
		  vo.setProduct_price(req.getParameter("product_price"));
		  vo.setBoard_idx(req.getParameter("board_idx"));
		  vo.setBuyer_id(buyer_id);
		  vo.setSeller_id(req.getParameter("seller_id"));
		  vo.setStatus(req.getParameter("status"));
		  vo.setPay_method(req.getParameter("pay_method"));
		  
		  sqlSession.getMapper(WooPayImpl.class).woopay(vo);
		  
		  sqlSession.getMapper(WooPayImpl.class).woopaySave(req.getParameter("board_idx"));
		  
		  return "mypage/myPage";
	  }
	  
	  @RequestMapping("/admin/payTable.woo")
		public String payTable(Model model, HttpServletRequest req) {
			ParameterVO parameterVO = new ParameterVO();
			parameterVO.setSearchField(req.getParameter("searchField"));
			parameterVO.setSearchTxt(req.getParameter("searchTxt")); 
			int totalRecordCount = sqlSession.getMapper(WooPayImpl.class).getTotalCount(parameterVO);
			int pageSize = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.pageSize"));
			int blockPage = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.blockPage"));
			int totalPage = (int) Math.ceil((double) totalRecordCount / (double) pageSize);
			int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
			int start = (nowPage - 1) * pageSize + 1;
			int end = nowPage * pageSize;
			parameterVO.setStart(start);
			parameterVO.setEnd(end);
			ArrayList<WooPayVO> lists = sqlSession.getMapper(WooPayImpl.class).listPage(parameterVO);
			String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					req.getContextPath() + "/admin/payTable.woo?");
			model.addAttribute("pagingImg", pagingImg);
			model.addAttribute("lists", lists);
			model.addAttribute("grade", req.getParameter("grade"));
			return "admin/homepage/payTable";
		}

		// 결제 내역 삭제처리 
		@RequestMapping("/admin/payDelete.woo")
		public String payDelete(Model model, HttpServletRequest req) {
			
			String checkBoardIdxList = req.getParameter("checkBoardIdxList");
			ArrayList<String> idxList = new ArrayList<String>();
			String[] checkIdxArr = checkBoardIdxList.split("//");
			for(int i=0 ; i<checkIdxArr.length ; i++) {
				idxList.add(checkIdxArr[i]);
			}
			ParameterVO parameterVO = new ParameterVO();
			parameterVO.setList(idxList);
			sqlSession.getMapper(WooPayImpl.class).deleteBoard(parameterVO);
			
			return "redirect:../homepage/payTable.woo";
		}

	 
}
