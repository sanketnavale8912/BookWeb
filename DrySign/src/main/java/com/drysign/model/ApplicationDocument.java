package com.drysign.model;

import java.io.InputStream;
import java.sql.Timestamp;

public class ApplicationDocument {

	int id;
	int userId;
	String envelopeId;
	String fileName;
	InputStream original;
	InputStream electronic;
	InputStream digital;
	String originalId;
	String electronicId;
	String digitalld;
	String docStatus;
	String signType;
	int status;
	String dataURL;
	Timestamp updatedOn;
	Timestamp completedOn;
	String subject;
	String message;
	String cc;
	String docUrl;
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
	
	public String getDocStatus() {
		return docStatus;
	}
	public void setDocStatus(String docStatus) {
		this.docStatus = docStatus;
	}
	public Timestamp getUpdatedOn() {
		return updatedOn;
	}
	public void setUpdatedOn(Timestamp updatedOn) {
		this.updatedOn = updatedOn;
	}
	public String getSignType() {
		return signType;
	}
	public void setSignType(String signType) {
		this.signType = signType;
	}
	public String getDataURL() {
		return dataURL;
	}
	public void setDataURL(String dataURL) {
		this.dataURL = dataURL;
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
	public String getCc() {
		return cc;
	}
	public void setCc(String cc) {
		this.cc = cc;
	}
	public String getDocUrl() {
		return docUrl;
	}
	public void setDocUrl(String docUrl) {
		this.docUrl = docUrl;
	}
	
	public Timestamp getCompletedOn() {
		return completedOn;
	}
	public void setCompletedOn(Timestamp completedOn) {
		this.completedOn = completedOn;
	}
	@Override
	public String toString() {
		return "ApplicationDocument [id=" + id + ", userId=" + userId
				+ ", envelopeId=" + envelopeId + ", fileName=" + fileName
				+ ", original=" + original + ", electronic=" + electronic
				+ ", digital=" + digital + ", status=" + status + "]";
	}
	
	
	
	
	
	
}
