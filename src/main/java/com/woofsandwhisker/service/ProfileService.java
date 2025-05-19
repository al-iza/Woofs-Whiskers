package com.woofsandwhisker.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;

import com.woofsandwhisker.config.DbConfig;
import com.woofsandwhisker.model.UserModel;
import com.woofsandwhisker.util.PasswordUtil;

public class ProfileService {
    private static final Logger LOGGER = Logger.getLogger(ProfileService.class.getName());
    private Connection conn;
    private boolean isConnectionError = false;

    public ProfileService() {
        try {
            this.conn = DbConfig.getDbConnection();
        } catch (Exception e) {
            isConnectionError = true;
            LOGGER.log(Level.SEVERE, "Database connection error", e);
        }
    }

    public Boolean loginUser(UserModel user) {
        if (isConnectionError) {
            LOGGER.severe("Connection Error!");
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
            LOGGER.log(Level.SEVERE, "Error during login validation", e);
            return null;
        }
        return false;
    }

    private boolean validatePassword(ResultSet result, UserModel user) throws SQLException {
        String dbPassword = result.getString("password");
        String dbEmail = result.getString("email");
        String decryptedPassword = PasswordUtil.decrypt(dbPassword, dbEmail);
        return decryptedPassword.equals(user.getPassword());
    }

    public UserModel getUserDetails(String username) {
        if (isConnectionError) {
            LOGGER.severe("Database connection error. Unable to fetch user details.");
            return null;
        }

        String query = "SELECT full_name, username, dob, gender, number, email, address, password, image_url " +
                      "FROM customertable WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                UserModel user = new UserModel();
                user.setFullName(result.getString("full_name"));
                user.setGender(result.getString("gender"));
                user.setDob(result.getDate("dob") != null ? result.getDate("dob").toLocalDate() : null);
                user.setNumber(result.getString("number"));
                user.setAddress(result.getString("address"));
                user.setEmail(result.getString("email"));
                user.setUsername(result.getString("username"));
                user.setPassword(result.getString("password"));
                user.setImageUrl(result.getString("image_url"));
                return user;
            } else {
                LOGGER.warning("No user details found for username: " + username);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error while fetching user details", e);
        }
        return null;
    }

    public Boolean updateUser(UserModel user) {
        if (isConnectionError) {
            LOGGER.severe("Database connection error. Unable to update user.");
            return false;
        }

        String updateQuery = "UPDATE customertable SET full_name = ?, dob = ?, gender = ?, number = ?, " +
                            "email = ?, address = ?, password = ?, image_url = ? WHERE username = ?";
        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
            updateStmt.setString(1, user.getFullName());
            updateStmt.setDate(2, user.getDob() != null ? Date.valueOf(user.getDob()) : null);
            updateStmt.setString(3, user.getGender());
            updateStmt.setString(4, user.getNumber());
            updateStmt.setString(5, user.getEmail());
            updateStmt.setString(6, user.getAddress());
            updateStmt.setString(7, user.getPassword()); // Reuse existing password from UserModel
            updateStmt.setString(8, user.getImageUrl());
            updateStmt.setString(9, user.getUsername());
            
            // Fix: Using correct username for logging
            LOGGER.info("Updating user with username: " + user.getUsername());
            
            int rowsAffected = updateStmt.executeUpdate();
            LOGGER.info("Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error during user update", e);
            return false;
        }
    }
}