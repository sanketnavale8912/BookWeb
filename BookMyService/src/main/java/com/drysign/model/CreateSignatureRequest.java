package com.drysign.model;

import java.sql.Timestamp;

public class CreateSignatureRequest {

	private int id;
	private String firstname;
	private String lastname;
	private String email;
	private String signature;
	private int status;
	private String token;
	private String message;
	private Timestamp created_date;
	private Timestamp updated_date;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
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
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Timestamp getCreated_date() {
		return created_date;
	}
	public void setCreated_date(Timestamp created_date) {
		this.created_date = created_date;
	}
	public Timestamp getUpdated_date() {
		return updated_date;
	}
	public void setUpdated_date(Timestamp updated_date) {
		this.updated_date = updated_date;
	}
	@Override
	public String toString() {
		return "CreateSignatureRequest [id=" + id + ", firstname=" + firstname + ", lastname=" + lastname + ", email="
				+ email + ", signature=" + signature + ", status=" + status + ", token=" + token + ", message="
				+ message + ", created_date=" + created_date + ", updated_date=" + updated_date + "]";
	}
	
		
}
