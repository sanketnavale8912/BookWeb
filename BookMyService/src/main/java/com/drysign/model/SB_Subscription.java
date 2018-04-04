package com.drysign.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class SB_Subscription implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	
	private int id;
	private int userId;
	private int planId;
	private int creditedDocuments;
	private int usedDocuments;
	private Timestamp subscriptionStartTime;
	private Timestamp subscriptionEndTime;
	private int status;
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
	public int getPlanId() {
		return planId;
	}
	public void setPlanId(int planId) {
		this.planId = planId;
	}
	public int getCreditedDocuments() {
		return creditedDocuments;
	}
	public void setCreditedDocuments(int creditedDocuments) {
		this.creditedDocuments = creditedDocuments;
	}
	public int getUsedDocuments() {
		return usedDocuments;
	}
	public void setUsedDocuments(int usedDocuments) {
		this.usedDocuments = usedDocuments;
	}
	public Timestamp getSubscriptionStartTime() {
		return subscriptionStartTime;
	}
	public void setSubscriptionStartTime(Timestamp subscriptionStartTime) {
		this.subscriptionStartTime = subscriptionStartTime;
	}
	public Timestamp getSubscriptionEndTime() {
		return subscriptionEndTime;
	}
	public void setSubscriptionEndTime(Timestamp subscriptionEndTime) {
		this.subscriptionEndTime = subscriptionEndTime;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "SB_Subscription [id=" + id + ", userId=" + userId + ", planId=" + planId + ", creditedDocuments="
				+ creditedDocuments + ", usedDocuments=" + usedDocuments + ", subscriptionStartTime="
				+ subscriptionStartTime + ", subscriptionEndTime=" + subscriptionEndTime + ", status=" + status + "]";
	}
	
	
}
