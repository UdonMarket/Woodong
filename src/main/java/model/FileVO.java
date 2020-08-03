package model;

public class FileVO {
	
	// 테이블 컬럼
	private String fileidx;//파일 idx
	private String boardidx;//보드 idx
	private String original_name;//원본 파일명
	private String save_name;//저장되는 파일명
	private String del_yn;//삭제여부
	private String file_cre;//첨부파일 생성일
	private String threedimage;//3d이미지 저장명
	
	// 기타
	
	
	public String getFileidx() {
		return fileidx;
	}
	public String getThreedimage() {
		return threedimage;
	}
	public void setThreedimage(String threedimage) {
		this.threedimage = threedimage;
	}
	public void setFileidx(String fileidx) {
		this.fileidx = fileidx;
	}
	public String getBoardidx() {
		return boardidx;
	}
	public void setBoardidx(String boardidx) {
		this.boardidx = boardidx;
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
	@Override
	public String toString() {
		return "FileVO [threedimage=" + threedimage + "]";
	}
	
	
	
	
}
