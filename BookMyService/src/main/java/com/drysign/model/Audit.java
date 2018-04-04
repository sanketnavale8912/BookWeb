package com.drysign.model;

import java.sql.Timestamp;

public class Audit {
	
	private String webRequest;
	private String webResponse;
	private String responseStatus;
	private	String ipAddress;
	private String email;
	private int userId;
	private Timestamp createdOn;
	private String methodName;
	
	public String getWebRequest() {
		return webRequest;
	}
	public void setWebRequest(String webRequest) {
		this.webRequest = webRequest;
	}
	public String getWebResponse() {
		return webResponse;
	}
	public void setWebResponse(String webResponse) {
		this.webResponse = webResponse;
	}
	public String getResponseStatus() {
		return responseStatus;
	}
	public void setResponseStatus(String responseStatus) {
		this.responseStatus = responseStatus;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Timestamp getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}
	public String getMethodName() {
		return methodName;
	}
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	
	
}
