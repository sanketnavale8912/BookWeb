package com.drysign.model;

public class VerifyDetails {

	private int id;
	private String fileName;
	private String Originator;
	private String Signer;
	private String token;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOriginator() {
		return Originator;
	}
	public void setOriginator(String originator) {
		Originator = originator;
	}
	public String getSigner() {
		return Signer;
	}
	public void setSigner(String signer) {
		Signer = signer;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	
	
}
