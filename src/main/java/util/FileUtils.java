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
	
	
	//실제 파일의 물리적 경로
	private static final String path = "C:\\mp\\file\\"; // 파일이 저장될 위치
	
	
	public List<Map<String, Object>> parseInsertFileInfo(WooBoardVO wooBoardVO,
						MultipartHttpServletRequest req)throws Exception{
		
	
	Iterator<String> iterator = req.getFileNames();
	
	MultipartFile multipartFile = null;
	
	List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
	Map<String, Object> listMap = null;
	
	//보드의 idx 값
	String board_num = wooBoardVO.getIdx();
	//글 작성자(파일 업로드한 사람)
	String user_id = wooBoardVO.getId();
	//좀더 처리해야할것이 남아있음 첨부 파일의 순서
	String file_num = "";
	
	/*
		물리적 경로를 기반으로 File 객체를 생성한후 지정된 디렉토리가 존재하는지 확인함
		 만약 없다면 생성함
	 */
	File directory = new File(path);
	if(!directory.isDirectory()) {
		directory.mkdirs();
	}
	
	//업로드폼의 file 속성의 필드갯수 만큼 반복
	while(iterator.hasNext()) {

		//전송된 파일의 이름을 읽어옴
		multipartFile = req.getFile(iterator.next());

		if(multipartFile.isEmpty() == false) {
			//한글깨짐 방지처리후 전송된 파일명을 가져옴
			String original_name = new String(multipartFile.getOriginalFilename().getBytes(),"UTF-8");
			//파일명에서 확장자 부분을 가져옴
			String fileExtension = original_name.substring(original_name.lastIndexOf("."));
			//UUID를 통해 생성된 문자열과 확장자를 합침
			String save_name = getUuid() + fileExtension;
			//물리적 경로에 새롭게 생성된 파일명으로 파일저장
			File serverFullName = new File (path +File.separator+ fileExtension);
			
			

			//서버에 파일 업로드 완료
			multipartFile.transferTo(serverFullName);

			listMap = new HashMap<String, Object>();
			listMap.put("board_num", board_num);//보드의 idx 값
			listMap.put("original_name", original_name);//원본파일명
			listMap.put("save_name", save_name);//저장된 파일명
			listMap.put("file_size", multipartFile.getSize());//파일크기
			listMap.put("serverFullName", serverFullName);//서버의 전체 경로
			listMap.put("user_id", user_id);//user_id
			listMap.put("file_num", file_num);//file_num //좀더 처리해야할것이 남아있음 첨부 파일의 순서


			//위의 7가지 정보를 저장한 Map 을 ArrayList에 저장한다.
			list.add(listMap);
		}
	}
	return list;
}
	
	public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

}
