
package com.woofsandwhiskersss.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.woofsandwhiskersss.config.DbConfig;
import com.woofsandwhiskersss.model.CustomerModel;

/**
 * RegisterService handles the registration of new students. It manages database
 * interactions for student registration.
 */
public class RegisterService {

	private  Connection dbConn;

	/**
	 * Constructor initializes the database connection.
	 */
	public RegisterService() {
		try {
			this.dbConn = DbConfig.getDbConnection();
		} catch (SQLException | ClassNotFoundException ex) {
			System.err.println("Database connection error: " + ex.getMessage());
			ex.printStackTrace();
		}
	}
	
	public boolean isUsernameTaken(String username) {
	    String checkQuery = "SELECT COUNT(*) FROM CustomerTable WHERE username = ?";
	    try (PreparedStatement stmt = dbConn.prepareStatement(checkQuery)) {
	        stmt.setString(1, username);
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1) > 0; // If count is greater than 0, the username exists
	        }
	    } catch (SQLException e) {
	        System.err.println("Error checking username: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return false;
	}

	

	/**
	 * Registers a new student in the database.
	 *
	 * @param studentModel the student details to be registered
	 * @return Boolean indicating the success of the operation
	 */
	public Boolean addCustomer(CustomerModel customerModel) {
		if (dbConn == null) {
			System.err.println("Database connection is not available.");
			return null;
		}

//		String programQuery = "SELECT program_id FROM program WHERE name = ?";
		String insertQuery = "INSERT INTO CustomerTable (full_name, username, dob, gender, number, email, address, password, image_url) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";


//		try (PreparedStatement programStmt = dbConn.prepareStatement(programQuery);
		try(PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery)) {

//			// Fetch program ID
//			programStmt.setString(1, studentModel.getProgram().getName());
//			ResultSet result = programStmt.executeQuery();
//			int programId = result.next() ? result.getInt("program_id") : 1;

			// Insert student details
			insertStmt.setString(1, customerModel.getFullName());
			insertStmt.setString(2, customerModel.getUserName());
			insertStmt.setDate(3, Date.valueOf(customerModel.getDob()));
			insertStmt.setString(4, customerModel.getGender());
			insertStmt.setString(5, customerModel.getContactNumber());
			insertStmt.setString(6, customerModel.getEmail());
			insertStmt.setString(7, customerModel.getAddress());
			insertStmt.setString(8,customerModel.getPassword());
			insertStmt.setString(9,customerModel.getImageUrl());

			return insertStmt.executeUpdate() > 0;
		} catch (SQLException e) {
			System.err.println("Error during user registration: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}
}