package com.drysign.model;



public class JsonDocumentData {
	private int docId;
	private String requestedBy;
	private String requestedEmail;
	private String signerId;
	private String signerEmailId;
	private String signedUser;
	private String signerStatus;
	private String signerName;
	private String signerEmail;
	private String documentName;
	private String subject;
	private String message;
	private String completedDate  ;
	private String status;
	private String uploadDate  ;
	private String priority;
	private String emailCount;
	private String signType;
	private String envelopeId; 
	
	
	public String getRequestedBy() {
		return requestedBy;
	}
	public void setRequestedBy(String requestedBy) {
		this.requestedBy = requestedBy;
	}
	public String getSignedUser() {
		return signedUser;
	}
	public void setSignedUser(String signedUser) {
		this.signedUser = signedUser;
	}
	public String getDocumentName() {
		return documentName;
	}
	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public int getDocId() {
		return docId;
	}
	public void setDocId(int docId) {
		this.docId = docId;
	}
	public String getCompletedDate() {
		return completedDate;
	}
	public void setCompletedDate(String completedDate) {
		this.completedDate = completedDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}
	public String getRequestedEmail() {
		return requestedEmail;
	}
	public void setRequestedEmail(String requestedEmail) {
		this.requestedEmail = requestedEmail;
	}
	public String getSignerStatus() {
		return signerStatus;
	}
	public void setSignerStatus(String signerStatus) {
		this.signerStatus = signerStatus;
	}
	public String getSignerName() {
		return signerName;
	}
	public void setSignerName(String signerName) {
		this.signerName = signerName;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getEmailCount() {
		return emailCount;
	}
	public void setEmailCount(String emailCount) {
		this.emailCount = emailCount;
	}
	public String getSignType() {
		return signType;
	}
	public void setSignType(String signType) {
		this.signType = signType;
	}
	public String getSignerEmail() {
		return signerEmail;
	}
	public void setSignerEmail(String signerEmail) {
		this.signerEmail = signerEmail;
	}
	public String getSignerEmailId() {
		return signerEmailId;
	}
	public void setSignerEmailId(String signerEmailId) {
		this.signerEmailId = signerEmailId;
	}
	public String getEnvelopeId() {
		return envelopeId;
	}
	public void setEnvelopeId(String envelopeId) {
		this.envelopeId = envelopeId;
	}
	public String getSignerId() {
		return signerId;
	}
	public void setSignerId(String signerId) {
		this.signerId = signerId;
	}
	
	
	

}
