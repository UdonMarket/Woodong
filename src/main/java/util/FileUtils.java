package util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import model.WooBoardVO;

public class FileUtils {
	
	public List<Map<String, Object>> parseInsertFileInfo(WooBoardVO wooBoardVO,
						MultipartHttpServletRequest req)throws Exception{
	
	String path = req.getSession().getServletContext().getRealPath("/resources/Upload");
	
	List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
	Map<String, Object> listMap = null;
	
	//글 작성자(파일 업로드한 사람)
	String user_id = wooBoardVO.getId();
	
	int  woo_board_idx = wooBoardVO.getSeq_woo_board();
	
	//물리적 경로를 기반으로 File 객체를 생성한후 
	File directory = new File(path);
	//지정된 디렉토리가 존재하는지 확인한후  
	if(!directory.isDirectory()) {
		//만약 없다면 생성함
		directory.mkdirs();
	}
	//wooBoardVO 에 저장된 파일 불러오기
	List<MultipartFile> mf = wooBoardVO.getFile();
	
	 //첨부 파일의 순서를  count 하기 위한 변수
	 int count = 1;
	
	 //파일이 없거나 이름이 없으면  for 문에 진입하지 못함
	 if (mf.size() == 0 && "".equals(mf.get(0).getOriginalFilename())){  } 
	 else {
		 //list 의 size 만큼 반복
    	 for(int i = 0; i < mf.size(); i++) {
    	
    	 //파일없으면 for문 탈출(확장자 인덱스로 판단)	 
		 if(mf.get(i).getOriginalFilename().lastIndexOf(".")==-1) { break; }
		 
		 //원본파일명
		 String original_name = mf.get(i).getOriginalFilename();
		 //파일 확장자
		 String fileExtension = original_name.substring(original_name.lastIndexOf("."));
		 //저장되는 파일명
		 String save_name = getUuid() + fileExtension;
		 //파일이 저장되는 풀경로  
		 File serverFullName = new File (path +File.separator+ save_name);
		 //파일 업로드
		 mf.get(i).transferTo(serverFullName);
 			
		 listMap = new HashMap<String, Object>();
		 listMap.put("original_name", original_name);
		 listMap.put("save_name", save_name);
		 listMap.put("user_id", user_id);
		 listMap.put("file_num", count);
		 listMap.put("boardidx", woo_board_idx);
		 
		 list.add(listMap);
		 //파일 순서 1 증가 => file_num
		 count++;
    	 }
    }
	return list;
}
	
	public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

}
