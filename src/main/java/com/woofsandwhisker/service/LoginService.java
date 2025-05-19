package com.woofsandwhisker.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.woofsandwhisker.config.DbConfig;
import com.woofsandwhisker.model.UserModel;
import com.woofsandwhisker.util.PasswordUtil;

public class LoginService {
    private Connection conn;
    private boolean isConnectionError = false;

    public LoginService() {
        try {
            this.conn = DbConfig.getDbConnection(); // ✅ initialize connection here
        } catch (Exception e) {
            isConnectionError = true;
            e.printStackTrace();
        }
    }

    public Boolean loginUser(UserModel user) {
        if (isConnectionError) {
            System.out.println("Connection Error!");
            return null;
        }
        String query = "SELECT * FROM customertable WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getUsername());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return validatePassword(rs, user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return false;
    }

    private boolean validatePassword(ResultSet result, UserModel user) throws SQLException {
        String dbPassword = result.getString("password");
        String dbUsername = result.getString("username");
        String decryptedPassword = PasswordUtil.decrypt(dbPassword, dbUsername);
        if (decryptedPassword == null) {
            // Handle the error, perhaps logging or throwing a custom exception
            throw new IllegalArgumentException("Decryption failed. The password is null.");
        }
        return decryptedPassword.equals(user.getPassword());
    }
    
    /**
     * Retrieves the full user model from the database for a given username
     * and password combination.
     * 
     * @param username The username to check
     * @param password The password to validate
     * @return Complete UserModel if authentication succeeds, null otherwise
     */
    public UserModel getUserByCredentials(String username, String password) {
        if (isConnectionError) {
            System.out.println("Connection Error!");
            return null;
        }
        
        // Create a temporary user for authentication
        UserModel tempUser = new UserModel();
        tempUser.setUsername(username);
        tempUser.setPassword(password);
        
        // Check if credentials are valid
        Boolean isAuthenticated = loginUser(tempUser);
        
        if (isAuthenticated != null && isAuthenticated) {
            // Credentials are valid, get the full user details
            return fetchUserDetails(username);
        }
        
        return null; // Authentication failed or error
    }
    
    /**
     * Fetches complete user details from the database.
     * 
     * @param username The username to fetch details for
     * @return Complete UserModel with all user data
     */
    private UserModel fetchUserDetails(String username) {
        if (isConnectionError) {
            System.out.println("Connection Error!");
            return null;
        }
        
        String query = "SELECT * FROM customertable WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                UserModel fullUser = new UserModel();
                
                // Set all the user details from the database
                fullUser.setUsername(rs.getString("username"));
                fullUser.setFullName(rs.getString("full_name"));
                fullUser.setEmail(rs.getString("email"));
                fullUser.setNumber(rs.getString("number"));
                fullUser.setImageUrl(rs.getString("image_url"));
                fullUser.setAddress(rs.getString("address"));
                fullUser.setGender(rs.getString("gender"));
                
                // Don't set the password in the session for security
                
                return fullUser;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}