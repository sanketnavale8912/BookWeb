package com.drysign.model;

import java.sql.Timestamp;

public class SigningDetails {

	private int id;
	private int clientId;
	private int originatorId;
	private int signerId;
	private int documentId;
	private int signingOrder;
	private int status;
	private String token;
	private Timestamp cratedOn;
	private Timestamp updatedOn;
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
	public int getOriginatorId() {
		return originatorId;
	}
	public void setOriginatorId(int originatorId) {
		this.originatorId = originatorId;
	}
	public int getSignerId() {
		return signerId;
	}
	public void setSignerId(int signerId) {
		this.signerId = signerId;
	}
	public int getDocumentId() {
		return documentId;
	}
	public void setDocumentId(int documentId) {
		this.documentId = documentId;
	}
	public int getSigningOrder() {
		return signingOrder;
	}
	public void setSigningOrder(int signingOrder) {
		this.signingOrder = signingOrder;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public Timestamp getCratedOn() {
		return cratedOn;
	}
	public void setCratedOn(Timestamp cratedOn) {
		this.cratedOn = cratedOn;
	}
	public Timestamp getUpdatedOn() {
		return updatedOn;
	}
	public void setUpdatedOn(Timestamp updatedOn) {
		this.updatedOn = updatedOn;
	}
	
	
	
	
	
	
}
