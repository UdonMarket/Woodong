package model;

public class FileVO {
	
	private String idx;//파일 idx
	private String file_num;//파일
	private String board_num;//보드 idx
	private String original_name;//원본 파일명
	private String save_name;//저장되는 파일명
	private String file_path;//서버의 물리적 경로
	private String file_size;//파일 크기
	private String user_id;//첨부파일 작성자
	private String del_yn;//삭제여부
	private String file_cre;//첨부파일 생성일
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getFile_num() {
		return file_num;
	}
	public void setFile_num(String file_num) {
		this.file_num = file_num;
	}
	public String getBoard_num() {
		return board_num;
	}
	public void setBoard_num(String board_num) {
		this.board_num = board_num;
	}
	public String getOriginal_name() {
		return original_name;
	}
	public void setOriginal_name(String original_name) {
		this.original_name = original_name;
	}
	public String getSave_name() {
		return save_name;
	}
	public void setSave_name(String save_name) {
		this.save_name = save_name;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_size() {
		return file_size;
	}
	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getFile_cre() {
		return file_cre;
	}
	public void setFile_cre(String file_cre) {
		this.file_cre = file_cre;
	}
	
	
	
	
}
