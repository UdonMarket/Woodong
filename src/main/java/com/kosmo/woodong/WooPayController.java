package com.kosmo.woodong;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import model.WooMemberImpl;
import model.WooPayImpl;
import model.WooPayVO;

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
		@Transactional(rollbackFor = {Exception.class})
		@ResponseBody
	    @RequestMapping(value = "/product/woopayAction.woo", method = { RequestMethod.POST })
	  	public Map<String, Object> woopayAction(HttpServletRequest req, Authentication authentication){
			Map<String, Object> map = new HashMap<String, Object>();
		try {
			
		  WooPayVO vo = new WooPayVO();
	  
		  String buyer_id = authentication.getName();
		  System.out.println("merchant_uid :" + req.getParameter("merchant_uid"));
		  System.out.println("product_name : " + req.getParameter("product_name"));
		  System.out.println("product_price : " + req.getParameter("product_price"));
		  System.out.println("board_idx : " + req.getParameter("board_idx"));
		  System.out.println("seller_id : " + req.getParameter("seller_id"));
		  System.out.println("buyer_id : " + buyer_id);
		  System.out.println("status : " + req.getParameter("status"));
		  System.out.println("pay_method : " + req.getParameter("pay_method"));
		  
		  vo.setMerchant_uid(req.getParameter("merchant_uid"));
		  vo.setProduct_name(req.getParameter("product_name"));
		  vo.setProduct_price(req.getParameter("product_price"));
		  vo.setBoard_idx(req.getParameter("board_idx"));
		  vo.setBuyer_id(buyer_id);
		  vo.setSeller_id(req.getParameter("seller_id"));
		  vo.setStatus(req.getParameter("status"));
		  vo.setPay_method(req.getParameter("pay_method"));
		  
		   int insertApply = sqlSession.getMapper(WooPayImpl.class).woopay(vo);
		   int updateApply = sqlSession.getMapper(WooPayImpl.class).woopaySave(req.getParameter("board_idx"),buyer_id);
		   
		  
		  map.put("sucOrFail", 1);
		}catch(Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			 map.put("sucOrFail", 0);
			 return map;
		}
		
		
		  return map;
	  }
	 
}