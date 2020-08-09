package android;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import model.FileVO;
import model.ParameterVO;
import model.WooAndroidImpl;
import model.WooAndroidVO;
import model.WooBoardImpl;
import model.WooBoardListImpl;
import model.WooBoardListVO;
import model.WooBoardVO;
import model.WooChatImpl;
import model.WooChatRoomVO;
import model.WooMemberImpl;
import model.WooMypageImpl;
import model.WooMyreviewVO;
import util.EnvFileReader;
import util.PagingUtil;
import util.review;

@Controller
public class WoodongAppController {
   
   @Autowired
   private SqlSession sqlSession;
   
   @RequestMapping("/android/WooAppProductList.woo")
   @ResponseBody
   public Map<String, Object> ajaxList(Model model, HttpServletRequest req) {
      Map<String, Object> boardList = new HashMap<String, Object>();
      
      ParameterVO parameterVO = new ParameterVO();
      ArrayList<String> list = new ArrayList<String>();
      String mobile = req.getParameter("mobile");
      String user_id = sqlSession.getMapper(WooMypageImpl.class).selectphoneNum(mobile.substring(0,3) + "-" + mobile.substring(3,7) + "-" + mobile.substring(7));
        
      parameterVO.setId(user_id);
      String juso1 = sqlSession.getMapper(WooMemberImpl.class).selectMember(parameterVO).getAddr();
      String juso2 = juso1.substring(0, juso1.lastIndexOf(" "));
      parameterVO.setJuso(juso2);
      String dong = juso2.substring(juso2.lastIndexOf(" "));
      String location = ".." + req.getServletPath();
      
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
      int pageSize = 12;
      int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
      
      int start = (nowPage - 1) * pageSize + 1;
      int end = nowPage * pageSize;
      
      if(nowPage==1) {
         start = 1;
         end = 12;
      }
      
      parameterVO.setStart(start);
      parameterVO.setEnd(end);
      
      int total = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).getTotalCount(parameterVO);
      ArrayList<WooBoardVO> lists = ((WooBoardImpl) sqlSession.getMapper(WooBoardImpl.class)).listPage(parameterVO);
      Iterator itr = lists.iterator();
      //소영 추가부분
      
     
      if(user_id!=null) {
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
      boardList.put("dong", dong);
      
      return boardList;
   }

   
   
   
   public static String getUuid() {
      String uuid = UUID.randomUUID().toString();
      System.out.println("생성된 UUID1:" +  uuid);
      uuid = uuid.replaceAll("-", "");
      System.out.println("생성된 UUID2:" +  uuid);
      return uuid;
   }
   
   
   @RequestMapping(method=RequestMethod.POST, value="/android/uploadAndroid.woo")
   @ResponseBody
   public Map uploadAndroid(Model model, MultipartHttpServletRequest req) {
      
      //서버의 물리적경로 가져오기
      String path = req.getSession().getServletContext().getRealPath("/resources/Upload");
      
      //폼값과 파일명을 저장후 View로 전달하기 위한 맵 생성
      Map returnObj = new HashMap();
      try {
         //업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
         Iterator itr = req.getFileNames();
         
         MultipartFile mfile = null;
         String fileName = "";
         List resultList =  new ArrayList();
         //파일외의 폼값 받음(여기서는 제목만 있음 )
         String title = req.getParameter("title");
         String price = req.getParameter("price");
         System.out.println("title:" + title);
         System.out.println("price:" + price);
         
         /*
          물리적경로를 기반으로 File 객체 생성한 후 지정된 
          디렉토리가 존재하는지 확인함. 만약 없다면 생성함.
          */
         File directory = new File(path);
         if(!directory.isDirectory()) {
            directory.mkdirs();
         }
         
         //업로드폼의 file속성의 필드갯수만큼 반복
         while(itr.hasNext()) {
            //전송된 파일의 이름을 읽어옴.
            fileName = (String)itr.next();
            mfile = req.getFile(fileName);
            System.out.println("mfile:" + mfile);
            
            //한글깨짐방지 처리 후 전송된 파일명을 가져옴.
            String originalName = new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
            //서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
            if("".equals(originalName)) {
               continue;
            }
            
            //파일명에서 확장자 부분을 가져옴
            String ext = originalName.substring(originalName.lastIndexOf('.'));
            //UUID를 통해 생성된 문자열과 확장자를 합침
            String saveFileName = getUuid() + ext;
            //물리적 경로에 새롭게 생성된 파일명으로 파일저장
            File serverFullName = new File(path + File.separator + saveFileName);
            
            mfile.transferTo(serverFullName);
            
            //서버에 파일업로드 완료 후..
            Map file = new HashMap();
            file.put("originalName", originalName);//원본파일명
            file.put("saveFileName", saveFileName);//저장된 파일명
            file.put("serverFullName", serverFullName);//서버의 전체경로
            file.put("title", title);//제목
            //위 4가지 정보를 저장한 Map을 ArrayList에 저장한다.
            resultList.add(file);
         }
         
         //파일 업로드에 성공했을 때..
         returnObj.put("files", resultList);
         returnObj.put("success", 1);
         
      } catch (IOException e) {
         //파일 업로드에 실패했을 때..
         returnObj.put("success", 0);
         e.printStackTrace();
      }
      catch (Exception e) {
         //파일 업로드에 실패했을 때..
         returnObj.put("success", 0);
         e.printStackTrace();
      }
      
      return returnObj;
   }
   
   
   @RequestMapping("/android/WooAppChatList.woo")
   @ResponseBody
   public Map<String, Object> WooAppChatList(HttpServletRequest req) {
	  Map<String, Object> chatList = new HashMap<String, Object>();
	   
	  String seller_num = req.getParameter("id");
	   
      String seller_num1 = seller_num.substring(0, 3);
      String seller_num2 = seller_num.substring(3, 7);
      String seller_num3 = seller_num.substring(7);
      String s_Num = seller_num1 + "-" + seller_num2 + "-" + seller_num3;
      System.out.println("s_Num=" + s_Num);
      String seller_id = sqlSession.getMapper(WooMypageImpl.class).selectphoneNum(s_Num);
      System.out.println("id=" + seller_id);
      
      ArrayList<WooChatRoomVO> chatroom = sqlSession.getMapper(WooChatImpl.class).selectChatRoomList(seller_id);
      ArrayList<String> chatText;
      String chattingText = "";
      review review = new review();
      Map<String,Object> reviewmap = new HashMap<String, Object>();
      
      for(WooChatRoomVO wc:chatroom) {
    	  String chatroomIdx = wc.getChatroomidx();
    	  chatText = sqlSession.getMapper(WooChatImpl.class).selectChatText(chatroomIdx,wc.getBuyerid());
    	  System.out.println("chatText : " + chatText);
    	  System.out.println("1:" + wc.getBoardidx());
    	  System.out.println("2:" + wc.getBuyerid());
    	  System.out.println("3:" + wc.getSellerid());
    	  System.out.println("4:" + wc.getChatroomidx());
    	  System.out.println("5:" + wc.getLastchatdate());
    	  
    	  reviewmap = review.revireScore(sqlSession, wc.getBuyerid());
    	  wc.setGetUserGrade(reviewmap.get("getUserGrade").toString());

    	  chatList.put("chatroom",  reviewmap.get("getUserGrade"));
    	  System.out.println("getUserGrade : " + reviewmap.get("getUserGrade"));
    	  
    	  Timestamp ts = wc.getLastchatdate();
          Date date = new Date();
          date.setTime(ts.getTime());
          String formattedDate = new SimpleDateFormat("hh:mm").format(date);
    	  wc.setLastchatdateString(formattedDate);
    	  
    	  if(chatText.size()!=0) {
	    	  chattingText = chatText.get(0);
	    	  wc.setChatting(chattingText);
    	  }
    	 System.out.println("chattingText" + chattingText);
      }
	  chatList.put("chatroom", chatroom);
	  
      return chatList;
   }
   
   
   @RequestMapping("/android/WooAppChatLocation.woo")
   @ResponseBody
   public Map<String,Object> WooAppChatLocation(HttpServletRequest req) {
	   Map<String, Object> chatList = new HashMap<String, Object>();
	   String chatroomIdx = req.getParameter("chatroomIdx");
	   System.out.println("chatroomIdx : " + chatroomIdx);
	   
	   ArrayList<WooChatRoomVO> chatroom =  sqlSession.getMapper(WooChatImpl.class).selectChatRoomFromidx(chatroomIdx);	  
	   String boardIdx;
	   String buyeriId;
	   ArrayList<WooBoardVO> Wooboard;
	   String boardbuyerId;
	   String latitude;
	   String longitude;
	   
	   for(WooChatRoomVO wc:chatroom) {
    	  System.out.println("1 getBoardidx:" + wc.getBoardidx());
    	  System.out.println("2 getBuyerid:" + wc.getBuyerid());
    	  boardIdx = wc.getBoardidx();
    	  buyeriId = wc.getBuyerid();
    	  
    	  Wooboard = sqlSession.getMapper(WooChatImpl.class).selectBuyerid(boardIdx);
    	  boardbuyerId = Wooboard.get(0).getBuyer_id();
    	  latitude = Wooboard.get(0).getLatitude();
    	  longitude = Wooboard.get(0).getLongitude();
    	  System.out.println("boardbuyerId : " + Wooboard.get(0).getBuyer_id());
    	  System.out.println("latitude : " + Wooboard.get(0).getLatitude());
    	  System.out.println("longitude : " + Wooboard.get(0).getLongitude());
    	 
    	  if(buyeriId.equals(boardbuyerId)) {
    		  System.out.println("성공");
    		  chatList.put("success", 1);
    		  chatList.put("latitude", Wooboard.get(0).getLatitude());
    		  chatList.put("longitude", Wooboard.get(0).getLongitude());
    	  }
    	  else {
    		  chatList.put("success", 0);
    	  }
	   }
	   
	   return chatList;
   }
   
   
   // 좋아요 
   @RequestMapping("/android/likeToggle.woo")
   @ResponseBody
   public Map<String, Object> likeToggle(Model model, HttpServletRequest req, Principal principal) {
      String idx = req.getParameter("idx");
      String likeflag = req.getParameter("likeflag");
      String mobile = req.getParameter("mobile");
      String user_id = sqlSession.getMapper(WooMypageImpl.class).selectphoneNum(mobile.substring(0,3) + "-" + mobile.substring(3,7) + "-" + mobile.substring(7));
      if(likeflag.equals("1")) {
         System.out.println("취소");
         int likecountUpdate = sqlSession.getMapper(WooMypageImpl.class).likeCount_minus(idx);
         sqlSession.getMapper(WooMypageImpl.class).deleteLike(user_id, idx);
         
      }
      else if(likeflag.equals("-1")){
         System.out.println("성공");
         int likecountUpdate = sqlSession.getMapper(WooMypageImpl.class).likeCount_puls(idx);
         int update = sqlSession.getMapper(WooMypageImpl.class).updateLike(user_id, idx);
      }
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("check", "1");
      return map;
      
   }
   @RequestMapping("/android/myPlaceAction.woo")
   @ResponseBody
   public String myPlaceAction(HttpServletRequest req) {
      System.out.println("시작");
      String juso = req.getParameter("juso").substring(0, req.getParameter("juso").lastIndexOf(" "));
      String mobile = req.getParameter("mobile");
      String user_id = sqlSession.getMapper(WooMypageImpl.class).selectphoneNum(mobile.substring(0,3) + "-" + mobile.substring(3,7) + "-" + mobile.substring(7));
      
      sqlSession.getMapper(WooMemberImpl.class).modify(juso, user_id);
      
      return "redirect:myPlace.woo";
   }
   
   
   @RequestMapping("/android/WooAppCreateqr.woo")
   @ResponseBody
   public Map createqr(Model model, HttpServletRequest req) {

      Map returnObj = new HashMap();
      
      //String buyer_num = "01012345678";
      String buyer_num = req.getParameter("buyer");
      System.out.println("buyer_num=" + req.getParameter("buyer"));
      String buyer_num1 = buyer_num.substring(0, 3);
      String buyer_num2 = buyer_num.substring(3, 7);
      String buyer_num3 = buyer_num.substring(7);
      String b_Num = buyer_num1 + "-" + buyer_num2 + "-" + buyer_num3;
      System.out.println("b_Num=" + b_Num);
      String buyer_id = sqlSession.getMapper(WooMypageImpl.class).selectphoneNum(b_Num);
      System.out.println("id=" + buyer_id);
      
      //String boardIdx = "1560";
      String boardIdx = req.getParameter("boardIdx");
      System.out.println("boardIdx=" + req.getParameter("boardIdx"));
      
      int success = sqlSession.getMapper(WooMypageImpl.class).updateDealtype(buyer_id, boardIdx);
      System.out.println("success"+success);
      if(success==1) {
         returnObj.put("success", 1);
      } else {
         returnObj.put("success", 0);
      }
      
      return returnObj;
   }
   
