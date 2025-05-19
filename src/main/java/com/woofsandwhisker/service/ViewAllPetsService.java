package com.woofsandwhisker.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.woofsandwhisker.config.DbConfig;
import com.woofsandwhisker.model.PetModel;

public class ViewAllPetsService {
    private Connection conn;

    public ViewAllPetsService() {
        try {
            this.conn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
        }
    }

    /**
     * Retrieves all pets from the database
     * 
     * @return List of PetModel objects
     */
    public List<PetModel> getAllPets() {
        List<PetModel> pets = new ArrayList<>();
        
        if (conn == null) {
            System.out.println("Database connection is null.");
            return pets;
        }
        
        String query = "SELECT * FROM pets ORDER BY pet_id";
        
        try (
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery()
        ) {
            while (rs.next()) {
                PetModel pet = mapResultSetToPet(rs);
                pets.add(pet);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving pets: " + e.getMessage());
        }
        
        return pets;
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