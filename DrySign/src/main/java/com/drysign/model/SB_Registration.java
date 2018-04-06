package com.drysign.model;

import java.sql.Timestamp;
import java.util.Set;


public class SB_Registration 
{

	  private int id ;

	  private String firstName;

	  private String lastName;

	  private String photo;
	  

	  private String applicationname;

	  private String phone;

	  private String country;
	  
	  private String state;
	  
	  private String city;

	  private String address;

	  private String zipcode;

	  private String email;
	  
	  private String password;

	  private String confirmPassword;
	  
	  private String emailVerificationToken;

	  private String userType;

	  private String role;

	  private int status;
	  
	  private Timestamp createdDate;

	  private Timestamp updatedDate ;

	  private Set<SB_Category> category;

	  private Set<SB_Plan> plan;

	public int getId() {
		return id;
	}

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

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getApplicationname() {
		return applicationname;
	}

	public void setApplicationname(String applicationname) {
		this.applicationname = applicationname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public String getEmailVerificationToken() {
		return emailVerificationToken;
	}

	public void setEmailVerificationToken(String emailVerificationToken) {
		this.emailVerificationToken = emailVerificationToken;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
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

	public Set<SB_Category> getCategory() {
		return category;
	}

	public void setCategory(Set<SB_Category> category) {
		this.category = category;
	}

	public Set<SB_Plan> getPlan() {
		return plan;
	}

	public void setPlan(Set<SB_Plan> plan) {
		this.plan = plan;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "SB_Registration [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", photo=" + photo
				+ ", applicationname=" + applicationname + ", phone=" + phone + ", country=" + country + ", state="
				+ state + ", city=" + city + ", address=" + address + ", zipcode=" + zipcode + ", email=" + email
				+ ", password=" + password + ", confirmPassword=" + confirmPassword + ", emailVerificationToken="
				+ emailVerificationToken + ", userType=" + userType + ", role=" + role + ", status=" + status
				+ ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", category=" + category + ", plan="
				+ plan + "]";
	}


	  
		
	
}