   @RequestMapping("/android/WooAppMember.woo")
   @ResponseBody
   public Map<String, Object> WooAppMember(HttpServletRequest req) {
      
      Map<String,Object> reviewmap = new HashMap<String, Object>();
      
      String num = req.getParameter("id");
      //String num = "01036039795";
      
      System.out.println("num=" + req.getParameter("id"));
      
      String num1 = num.substring(0, 3);
      String num2 = num.substring(3, 7);
      String num3 = num.substring(7);
      String Num = num1 + "-" + num2 + "-" + num3;
      
      System.out.println("Num=" + Num);
      
      String id = sqlSession.getMapper(WooMypageImpl.class).selectphoneNum(Num);
      
      System.out.println("id=" + id);
      /*
       * Timestamp ts = wc.getLastchatdate(); Date date = new Date();
       * date.setTime(ts.getTime()); String formattedDate = new
       * SimpleDateFormat("hh:mm").format(date);
       */
       
        
      String regidate = sqlSession.getMapper(WooMypageImpl.class).selectregidateNum(id);
      
      System.out.println("regidate=" + regidate);
      
      reviewmap = review.revireScore(sqlSession, id);
      String getUserGrade = reviewmap.get("getUserGrade").toString();
      System.out.println("getUserGrade=" + getUserGrade);
      String trade_count = reviewmap.get("trade_count").toString();
      System.out.println("trade_count=" + trade_count);
      String avg_score = reviewmap.get("avg_score").toString();
      System.out.println("avg_score=" + avg_score);
      
      Map<String, Object> Memberlist = new HashMap<String, Object>();
       
       Memberlist.put("getUserGrade", getUserGrade);
       Memberlist.put("trade_count", trade_count);
       Memberlist.put("avg_score", avg_score);
       Memberlist.put("id", id);
       Memberlist.put("regidate", regidate);
       
       return  Memberlist;
    
    }
   
