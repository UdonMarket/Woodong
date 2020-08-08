package model;

import java.sql.Date;

public class WooAndroidVO {
	private String pushsms_idx; //위치 저장 idx
	private String user_id;  //로그인한 사용자 ID
	private String latitude; //사용자 위도
	private String longitude; //사용자 경도
	private Date pushlocationDate; //위치 저장 날짜
	
	public String getPushsms_idx() {
		return pushsms_idx;
	}
	public void setPushsms_idx(String pushsms_idx) {
		this.pushsms_idx = pushsms_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public Date getPushlocationDate() {
		return pushlocationDate;
	}
	public void setPushlocationDate(Date pushlocationDate) {
		this.pushlocationDate = pushlocationDate;
	}
	
	
}
