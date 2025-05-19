package com.woofsandwhisker.model;

public class PetModel {
	private String petId;
	private String petName;
	private String petCategory;
	private String breed;
	private int age;
	private String gender;
	private String color;
	private String size;
	private int adoptionFees;
	private String petDescription;
	private String petImageUrl;
	/**
	 * @param petId
	 * @param petName
	 * @param petCategory
	 * @param breed
	 * @param age
	 * @param gender
	 * @param color
	 * @param size
	 * @param adoptionFees
	 * @param petDescription
	 * @param petImageUrl
	 */
	public PetModel(String petId, String petName, String petCategory, String breed, int age, String gender,
			String color, String size, int adoptionFees, String petDescription, String petImageUrl) {
		super();
		this.petId = petId;
		this.petName = petName;
		this.petCategory = petCategory;
		this.breed = breed;
		this.age = age;
		this.gender = gender;
		this.color = color;
		this.size = size;
		this.adoptionFees = adoptionFees;
		this.petDescription = petDescription;
		this.petImageUrl = petImageUrl;
	}
	public String getPetId() {
		return petId;
	}
	public void setPetId(String petId) {
		this.petId = petId;
	}
	public String getPetName() {
		return petName;
	}
	public void setPetName(String petName) {
		this.petName = petName;
	}
	public String getPetCategory() {
		return petCategory;
	}
	public void setPetCategory(String petCategory) {
		this.petCategory = petCategory;
	}
	public String getBreed() {
		return breed;
	}
	public void setBreed(String breed) {
		this.breed = breed;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public int getAdoptionFees() {
		return adoptionFees;
	}
	public void setAdoptionFees(int adoptionFees) {
		this.adoptionFees = adoptionFees;
	}
	public String getPetDescription() {
		return petDescription;
	}
	public void setPetDescription(String petDescription) {
		this.petDescription = petDescription;
	}
	public String getPetImageUrl() {
		return petImageUrl;
	}
	public void setPetImageUrl(String petImageUrl) {
		this.petImageUrl = petImageUrl;
	}
	
	
}
