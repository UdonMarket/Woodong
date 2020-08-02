package util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import model.WooBoardVO;

public class FileUtils {
	 
	//파일 insert : parseInsertFileInfo
	public static List<Map<String, Object>> parseInsertFileInfo(WooBoardVO wooBoardVO, MultipartHttpServletRequest req)throws Exception {
			
		String path = req.getSession().getServletContext().getRealPath("/resources/Upload");//파일이 저장될 경로 

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		
		String threeYN = wooBoardVO.getThree_dimens();//3d 이미지 이용 여부 판단 ('Y' or 'N')
		int boardidx = wooBoardVO.getSeq_woo_board();
		
		List<BufferedImage> bufferimage = new ArrayList<BufferedImage>();
		List<Image> imagelist = new ArrayList<Image>();

		// 합쳐질 이미지의 가로, 세로 사이즈 설정
		int width = 550 * 8;
		int height = 550;

		// 물리적 경로를 기반으로 File 객체를 생성한후
		File directory = new File(path);
		if (!directory.isDirectory()) {// 지정된 디렉토리가 존재하는지 확인한후
			directory.mkdirs();// 만약 없다면 생성함
		}
		List<MultipartFile> mf = wooBoardVO.getFile();// wooBoardVO 에 저장된 파일 불러오기
		
		if (mf.size() == 0 && "".equals(mf.get(0).getOriginalFilename())) {} // 파일이 없거나 이름이 없으면 for 문에 진입하지 못함
		else {
			for (int i = 0; i < mf.size(); i++) {// list 의 size 만큼 반복
				if (mf.get(i).getOriginalFilename().lastIndexOf(".") == -1) {// 파일없으면 for문 탈출(확장자 인덱스로 판단)
					break;
				}
				String original_name = mf.get(i).getOriginalFilename();// 원본파일명
				String fileExtension = original_name.substring(original_name.lastIndexOf("."));// 파일 확장자
				String save_name = getUuid() + fileExtension;	// 저장되는 파일명
				File serverFullName = new File(path + File.separator + save_name);// 파일이 저장되는 풀경로
				mf.get(i).transferTo(serverFullName);// 파일 업로드

				listMap = new HashMap<String, Object>();
				listMap.put("original_name", original_name);
				listMap.put("save_name", save_name);
				listMap.put("boardidx", boardidx);
				listMap.put("threeYN", threeYN);
				
				if (threeYN.equals("Y")) {//3d 이미지 이용 한다면
					bufferimage.add(i, ImageIO.read(new File(path + File.separator + save_name)));//이미지 IO 를 아용하여 이미지 업로드
					imagelist.add(i, bufferimage.get(i).getScaledInstance(550, 550, Image.SCALE_SMOOTH));//이미지 리사이즈 ->가로 550px 세로 550px 
					listMap.put("threedimage", save_name);
				}
				else {
					listMap.put("threedimage", "N");
				}
				list.add(listMap);
			}
		}//end of else 문
		
		if (threeYN.equals("Y")) {//3d 이미지 이용 한다면
			try {// 8장의 이미지 파일 병합
				BufferedImage mergedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
				Graphics2D graphics = (Graphics2D) mergedImage.getGraphics();
	
				graphics.setBackground(Color.WHITE);
				for (int j = 0; j < 8; j++) {
					graphics.drawImage(imagelist.get(j), 550 * j, 0, null);
				}
				graphics.dispose();
				String threedimage = getUuid() + ".jpg";//파일테이블에 저장될 3D파일 이름
				ImageIO.write(mergedImage, "jpg", new File(path + File.separator + threedimage));//병합된 이미지의 확장자는 jpg 로 고정,저장될 경로 설정
				listMap.put("threedimage", threedimage);//map에 3D파일 이름 저장
				list.add(listMap);
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
		}
		
		/*
		 * if (threeYN.equals("Y")) { try {// 8장의 이미지 파일 병합 BufferedImage mergedImage =
		 * new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB); Graphics2D
		 * graphics = (Graphics2D) mergedImage.getGraphics();
		 * 
		 * graphics.setBackground(Color.WHITE); for (int i = 0; i < 8; i++) {
		 * graphics.drawImage(imagelist.get(i), 550 * i, 0, null); } graphics.dispose();
		 * String threedimage = getUuid() + ".jpg";//파일테이블에 저장될 3D파일 이름
		 * ImageIO.write(mergedImage, "jpg", new File(path + File.separator +
		 * threedimage));//병합된 이미지의 확장자는 jpg 로 고정,저장될 경로 설정 listMap.put("threedimage",
		 * threedimage);//map에 3D파일 이름 저장 } catch (IOException ioe) {
		 * ioe.printStackTrace(); } } else { listMap.put("threedimage", "N"); }
		 */
		
		return list;
	}
	
	//파일 update : parseUpdateFileInfo
	public static List<Map<String, Object>> parseUpdateFileInfo(WooBoardVO wooBoardVO,String[] files, String[] fileNames,
			MultipartHttpServletRequest req)throws Exception{
		String path = req.getSession().getServletContext().getRealPath("/resources/Upload");
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null;
		
		String user_id = wooBoardVO.getId();
		String  boardidx = wooBoardVO.getBoardidx();
		
		File directory = new File(path);
		if(!directory.isDirectory()) {
			directory.mkdirs();
		}
		//수정시 새로 등록한 파일이 있다면 파일 insert
		if (wooBoardVO.getFile()!=null && wooBoardVO.getFile().size()!=0){
			List<MultipartFile> mf = wooBoardVO.getFile();
			for(int i = 0; i < mf.size(); i++) {
				
				if(mf.get(i).getOriginalFilename().lastIndexOf(".")==-1) { break; }
				
				String original_name = mf.get(i).getOriginalFilename();
				String fileExtension = original_name.substring(original_name.lastIndexOf("."));
				String save_name = getUuid() + fileExtension;
				File serverFullName = new File (path +File.separator+ save_name);
				mf.get(i).transferTo(serverFullName);
				
				listMap = new HashMap<String, Object>();
				listMap.put("original_name", original_name);
				listMap.put("serverFullName", serverFullName);
				listMap.put("save_name", save_name);
				listMap.put("boardidx", boardidx);
				listMap.put("IS_NEW", "Y");
				
				list.add(listMap);
			}
		}
		//삭제한 파일은 del_yn 을 Y로 update 처리한다.
		if(files != null && fileNames != null){ 
			for(int i = 0; i<fileNames.length; i++) {
			listMap = new HashMap<String,Object>();
			listMap.put("IS_NEW", "N"); 
			listMap.put("fileidx", files[i]); 
			list.add(listMap); 
			}
		}
		return list;
	}
	//서버에 저장될 파일명 uuid 생성 
	public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

}
