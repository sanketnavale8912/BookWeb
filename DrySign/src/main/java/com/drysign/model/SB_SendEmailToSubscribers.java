package com.drysign.model;

public class SB_SendEmailToSubscribers {

	private String firstName;
	private String lastName;
	private String email;
	private String planName;
	private String endTime;
	private String volumeInPercent;
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getVolumeInPercent() {
		return volumeInPercent;
	}
	public void setVolumeInPercent(String volumeInPercent) {
		this.volumeInPercent = volumeInPercent;
	}
	@Override
	public String toString() {
		return "SB_SendEmailToSubscribers [firstName=" + firstName + ", lastName=" + lastName + ", email=" + email
				+ ", planName=" + planName + ", endTime=" + endTime + ", volumeInPercent=" + volumeInPercent + "]";
	}
	
	
	
	
}
