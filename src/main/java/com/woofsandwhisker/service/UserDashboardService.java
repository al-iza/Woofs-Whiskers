package com.woofsandwhisker.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.woofsandwhisker.config.DbConfig;
import com.woofsandwhisker.model.PetModel;

public class UserDashboardService {
    private Connection conn;

    public UserDashboardService() {
        try {
            this.conn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
        }
    }

    /**
     * Retrieves the count of available pets by category (Dog, Cat, Fish, Bird)
     * 
     * @return Map of category to pet count
     */
    public Map<String, Integer> getPetCountsByCategory() {
        Map<String, Integer> petCounts = new LinkedHashMap<>();
        petCounts.put("Dog", 0);
        petCounts.put("Cat", 0);
        petCounts.put("Fish", 0);
        petCounts.put("Bird", 0);
        
        if (conn == null) {
            System.out.println("Database connection is null.");
            return petCounts;
        }
        
        String query = "SELECT pet_category, COUNT(*) AS count FROM pets WHERE pet_category IN ('Dog', 'Cat', 'Fish', 'Bird') GROUP BY pet_category";
        
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                petCounts.put(rs.getString("pet_category"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving pet counts by category: " + e.getMessage());
        }
        
        return petCounts;
    }

    /**
     * Retrieves three featured pets for the dashboard
     * 
     * @return List of featured PetModel objects
     */
    public List<PetModel> getFeaturedPets() {
        List<PetModel> featuredPets = new ArrayList<>();
        
        if (conn == null) {
            System.out.println("Database connection is null.");
            return featuredPets;
        }
        
        String query = "SELECT * FROM pets WHERE featured = true ORDER BY pet_id DESC LIMIT 3";
        
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                featuredPets.add(mapResultSetToPet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving featured pets: " + e.getMessage());
        }
        
        return featuredPets;
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