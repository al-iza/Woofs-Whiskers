package com.woofsandwhiskersss.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.woofsandwhiskersss.config.DbConfig;
import com.woofsandwhiskersss.model.CustomerModel;
import com.woofsandwhiskersss.util.PasswordUtil;

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

	public Boolean loginUser(CustomerModel customer) {
		if (isConnectionError) {
			System.out.println("Connection Error!");
			return null;
		}

		String query = "SELECT * FROM customertable WHERE username = ?";
		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, customer.getUserName());

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return validatePassword(rs, customer);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}

		return false;
	}

	private boolean validatePassword(ResultSet result, CustomerModel user) throws SQLException {
		String dbPassword = result.getString("password");
		String dbUsername = result.getString("username");

		String decryptedPassword = PasswordUtil.decrypt(dbPassword, dbUsername);

		System.out.println("DEBUG INFO:");
		System.out.println("DB Username: " + dbUsername);
		System.out.println("Encrypted DB Password: " + dbPassword);
		System.out.println("User-entered password: " + user.getPassword());
		System.out.println("Decrypted password: " + decryptedPassword);

		if (decryptedPassword == null) {
			System.out.println("❌ Password decryption returned null");
			return false;
		}

		return decryptedPassword.equals(user.getPassword());
	}

}