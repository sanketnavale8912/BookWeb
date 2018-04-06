package com.drysign.model;

import java.sql.Timestamp;
public class SB_Plan {

	private int id;
	
	private String name;
	
	private String token;
	
	private String price;
	
	private String planIcon;
	
	private String tagLine;
	
	private String description;
	
	private String noOfUsers;
	
	private String noOfDocuments;
	
	private String features;
	
	private String status;
	
    private Timestamp createdDate;
  
    private Timestamp updatedDate ;

	private SB_Category category;

    private Registration user;

	private SB_Duration duration;
	
	private SB_Currency currency;

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

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getPlanIcon() {
		return planIcon;
	}

	public void setPlanIcon(String planIcon) {
		this.planIcon = planIcon;
	}

	public String getTagLine() {
		return tagLine;
	}

	public void setTagLine(String tagLine) {
		this.tagLine = tagLine;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getNoOfUsers() {
		return noOfUsers;
	}

	public void setNoOfUsers(String noOfUsers) {
		this.noOfUsers = noOfUsers;
	}

	public String getNoOfDocuments() {
		return noOfDocuments;
	}

	public void setNoOfDocuments(String noOfDocuments) {
		this.noOfDocuments = noOfDocuments;
	}

	public String getFeatures() {
		return features;
	}

	public void setFeatures(String features) {
		this.features = features;
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

	public SB_Category getCategory() {
		return category;
	}

	public void setCategory(SB_Category category) {
		this.category = category;
	}

	public Registration getUser() {
		return user;
	}

	public void setUser(Registration user) {
		this.user = user;
	}

	public SB_Duration getDuration() {
		return duration;
	}

	public void setDuration(SB_Duration duration) {
		this.duration = duration;
	}

	public SB_Currency getCurrency() {
		return currency;
	}

	public void setCurrency(SB_Currency currency) {
		this.currency = currency;
	}

	@Override
	public String toString() {
		return "SB_Plan [id=" + id + ", name=" + name + ", token=" + token + ", price=" + price + ", planIcon="
				+ planIcon + ", tagLine=" + tagLine + ", description=" + description + ", noOfUsers=" + noOfUsers
				+ ", noOfDocuments=" + noOfDocuments + ", features=" + features + ", status=" + status
				+ ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", category=" + category + ", user="
				+ user + ", duration=" + duration + ", currency=" + currency + "]";
	}

	
	
	    
	
		
}
