package com.drysign.sdk.model;

import java.sql.Timestamp;
import java.util.List;

public class Document {

	private int id;

	private String envelopeId;
	private String documentName;
	private String filePath;
	
	private String originatorEmail;
	private String signerEmail;
	private String signerName;
	private String status;
	private String url;
	private String returnUrl;
	private Timestamp createdOn;
	private Timestamp updatedOn;
	private List<DocumentField> documentFields;
	
	private String subject;
	private String message;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEnvelopeId() {
		return envelopeId;
	}
	public void setEnvelopeId(String envelopeId) {
		this.envelopeId = envelopeId;
	}
	public String getDocumentName() {
		return documentName;
	}
	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getOriginatorEmail() {
		return originatorEmail;
	}
	public void setOriginatorEmail(String originatorEmail) {
		this.originatorEmail = originatorEmail;
	}
	public String getSignerEmail() {
		return signerEmail;
	}
	public void setSignerEmail(String signerEmail) {
		this.signerEmail = signerEmail;
	}
	public String getSignerName() {
		return signerName;
	}
	public void setSignerName(String signerName) {
		this.signerName = signerName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getReturnUrl() {
		return returnUrl;
	}
	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
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
	@Override
	public String toString() {
		return "Document [id=" + id + ", envelopeId=" + envelopeId
				+ ", documentName=" + documentName + ", filePath=" + filePath
				+ ", originatorEmail=" + originatorEmail + ", signerEmail="
				+ signerEmail + ", signerName=" + signerName + ", status="
				+ status + ", url=" + url + ", returnUrl=" + returnUrl
				+ ", createdOn=" + createdOn + ", updatedOn=" + updatedOn
				+ ", documentFields=" + documentFields + ", subject=" + subject
				+ ", message=" + message + "]";
	}
	
	
	

}
