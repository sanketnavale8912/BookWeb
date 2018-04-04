package com.drysign.model;

import java.util.List;

public class DocumentSignerWrapper {

	private List<DocumentSigner> documentSigner;
	private String message;
	public List<DocumentSigner> getDocumentSigner() {
		return documentSigner;
	}
	public void setDocumentSigner(List<DocumentSigner> documentSigner) {
		this.documentSigner = documentSigner;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "DocumentSignerWrapper [documentSigner=" + documentSigner + ", message=" + message + "]";
	}
	
	
}
