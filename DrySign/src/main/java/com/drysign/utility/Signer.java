package com.drysign.utility;

public class Signer {
	private int signerId;
	private int userId;
	private int priority;
	private String signerName;
	private int signStatus;
	private String signerEmail;
	private String signerUrl;
	private int docId;
	public Signer(){
		
	}
	public Signer(int priority,String signerName, String signerEmail) {
		this.priority = priority;
		this.signerName = signerName;
		this.signerEmail = signerEmail;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getSignerName() {
		return signerName;
	}
	public void setSignerName(String signerName) {
		this.signerName = signerName;
	}
	public String getSignerEmail() {
		return signerEmail;
	}
	public void setSignerEmail(String signerEmail) {
		this.signerEmail = signerEmail;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getSignerId() {
		return signerId;
	}
	public void setSignerId(int signerId) {
		this.signerId = signerId;
	}
	public String getSignerUrl() {
		return signerUrl;
	}
	public void setSignerUrl(String signerUrl) {
		this.signerUrl = signerUrl;
	}
	public int getSignStatus() {
		return signStatus;
	}
	public void setSignStatus(int signStatus) {
		this.signStatus = signStatus;
	}
	public int getDocId() {
		return docId;
	}
	public void setDocId(int docId) {
		this.docId = docId;
	}
	
	
}
