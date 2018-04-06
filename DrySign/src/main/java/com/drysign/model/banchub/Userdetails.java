package com.drysign.model.banchub;

public class Userdetails {

	private String apikey;
	private String username;
	public String getApikey() {
		return apikey;
	}
	public void setApikey(String apikey) {
		this.apikey = apikey;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	@Override
	public String toString() {
		return "Userdetails [apikey=" + apikey + ", username=" + username + "]";
	}
	
	
	
}
