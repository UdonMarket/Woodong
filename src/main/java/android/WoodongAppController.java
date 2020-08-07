package android;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
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
      int pageSize = 6;
      int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
      
      int start = (nowPage - 1) * pageSize + 1;
      int end = nowPage * pageSize;
      
      if(nowPage==1) {
         start = 1;
         end = 6;
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
         System.out.println("title:" + title);
         
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


}