package com.drysign.model;

import java.sql.Timestamp;

public class SB_Offer {

	private int id;
	
	private String name;
	
	private String offerCode;
	
	private String discountInPercentage;
	
	private Timestamp startDate;
	
	private Timestamp endDate;
	
	private String status;
	
	private Timestamp createdDate;
	private Timestamp updatedDate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOfferCode() {
		return offerCode;
	}

	public void setOfferCode(String offerCode) {
		this.offerCode = offerCode;
	}

	public String getDiscountInPercentage() {
		return discountInPercentage;
	}

	public void setDiscountInPercentage(String discountInPercentage) {
		this.discountInPercentage = discountInPercentage;
	}

	public Timestamp getStartDate() {
		return startDate;
	}

	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}

	public Timestamp getEndDate() {
		return endDate;
	}

	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
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
		return "Offer [id=" + id + ", name=" + name + ", offerCode=" + offerCode + ", discountInPercentage="
				+ discountInPercentage + ", startDate=" + startDate + ", endDate=" + endDate + ", status=" + status
				+ ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + "]";
	}

	
		
	
	
	
	
}
