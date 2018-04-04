package com.drysign.model;

import java.sql.Timestamp;
import java.util.List;

public class Document {

	private int id;
	private int clientId;
	private int userId;
	private String documentName;
	private String documentOriginalName;
	private int status;
	private Timestamp createdOn;
	private Timestamp updatedOn;
	private List<DocumentField> documentFields;
	private String subject;
	private String message;
	private String signType; //self or group sign

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getDocumentName() {
		return documentName;
	}

	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}

	public String getDocumentOriginalName() {
		return documentOriginalName;
	}

	public void setDocumentOriginalName(String documentOriginalName) {
		this.documentOriginalName = documentOriginalName;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Timestamp getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(Timestamp updatedOn) {
		this.updatedOn = updatedOn;
	}

	public List<DocumentField> getDocumentFields() {
		return documentFields;
	}

	public void setDocumentFields(List<DocumentField> documentFields) {
		this.documentFields = documentFields;
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

	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
	}

	
}
