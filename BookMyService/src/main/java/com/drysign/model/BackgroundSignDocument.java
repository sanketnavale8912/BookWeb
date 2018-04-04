package com.drysign.model;

import java.util.List;

public class BackgroundSignDocument 
{
	private int id;
	private String documentName;
	private String fileBase64String;
	private String originatorEmail;
	private String subject;
	private String message;
	private String clientIPAddress;
	private String event;
	private String createdOn;
	private String updatedOn;
	private List<BackgroundSignFields> documentFields;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDocumentName() {
		return documentName;
	}
	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}
	public String getFileBase64String() {
		return fileBase64String;
	}
	public void setFileBase64String(String fileBase64String) {
		this.fileBase64String = fileBase64String;
	}
	public String getOriginatorEmail() {
		return originatorEmail;
	}
	public void setOriginatorEmail(String originatorEmail) {
		this.originatorEmail = originatorEmail;
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
	public String getClientIPAddress() {
		return clientIPAddress;
	}
	public void setClientIPAddress(String clientIPAddress) {
		this.clientIPAddress = clientIPAddress;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public String getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}
	public String getUpdatedOn() {
		return updatedOn;
	}
	public void setUpdatedOn(String updatedOn) {
		this.updatedOn = updatedOn;
	}
	public List<BackgroundSignFields> getDocumentFields() {
		return documentFields;
	}
	public void setDocumentFields(List<BackgroundSignFields> documentFields) {
		this.documentFields = documentFields;
	}
	@Override
	public String toString() {
		return "BackgroundSignDocument [id=" + id + ", documentName=" + documentName + ", fileBase64String="
				+ fileBase64String + ", originatorEmail=" + originatorEmail + ", subject=" + subject + ", message="
				+ message + ", clientIPAddress=" + clientIPAddress + ", event=" + event + ", createdOn=" + createdOn
				+ ", updatedOn=" + updatedOn + ", documentFields=" + documentFields + "]";
	}
	
	
}
