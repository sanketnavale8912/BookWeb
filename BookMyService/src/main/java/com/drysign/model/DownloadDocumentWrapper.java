package com.drysign.model;

public class DownloadDocumentWrapper 
{
	private String base64String;
	private String message;
	public String getBase64String() {
		return base64String;
	}
	public void setBase64String(String base64String) {
		this.base64String = base64String;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "DownloadDocumentWrapper [base64String=" + base64String + ", message=" + message + "]";
	}
	
	
	
}
