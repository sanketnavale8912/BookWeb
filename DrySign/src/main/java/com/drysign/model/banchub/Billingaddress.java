package com.drysign.model.banchub;

public class Billingaddress {

	private String billing_username;
	private String user_zip;
	private String user_city;
	private String user_state;
	private String user_address1;
	private String user_address2;
	public String getBilling_username() {
		return billing_username;
	}
	public void setBilling_username(String billing_username) {
		this.billing_username = billing_username;
	}
	public String getUser_zip() {
		return user_zip;
	}
	public void setUser_zip(String user_zip) {
		this.user_zip = user_zip;
	}
	public String getUser_city() {
		return user_city;
	}
	public void setUser_city(String user_city) {
		this.user_city = user_city;
	}
	public String getUser_state() {
		return user_state;
	}
	public void setUser_state(String user_state) {
		this.user_state = user_state;
	}
	public String getUser_address1() {
		return user_address1;
	}
	public void setUser_address1(String user_address1) {
		this.user_address1 = user_address1;
	}
	public String getUser_address2() {
		return user_address2;
	}
	public void setUser_address2(String user_address2) {
		this.user_address2 = user_address2;
	}
	@Override
	public String toString() {
		return "Billingaddress [billing_username=" + billing_username + ", user_zip=" + user_zip + ", user_city="
				+ user_city + ", user_state=" + user_state + ", user_address1=" + user_address1 + ", user_address2="
				+ user_address2 + "]";
	}
	
	
	
}
