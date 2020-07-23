package model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Listaaa {
	private String num;
	
	private List<MultipartFile> file;
	

	public List<MultipartFile> getFile() {
		return file;
	}

	public void setFile(List<MultipartFile> file) {
		this.file = file;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}
	
	
}
