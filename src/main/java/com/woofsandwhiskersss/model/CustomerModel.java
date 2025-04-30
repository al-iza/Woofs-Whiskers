package com.woofsandwhiskersss.model;

import java.time.LocalDate;

public class CustomerModel{
	private String fullName;
	private String userName;
	private LocalDate dob;
	private String gender;
	private String contactNumber;
	private String email;
	private String address;
	private String password;
	private String imageUrl;
	
	public CustomerModel() {}

	
	/**
	 * @param userName
	 * @param password
	 */
	public CustomerModel(String userName, String password) {
		super();
		this.userName = userName;
		this.password = password;
	}


	/**
	 * @param fullName
	 * @param userName
	 * @param dob
	 * @param gender
	 * @param contactNumber
	 * @param email
	 * @param address
	 * @param password
	 * @param imageUrl
	 */
	public CustomerModel(String fullName, String userName, LocalDate dob, String gender, String contactNumber,
			String email, String address, String password, String imageUrl) {
		super();
		this.fullName = fullName;
		this.userName = userName;
		this.dob = dob;
		this.gender = gender;
		this.contactNumber = contactNumber;
		this.email = email;
		this.address = address;
		this.password = password;
		this.imageUrl = imageUrl;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public LocalDate getDob() {
		return dob;
	}

	public void setDob(LocalDate dob) {
		this.dob = dob;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	}