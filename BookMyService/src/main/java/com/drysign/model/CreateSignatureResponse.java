package com.drysign.model;

public class CreateSignatureResponse {

	private String email;
	private String createSignatureUrl;
	private String message;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCreateSignatureUrl() {
		return createSignatureUrl;
	}
	public void setCreateSignatureUrl(String createSignatureUrl) {
		this.createSignatureUrl = createSignatureUrl;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "CreateSignatureResponse [email=" + email + ", createSignatureUrl=" + createSignatureUrl + ", message="
				+ message + "]";
	}
	
	
}
