package com.drysign.model;

public class Download {

	private String envelopeId;
	private String fileName;
	private String status;
	public String getEnvelopeId() {
		return envelopeId;
	}
	public void setEnvelopeId(String envelopeId) {
		this.envelopeId = envelopeId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "Download [envelopeId=" + envelopeId + ", fileName=" + fileName + ", status=" + status + "]";
	}
	
	
	
}
