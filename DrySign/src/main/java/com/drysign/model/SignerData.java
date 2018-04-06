package com.drysign.model;

public class SignerData {

	private int docId;
	private int signerId;
	private String signType;
	private int signStatus;
	private int requestBy;
	private String signerEmail;
	private String signerName;
	private int priority;
	private String requestName;
	private String requestEmail;
	private String projectName;
	private String docStatus;
	public int getDocId() {
		return docId;
	}
	public void setDocId(int docId) {
		this.docId = docId;
	}
	public String getSignType() {
		return signType;
	}
	public void setSignType(String signType) {
		this.signType = signType;
	}
	public int getSignStatus() {
		return signStatus;
	}
	public void setSignStatus(int signStatus) {
		this.signStatus = signStatus;
	}
	public int getRequestBy() {
		return requestBy;
	}
	public void setRequestBy(int requestBy) {
		this.requestBy = requestBy;
	}
	public String getSignerEmail() {
		return signerEmail;
	}
	public void setSignerEmail(String signerEmail) {
		this.signerEmail = signerEmail;
	}
	public int getSignerId() {
		return signerId;
	}
	public void setSignerId(int signerId) {
		this.signerId = signerId;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getRequestName() {
		return requestName;
	}
	public void setRequestName(String requestName) {
		this.requestName = requestName;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getSignerName() {
		return signerName;
	}
	public void setSignerName(String signerName) {
		this.signerName = signerName;
	}
	public String getRequestEmail() {
		return requestEmail;
	}
	public void setRequestEmail(String requestEmail) {
		this.requestEmail = requestEmail;
	}
	public String getDocStatus() {
		return docStatus;
	}
	public void setDocStatus(String docStatus) {
		this.docStatus = docStatus;
	}
	
	
}
