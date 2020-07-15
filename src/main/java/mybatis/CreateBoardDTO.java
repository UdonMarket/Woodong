package mybatis;

public class CreateBoardDTO {
	private String bname;
	private String blocation;
	private String requestname;
	private String border;

	public String getBname() {
		return this.bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getBlocation() {
		return this.blocation;
	}

	public void setBlocation(String blocation) {
		this.blocation = blocation;
	}

	public String getRequestname() {
		return this.requestname;
	}

	public void setRequestname(String requestname) {
		this.requestname = requestname;
	}

	public String getBorder() {
		return this.border;
	}

	public void setBorder(String border) {
		this.border = border;
	}
}