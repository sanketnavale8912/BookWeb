package com.drysign.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Set;


public class SB_Category implements Serializable{


	private static final long serialVersionUID = 5457853821368315370L;


	private int category_id;
		
	private String name;

	private String description;
	
	private String photo;
	
	private int status;
	
    private Timestamp createdDate;

    private Timestamp updatedDate ;

	private SB_Registration user;
    
    private Set<SB_Plan> plan;

	public int getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
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

	public SB_Registration getUser() {
		return user;
	}

	public void setUser(SB_Registration user) {
		this.user = user;
	}

	public Set<SB_Plan> getPlan() {
		return plan;
	}

	public void setPlan(Set<SB_Plan> plan) {
		this.plan = plan;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "SB_Category [category_id=" + category_id + ", name=" + name + ", description=" + description
				+ ", photo=" + photo + ", status=" + status + ", createdDate=" + createdDate + ", updatedDate="
				+ updatedDate + ", user=" + user + ", plan=" + plan + "]";
	}


	
}
