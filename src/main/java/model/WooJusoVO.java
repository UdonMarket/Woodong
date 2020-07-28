package model;

public class WooJusoVO {
	private String juso;
	private String latitude;
	private String longitude;
	public WooJusoVO(String juso, String latitude, String longitude) {
		super();
		this.juso = juso;
		this.latitude = latitude;
		this.longitude = longitude;
	}
	
	public WooJusoVO() {
		
	}

	public String getJuso() {
		return juso;
	}

	public void setJuso(String juso) {
		this.juso = juso;
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

	
}
