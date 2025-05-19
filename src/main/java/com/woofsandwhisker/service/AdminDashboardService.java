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

public class AdminDashboardService {
    private Connection conn;

    public AdminDashboardService() {
        try {
            this.conn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
        }
    }

    /**
     * Retrieves the total number of pets in the database
     * 
     * @return Total number of pets
     */
    public int getTotalPets() {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return 0;
        }
        
        String query = "SELECT COUNT(*) AS total FROM pets";
        
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving total pets: " + e.getMessage());
        }
        
        return 0;
    }

    /**
     * Retrieves the total number of users in the database
     * 
     * @return Total number of users
     */
    public int getTotalUsers() {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return 0;
        }
        
        String query = "SELECT COUNT(*) AS total FROM customertable";
        
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving total users: " + e.getMessage());
        }
        
        return 0;
    }

    /**
     * Retrieves the pet with the highest adoption fee
     * 
     * @return PetModel of the most expensive pet or null if none found
     */
    public PetModel getMostExpensivePet() {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return null;
        }
        
        String query = "SELECT * FROM pets ORDER BY adoption_fees DESC LIMIT 1";
        
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return mapResultSetToPet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving most expensive pet: " + e.getMessage());
        }
        
        return null;
    }

    /**
     * Retrieves the count of pets by category
     * 
     * @return Map of category to pet count
     */
    public Map<String, Integer> getPetsByCategory() {
        Map<String, Integer> petsByCategory = new LinkedHashMap<>();
        
        if (conn == null) {
            System.out.println("Database connection is null.");
            return petsByCategory;
        }
        
        String query = "SELECT pet_category, COUNT(*) AS count FROM pets GROUP BY pet_category";
        
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                petsByCategory.put(rs.getString("pet_category"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving pets by category: " + e.getMessage());
        }
        
        return petsByCategory;
    }

    /**
     * Retrieves the count of pets by gender
     * 
     * @return Map of gender to pet count
     */
    public Map<String, Integer> getPetsByGender() {
        Map<String, Integer> petsByGender = new LinkedHashMap<>();
        
        if (conn == null) {
            System.out.println("Database connection is null.");
            return petsByGender;
        }
        
        String query = "SELECT gender, COUNT(*) AS count FROM pets GROUP BY gender";
        
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                petsByGender.put(rs.getString("gender"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving pets by gender: " + e.getMessage());
        }
        
        return petsByGender;
    }

    /**
     * Retrieves the three most recently added pets
     * 
     * @return List of recent PetModel objects
     */
    public List<PetModel> getRecentPets() {
        List<PetModel> recentPets = new ArrayList<>();
        
        if (conn == null) {
            System.out.println("Database connection is null.");
            return recentPets;
        }
        
        String query = "SELECT * FROM pets ORDER BY pet_id DESC LIMIT 3";
        
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                recentPets.add(mapResultSetToPet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving recent pets: " + e.getMessage());
        }
        
        return recentPets;
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