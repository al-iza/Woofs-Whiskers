package com.woofsandwhisker.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.woofsandwhisker.config.DbConfig;
import com.woofsandwhisker.model.PetModel;

public class AddNewPetService {

    private Connection conn;

    public AddNewPetService() {
        try {
            this.conn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
        }
    }

    public boolean isPetIdUnique(String petId) {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return false;
        }

        String query = "SELECT COUNT(*) FROM pets WHERE pet_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, petId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0; // True if no rows exist
            }
        } catch (SQLException e) {
            System.err.println("Error checking pet ID uniqueness: " + e.getMessage());
        }
        return false;
    }

    public boolean createAccount(PetModel pet) {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return false;
        }

        String insertQuery = "INSERT INTO pets(pet_id, pet_name, pet_category, breed, age, gender, color, size, adoption_fees, pet_description, pet_image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
            insertStmt.setString(1, pet.getPetId());
            insertStmt.setString(2, pet.getPetName());
            insertStmt.setString(3, pet.getPetCategory());
            insertStmt.setString(4, pet.getBreed());
            insertStmt.setInt(5, pet.getAge());
            insertStmt.setString(6, pet.getGender());
            insertStmt.setString(7, pet.getColor());
            insertStmt.setString(8, pet.getSize());
            insertStmt.setInt(9, pet.getAdoptionFees());
            insertStmt.setString(10, pet.getPetDescription());
            insertStmt.setString(11, pet.getPetImageUrl());

            return insertStmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error during account creation: " + e.getMessage());
            return false;
        }
    }
}