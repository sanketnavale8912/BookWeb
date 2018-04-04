package com.drysign.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class SB_Purchase implements Serializable {


	private static final long serialVersionUID = 1L;

	private int id;
	private int subscriptionId;
	private String  planToken;
	private String planName;
	private String tagline;
	private String description;
	private String features;
	private String users;
	private String documents;
	private String price;
	private String currency;
	private String durationname;
	private String durationtime;
	private String durationunit;
	private String paymentMethod;
	private String paymentMethodResponse;
	private int status;
	private Timestamp date;
	private SB_Subscription subscription;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSubscriptionId() {
		return subscriptionId;
	}
	public void setSubscriptionId(int subscriptionId) {
		this.subscriptionId = subscriptionId;
	}
	public String getPlanToken() {
		return planToken;
	}
	public void setPlanToken(String planToken) {
		this.planToken = planToken;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getTagline() {
		return tagline;
	}
	public void setTagline(String tagline) {
		this.tagline = tagline;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getFeatures() {
		return features;
	}
	public void setFeatures(String features) {
		this.features = features;
	}
	public String getUsers() {
		return users;
	}
	public void setUsers(String users) {
		this.users = users;
	}
	public String getDocuments() {
		return documents;
	}
	public void setDocuments(String documents) {
		this.documents = documents;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getDurationname() {
		return durationname;
	}
	public void setDurationname(String durationname) {
		this.durationname = durationname;
	}
	public String getDurationtime() {
		return durationtime;
	}
	public void setDurationtime(String durationtime) {
		this.durationtime = durationtime;
	}
	public String getDurationunit() {
		return durationunit;
	}
	public void setDurationunit(String durationunit) {
		this.durationunit = durationunit;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public String getPaymentMethodResponse() {
		return paymentMethodResponse;
	}
	public void setPaymentMethodResponse(String paymentMethodResponse) {
		this.paymentMethodResponse = paymentMethodResponse;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public SB_Subscription getSubscription() {
		return subscription;
	}
	public void setSubscription(SB_Subscription subscription) {
		this.subscription = subscription;
	}
	@Override
	public String toString() {
		return "SB_Purchase [id=" + id + ", subscriptionId=" + subscriptionId + ", planToken=" + planToken
				+ ", planName=" + planName + ", tagline=" + tagline + ", description=" + description + ", features="
				+ features + ", users=" + users + ", documents=" + documents + ", price=" + price + ", currency="
				+ currency + ", durationname=" + durationname + ", durationtime=" + durationtime + ", durationunit="
				+ durationunit + ", paymentMethod=" + paymentMethod + ", paymentMethodResponse=" + paymentMethodResponse
				+ ", status=" + status + ", date=" + date + ", subscription=" + subscription + "]";
	}
	
	
}
