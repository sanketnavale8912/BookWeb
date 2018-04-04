package com.drysign.model;

public class DocumentWrapper {

	private ClientAuth clientAuth;
	private Document document;
	private SigningDetails signingDetails;

	public ClientAuth getClientAuth() {
		return clientAuth;
	}

	public void setClientAuth(ClientAuth clientAuth) {
		this.clientAuth = clientAuth;
	}

	public Document getDocument() {
		return document;
	}

	public void setDocument(Document document) {
		this.document = document;
	}


	public SigningDetails getSigningDetails() {
		return signingDetails;
	}

	public void setSigningDetails(SigningDetails signingDetails) {
		this.signingDetails = signingDetails;
	}

}
