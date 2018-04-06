package com.drysign.model;

import java.sql.Timestamp;

public class SB_Currency {

	private int currency_id;
	private String name;
	private int status;
	private Timestamp createdDate;
	private Timestamp updatedDate;

	public int getCurrency_id() {
		return currency_id;
	}

	public void setCurrency_id(int currency_id) {
		this.currency_id = currency_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public Timestamp getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}

	@Override
	public String toString() {
		return "Currency [currency_id=" + currency_id + ", name=" + name + ", status=" + status + ", createdDate="
				+ createdDate + ", updatedDate=" + updatedDate + "]";
	}

		
	
	
}
