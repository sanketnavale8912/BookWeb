package com.drysign.model;

public class BackgroundSignDocumentResponse {

	private String documentName;
	private String envelopeId;
	private String viewDocumentUrl;
	private String message;
	public String getDocumentName() {
		return documentName;
	}
	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}
	public String getEnvelopeId() {
		return envelopeId;
	}
	public void setEnvelopeId(String envelopeId) {
		this.envelopeId = envelopeId;
	}
	public String getViewDocumentUrl() {
		return viewDocumentUrl;
	}
	public void setViewDocumentUrl(String viewDocumentUrl) {
		this.viewDocumentUrl = viewDocumentUrl;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "BackgroundSignDocumentResponse [documentName=" + documentName + ", envelopeId=" + envelopeId
				+ ", viewDocumentUrl=" + viewDocumentUrl + ", message=" + message + "]";
	}
	
	
	
	
}
