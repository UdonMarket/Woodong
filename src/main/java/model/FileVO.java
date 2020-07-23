package model;

public class FileVO {
	
	private String woo_file_idx;//파일 idx
	private String woo_board_idx;//보드 idx
	private String file_num;//파일
	private String original_name;//원본 파일명
	private String save_name;//저장되는 파일명
	private String user_id;//첨부파일 작성자
	private String del_yn;//삭제여부
	private String file_cre;//첨부파일 생성일
	
	
	public String getWoo_file_idx() {
		return woo_file_idx;
	}
	public void setWoo_file_idx(String woo_file_idx) {
		this.woo_file_idx = woo_file_idx;
	}
	public String getWoo_board_idx() {
		return woo_board_idx;
	}
	public void setWoo_board_idx(String woo_board_idx) {
		this.woo_board_idx = woo_board_idx;
	}
	public String getFile_num() {
		return file_num;
	}
	public void setFile_num(String file_num) {
		this.file_num = file_num;
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
