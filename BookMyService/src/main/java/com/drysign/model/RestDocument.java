package com.drysign.model;

import java.sql.Timestamp;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class RestDocument {

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
	private String prepareReturnUrl;
	private String viewDocumentUrl;
	private Timestamp createdOn;
	private Timestamp updatedOn;
	private List<RestDocumentField> documentFields;
	
	private String subject;
	private String message;
	private String clientIPAddress;
	private String event;
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
	public String getPrepareReturnUrl() {
		return prepareReturnUrl;
	}
	public void setPrepareReturnUrl(String prepareReturnUrl) {
		this.prepareReturnUrl = prepareReturnUrl;
	}
	public String getViewDocumentUrl() {
		return viewDocumentUrl;
	}
	public void setViewDocumentUrl(String viewDocumentUrl) {
		this.viewDocumentUrl = viewDocumentUrl;
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
	public List<RestDocumentField> getDocumentFields() {
		return documentFields;
	}
	public void setDocumentFields(List<RestDocumentField> documentFields) {
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
	@Override
	public String toString() {
		return "RestDocument [id=" + id + ", envelopeId=" + envelopeId + ", documentName=" + documentName
				+ ", filePath=" + filePath + ", originatorEmail=" + originatorEmail + ", signerEmail=" + signerEmail
				+ ", signerName=" + signerName + ", status=" + status + ", url=" + url + ", returnUrl=" + returnUrl
				+ ", prepareReturnUrl=" + prepareReturnUrl + ", viewDocumentUrl=" + viewDocumentUrl + ", createdOn="
				+ createdOn + ", updatedOn=" + updatedOn + ", documentFields=" + documentFields + ", subject=" + subject
				+ ", message=" + message + ", clientIPAddress=" + clientIPAddress + ", event=" + event + "]";
	}
	
	

}
