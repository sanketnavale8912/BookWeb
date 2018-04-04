package com.drysign.model;

public class DocumentSigner {

	private String signerName;
	private String signerEmail;
	private String signerStatus;
	private String signDocumentUrl;

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
	public String getSignerStatus() {
		return signerStatus;
	}
	public void setSignerStatus(String signerStatus) {
		this.signerStatus = signerStatus;
	}
	public String getSignDocumentUrl() {
		return signDocumentUrl;
	}
	public void setSignDocumentUrl(String signDocumentUrl) {
		this.signDocumentUrl = signDocumentUrl;
	}
	@Override
	public String toString() {
		return "DocumentSinger [signerName=" + signerName + ", signerEmail=" + signerEmail + ", signerStatus="
				+ signerStatus + ", signDocumentUrl=" + signDocumentUrl + "]";
	}

	
}
