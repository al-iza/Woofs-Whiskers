package com.woofsandwhisker.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.woofsandwhisker.config.DbConfig;
import com.woofsandwhisker.model.PetModel;

public class ViewPetDetailsService {
    private Connection conn;

    public ViewPetDetailsService() {
        try {
            this.conn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
        }
    }

    /**
     * Retrieves a pet by its ID from the database
     * 
     * @param petId ID of the pet to retrieve
     * @return PetModel object or null if not found
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
                    return mapResultSetToPet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving pet: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Maps a ResultSet row to a PetModel object
     * 
     * @param rs ResultSet containing pet data
     * @return PetModel object
     * @throws SQLException if there's an error accessing the ResultSet
     */
    private PetModel mapResultSetToPet(ResultSet rs) throws SQLException {
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