package com.drysign.model;

import java.io.InputStream;

public class ApplicationDocument {

	int id;
	int userId;
	String envelopeId;
	String fileName;
	String originalId;
	String electronicId;
	String digitalld;
	InputStream original;
	InputStream electronic;
	InputStream digital;
	
	int status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
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
	public InputStream getOriginal() {
		return original;
	}
	public void setOriginal(InputStream original) {
		this.original = original;
	}
	public InputStream getElectronic() {
		return electronic;
	}
	public void setElectronic(InputStream electronic) {
		this.electronic = electronic;
	}
	public InputStream getDigital() {
		return digital;
	}
	public void setDigital(InputStream digital) {
		this.digital = digital;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getOriginalId() {
		return originalId;
	}
	public void setOriginalId(String originalId) {
		this.originalId = originalId;
	}
	public String getElectronicId() {
		return electronicId;
	}
	public void setElectronicId(String electronicId) {
		this.electronicId = electronicId;
	}
	public String getDigitalld() {
		return digitalld;
	}
	public void setDigitalld(String digitalld) {
		this.digitalld = digitalld;
	}
	
	@Override
	public String toString() {
		return "ApplicationDocument [id=" + id + ", userId=" + userId + ", envelopeId=" + envelopeId + ", fileName="
				+ fileName + ", originalId=" + originalId + ", electronicId=" + electronicId + ", digitalld="
				+ digitalld + ", original=" + original + ", electronic=" + electronic + ", digital=" + digital
				+ ", status=" + status + "]";
	}
	
	
	
	
	
	
	
}
