package com.woofsandwhisker.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.woofsandwhisker.config.DbConfig;
import com.woofsandwhisker.model.PetModel;

public class UpdatePetService {
    private Connection conn;

    public UpdatePetService() {
        try {
            this.conn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
        }
    }

    /**
     * Retrieves a pet from the database by its ID
     * 
     * @param petId The ID of zthe pet to retrieve
     * @return PetModel object if found, null otherwise
     */
    public PetModel getPetById(String petId) {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return null;
        }

        String query = "SELECT * FROM pets WHERE pet_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, petId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new PetModel(
                        rs.getString("pet_id"),
                        rs.getString("pet_name"),
                        rs.getString("pet_category"),
                        rs.getString("breed"),
                        rs.getInt("age"),
                        rs.getString("gender"),
                        rs.getString("color"),
                        rs.getString("size"),
                        rs.getInt("adoption_fees"),
                        rs.getString("pet_description"),
                        rs.getString("pet_image_url")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving pet: " + e.getMessage());
        }

        return null;
    }

    /**
     * Updates an existing pet in the database
     * 
     * @param pet The updated pet data
     * @return true if update was successful, false otherwise
     */
    public boolean updatePet(PetModel pet) {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return false;
        }

        String updateQuery = "UPDATE pets SET pet_name = ?, pet_category = ?, breed = ?, age = ?, " +
                            "gender = ?, color = ?, size = ?, adoption_fees = ?, pet_description = ?, " +
                            "pet_image_url = ? WHERE pet_id = ?";

        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
            updateStmt.setString(1, pet.getPetName());
            updateStmt.setString(2, pet.getPetCategory());
            updateStmt.setString(3, pet.getBreed());
            updateStmt.setInt(4, pet.getAge());
            updateStmt.setString(5, pet.getGender());
            updateStmt.setString(6, pet.getColor());
            updateStmt.setString(7, pet.getSize());
            updateStmt.setInt(8, pet.getAdoptionFees());
            updateStmt.setString(9, pet.getPetDescription());
            updateStmt.setString(10, pet.getPetImageUrl());
            updateStmt.setString(11, pet.getPetId());

            return updateStmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating pet: " + e.getMessage());
            return false;
        }
    }

    /**
     * Deletes a pet from the database
     * 
     * @param petId The ID of the pet to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deletePet(String petId) {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return false;
        }

        String deleteQuery = "DELETE FROM pets WHERE pet_id = ?";

        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
            deleteStmt.setString(1, petId);
            return deleteStmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting pet: " + e.getMessage());
            return false;
        }
    }
}