package com.woofsandwhisker.model;

import java.time.LocalDate;
import java.util.Date;

public class UserModel {
    private int id;
    private String fullName;
    private String username;
    private LocalDate dob;
    private String gender;
    private String number;
    private String email;
    private String address;
    private String password;
    private String imageUrl;
    
    public UserModel() {
    }
    
    
    
    /**
	 * @param username
	 * @param password
	 */
	public UserModel(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}
	




	public UserModel(String fullName, String username, LocalDate dob, String gender, String number, 
                String email, String address, String password, String imageUrl) {
        this.fullName = fullName;
        this.username = username;
        this.dob = dob;
        this.gender = gender;
        this.number = number;
        this.email = email;
        this.address = address;
        this.password = password;
        this.imageUrl = imageUrl;
    }
   // All getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
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

    // Method to check if user is admin
    public boolean isAdmin() {
        return "admin".equals(this.username);
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", username='" + username + '\'' +
                ", dob=" + dob +
                ", gender='" + gender + '\'' +
                ", number='" + number + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}