   @RequestMapping("/android/WooAppMyPagelist.woo")
   @ResponseBody
   public Map<String, Object> myPage(Model model, HttpServletRequest req, Principal principal) {

      Map<String, Object> myPagelist = new HashMap<String, Object>();

      String num = req.getParameter("mobile");
      System.out.println("num=" + req.getParameter("mobile"));
      String num1 = num.substring(0, 3);
      String num2 = num.substring(3, 7);
      String num3 = num.substring(7);
      String Num = num1 + "-" + num2 + "-" + num3;
      System.out.println("num=" + Num);
      String user_id = sqlSession.getMapper(WooMypageImpl.class).selectphoneNum(Num);
      System.out.println("id=" + user_id);

      
      if(req.getParameter("seller_id") == null) { 
         //user_id = principal.getName();
      }else { 
          user_id = req.getParameter("seller_id");
        //model.addAttribute("realUser_id", principal.getName());
          }
       
       
      Map<String, Object> map = review.revireScore(sqlSession, user_id);

      model.addAttribute("memberVO", map.get("memberVO"));
      model.addAttribute("udongGrade", map.get("udongGrade"));
      model.addAttribute("score", map.get("score"));

      String mode = req.getParameter("mode");
      if (mode == null)
         mode = "";
      String dealMode = req.getParameter("dealmode");
      System.out.println(mode+"1");
      System.out.println(dealMode+"2");

      ParameterVO parameterVO = new ParameterVO();
      parameterVO.setMode(mode);
      parameterVO.setDealMode(dealMode);

      int pageSize = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.pageSize"));
      int blockPage = Integer.parseInt(EnvFileReader.getValue("SpringBbsInit.properties", "springBoard.blockPage"));

      // 현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum 구하기
      int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
      int start = (nowPage - 1) * pageSize + 1;
      int end = nowPage * pageSize;

      parameterVO.setStart(start);
      parameterVO.setEnd(end);

      parameterVO.setUser_id(user_id);
      List<String> list = sqlSession.getMapper(WooMypageImpl.class).selectLike(user_id);
      parameterVO.setList(list);

      int totalRecordCount = sqlSession.getMapper(WooMypageImpl.class).getTotalCount(parameterVO);

      ArrayList<WooBoardVO> likeList = sqlSession.getMapper(WooMypageImpl.class).selectBoard(parameterVO);
      ArrayList<WooMyreviewVO> riviewList = sqlSession.getMapper(WooMypageImpl.class).selectReview(parameterVO);
      for (WooMyreviewVO rv : riviewList) {

         String idx = rv.getBoardidx();
         ArrayList<FileVO> uploadFileList = sqlSession.getMapper(WooBoardImpl.class).viewFile(idx);
         // 사진 중 첫번째 사진만 저장.
         try {
            String image = uploadFileList.get(0).getSave_name();
            rv.setImagefile(image);
         } catch (Exception e) {
         }
      }
      for (WooBoardVO rv : likeList) {

         String idx = rv.getBoardidx();
         ArrayList<FileVO> uploadFileList = sqlSession.getMapper(WooBoardImpl.class).viewFile(idx);
         // 사진 중 첫번째 사진만 저장.
         System.out.println(rv.getBoardidx());
         System.out.println(rv.getDeal_type());
         System.out.println(rv.getId());
         System.out.println(rv.getImagefile());
         System.out.println(rv.getTitle());

         try {
            String image = uploadFileList.get(0).getSave_name();
            rv.setImagefile(image);
         } catch (Exception e) {
         }
         String dealtype = sqlSession.getMapper(WooMypageImpl.class).dealtype(idx);
         rv.setDeal_type(dealtype);
      }
      model.addAttribute("likeList", likeList);
      model.addAttribute("riviewList", riviewList);
      String pagingImg = "";
      String page = "";

      String dealPosition = req.getParameter("dealPosition");
      String seller_id = req.getParameter("seller_id");
      if (seller_id != null) {
         parameterVO.setSeller_id(seller_id);
         ArrayList<WooMyreviewVO> sellerRiviewList = sqlSession.getMapper(WooMypageImpl.class)
               .sellerReview(parameterVO);
         for (WooMyreviewVO rv : sellerRiviewList) {

            String idx = rv.getBoardidx();
            ArrayList<FileVO> uploadFileList = sqlSession.getMapper(WooBoardImpl.class).viewFile(idx);
            // 사진 중 첫번째 사진만 저장.
            try {
               String image = uploadFileList.get(0).getSave_name();
               rv.setImagefile(image);
            } catch (Exception e) {
            }
         }
         model.addAttribute("sellerRiviewList", sellerRiviewList);
      }

      model.addAttribute("seller_avgscore", map.get("avg_score"));
      if (mode.equals("deal")) {
         if (dealMode.equals("sell")) {
            pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
                  "../mypage/myPage.woo?mode=deal&dealMode=sell&");
         } else {
            pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
                  "../mypage/myPage.woo?mode=deal&dealMode=buy&");
         }
         page = "mypage/myList_W";
      } else if (mode.equals("sell")) {
         pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
               "../mypage/myPage.woo?mode=sell&");
         page = "mypage/myList_S";
      } else if (mode.equals("buy")) {
         pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
               "../mypage/myPage.woo?mode=buy&");
         page = "mypage/myList_B";
      } else if (mode.equals("review")) {
         if ("seller".equals(dealPosition)) {
            totalRecordCount = sqlSession.getMapper(WooMypageImpl.class).getTotalCountSellerReview(parameterVO);
            page = "mypage/sellerReview";
            pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
                  "../mypage/myPage.woo?mode=review&dealPosition=seller&seller_id=" + seller_id + "&");
         } else if ("buyer".equals(dealPosition)) {
            totalRecordCount = sqlSession.getMapper(WooMypageImpl.class).getTotalCountBuyerReview(parameterVO);
            page = "mypage/myReview";
            pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
                  "../mypage/myPage.woo?mode=review&dealPosition=buyer&");
         }
         model.addAttribute("user_id", user_id);
      } else if (mode.equals("like")) {
         pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
               "../mypage/myPage.woo?mode=like&");
         page = "mypage/myList_L";
      } else {
         page = "mypage/myPage";
      }

      model.addAttribute("pagingImg", pagingImg);
      myPagelist.put("myPagelist", likeList);
      // myPagelist.put("reviewlist", riviewList);
      // myPagelist.put("dealmode", dealMode);

      return myPagelist;
   }
   
   @RequestMapping("/android/WoolocationSave.woo")
   @ResponseBody
   public Map<String, Object> memberLogin(HttpServletRequest req){
      WooAndroidVO vo = new WooAndroidVO();
      
      String user_id = req.getParameter("id");
      String latitude = req.getParameter("latitude");
      String longitude = req.getParameter("longitude");
      
      System.out.println("save : " + user_id);
      System.out.println("latitude : " + latitude);
      System.out.println("longitude : " + longitude);
      System.out.println("num : " + req.getParameter("num"));
      
      vo.setLatitude(latitude);
      vo.setLongitude(longitude);
      vo.setUser_id(user_id);
      vo.setNum(req.getParameter("num"));
      /*
       매개변수로 커맨드객체(VO)를 사용하므로 파라미터명은 VO의 필드와
       동일하게 id, pass, name과 같이 사용하면 된다. 
       
       요청 URL
          -> http://localhost:8080/k12springapi/android/memberLogin.do?id=kos&pass=kos1
       */
      
      Map<String, Object> returnMap = new HashMap<String, Object>();
      
      int res = sqlSession.getMapper(WooAndroidImpl.class).WoolocationSave(vo);
      
      if(res==0) {
         //회원정보가 일치하지 않는다면...
         returnMap.put("islocationSave", 0);
      }
      else {
         //회원정보가 일치하면 회원정보 전체를 반환한다.
         //returnMap.put("memberInfo", memberInfo);
         returnMap.put("islocationSave", 1);
      }
      
      System.out.println("save");
      
      return returnMap;
   }
   
   /*
    위치 업데이트  
    */
   @RequestMapping("/android/WoolocationUpdate.woo")
   @ResponseBody
   public Map<String, Object> WoolocationUpdate(HttpServletRequest req){
      WooAndroidVO vo = new WooAndroidVO();
      
      System.out.println("update start");
      String user_id = req.getParameter("id");
      String latitude = req.getParameter("latitude");
      String longitude = req.getParameter("longitude");
      
      vo.setNum(req.getParameter("num"));
      vo.setUser_id(user_id);
      vo.setLatitude(latitude);
      vo.setLongitude(longitude);
      
      System.out.println("update save : " + user_id);
      System.out.println("update latitude : " + latitude);
      System.out.println("update longitude : " + longitude);
      System.out.println("update num : " + req.getParameter("num"));
      /*
       매개변수로 커맨드객체(VO)를 사용하므로 파라미터명은 VO의 필드와
       동일하게 id, pass, name과 같이 사용하면 된다. 
       
       요청 URL
          -> http://localhost:8080/k12springapi/android/memberLogin.do?id=kos&pass=kos1
       */
      
      Map<String, Object> returnMap = new HashMap<String, Object>();
      
      int res = sqlSession.getMapper(WooAndroidImpl.class).WoolocationUpdate(vo);
      
      if(res==0) {
         //회원정보가 일치하지 않는다면...
         returnMap.put("islocationUpdate", 0);
      }
      else {
         //회원정보가 일치하면 회원정보 전체를 반환한다.
         //returnMap.put("memberInfo", memberInfo);
         returnMap.put("islocationUpdate", 1);
      }
      
      return returnMap;
   }
   
   /*
    유저 아이디에 맞는 위치 값 가져오기 
    */
   @RequestMapping("/WoolocationSelect.woo")
   public String WoolocationSelect(HttpServletRequest req, Model model){
      WooAndroidVO vo = new WooAndroidVO();
      /*
       매개변수로 커맨드객체(VO)를 사용하므로 파라미터명은 VO의 필드와
       동일하게 id, pass, name과 같이 사용하면 된다. 
       
       요청 URL
          -> http://localhost:8080/k12springapi/android/memberLogin.do?id=kos&pass=kos1
       */
      
      String user_id = req.getParameter("id");
      String pw = req.getParameter("pw");
      
      Map<String, Object> returnMap = new HashMap<String, Object>();
      vo.setUser_id(user_id);
      vo.setNum(pw);
      WooAndroidVO locationvo = sqlSession.getMapper(WooAndroidImpl.class).WoolocationSelect(vo);
      
      if(locationvo!=null) {
         returnMap.put("latitue", locationvo.getLatitude());
         returnMap.put("longitude", locationvo.getLongitude());
         returnMap.put("res", 1);
      }
      else {
         returnMap.put("res", 0);
      }
      //String url = "http://maps.google.com/maps?z=16&q="+locationvo.getLatitude()+","+locationvo.getLongitude();
      //returnMap.put("url", url);
      String latitude = locationvo.getLatitude();
      String logitude = locationvo.getLongitude();
      model.addAttribute("user_id", user_id);
      model.addAttribute("pw", pw);
      model.addAttribute("latitude", latitude);
      model.addAttribute("logitude", logitude);
      
      System.out.println("select check");
      return "member/location";
   }
   
   @RequestMapping(value = "/Wooajaxmap.woo")
   @ResponseBody
   public Map<String, Object> Wooajaxmap(HttpServletRequest req, Model model){
      WooAndroidVO vo = new WooAndroidVO();
      /*
       매개변수로 커맨드객체(VO)를 사용하므로 파라미터명은 VO의 필드와
       동일하게 id, pass, name과 같이 사용하면 된다. 
       
       요청 URL
          -> http://localhost:8080/k12springapi/android/memberLogin.do?id=kos&pass=kos1
       */
      
      String user_id = req.getParameter("user_id");
      Map<String, Object> returnMap = new HashMap<String, Object>();
      vo.setUser_id(user_id);
      vo.setNum(req.getParameter("pw"));
      WooAndroidVO locationvo = sqlSession.getMapper(WooAndroidImpl.class).WoolocationSelect(vo);
      if(locationvo!=null) {
         returnMap.put("latitude", locationvo.getLatitude());
         returnMap.put("longitude", locationvo.getLongitude());
         returnMap.put("id", vo.getUser_id());
         returnMap.put("res", 1);
      }
      else {
         returnMap.put("res", 0);
      }
      //String url = "http://maps.google.com/maps?z=16&q="+locationvo.getLatitude()+","+locationvo.getLongitude();
      //returnMap.put("url", url);
      
      return returnMap;
   }
   
   @RequestMapping("/android/WoolocationDelete.woo")
   public Map<String, Object> WoolocationDelete(HttpServletRequest req, Model model){
      WooAndroidVO vo = new WooAndroidVO();
      
      /*
       매개변수로 커맨드객체(VO)를 사용하므로 파라미터명은 VO의 필드와
       동일하게 id, pass, name과 같이 사용하면 된다. 
       
       요청 URL
          -> http://localhost:8080/k12springapi/android/memberLogin.do?id=kos&pass=kos1
       */
      
      String user_id = req.getParameter("id");
      String pw = req.getParameter("num");
      
      Map<String, Object> returnMap = new HashMap<String, Object>();
      vo.setUser_id(user_id);
      vo.setNum(pw);
      int locationvo = sqlSession.getMapper(WooAndroidImpl.class).WoolocationDelete(vo);
      
      if(locationvo==1) {
         returnMap.put("islocationDelete", 1);
      }
      else {
         returnMap.put("islocationDelete", 0);
      }
      
      System.out.println("delete check");
      
      return returnMap;
   }
   
   
   
   
   
   
}