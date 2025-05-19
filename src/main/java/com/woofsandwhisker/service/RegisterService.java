package com.woofsandwhisker.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.woofsandwhisker.config.DbConfig;
import com.woofsandwhisker.model.UserModel;

/**
 * RegisterService handles the registration of new users. It manages database
 * interactions for user registration.
 */
public class RegisterService {

    private Connection dbConn;

    /**
     * Constructor initializes the database connection.
     */
    public RegisterService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
            System.out.println("Database connected successfully");
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    /**
     * Adds a new user to the database.
     *
     * @param userModel the user details to be registered
     * @return Boolean indicating the success of the operation
     */
    public Boolean addUser(UserModel userModel) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String insertQuery = "INSERT INTO customertable (full_name, username, dob, gender, number, email, address, password, image_url) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery)) {
            // Insert user details in correct order
            insertStmt.setString(1, userModel.getFullName());
            insertStmt.setString(2, userModel.getUsername());
            insertStmt.setDate(3, java.sql.Date.valueOf(userModel.getDob()));
            insertStmt.setString(4, userModel.getGender());
            insertStmt.setString(5, userModel.getNumber());
            insertStmt.setString(6, userModel.getEmail());
            insertStmt.setString(7, userModel.getAddress());
            insertStmt.setString(8, userModel.getPassword());
            insertStmt.setString(9, userModel.getImageUrl());

            System.out.println("Executing SQL: " + insertQuery);
            System.out.println("With parameters: " + userModel);
            
            int result = insertStmt.executeUpdate();
            System.out.println("Insert result: " + result);
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error during user registration: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("SQL Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Checks if a username already exists in the database
     * 
     * @param username Username to check
     * @return true if username exists, false otherwise
     */
    public boolean isUsernameExists(String username) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }
        
        String query = "SELECT COUNT(*) FROM customertable WHERE username = ?";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("Username check for '" + username + "': " + (count > 0 ? "exists" : "doesn't exist"));
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking username existence: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Checks if an email already exists in the database
     * 
     * @param email Email to check
     * @return true if email exists, false otherwise
     */
    public boolean isEmailExists(String email) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }
        
        String query = "SELECT COUNT(*) FROM customertable WHERE email = ?";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("Email check for '" + email + "': " + (count > 0 ? "exists" : "doesn't exist"));
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
}