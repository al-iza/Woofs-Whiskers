package com.woofsandwhisker.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.logging.Logger;
import java.util.logging.Level;

import com.woofsandwhisker.model.UserModel;
import com.woofsandwhisker.service.ProfileService;

@WebServlet(asyncSupported = true, urlPatterns = { "/profile" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10, // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(ProfileController.class.getName());
    private final ProfileService profileService = new ProfileService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Entering doGet method for Profile");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            LOGGER.warning("No active session or username");
            response.sendRedirect("login");
            return;
        }

        String username = (String) session.getAttribute("username");
        LOGGER.info("Fetching user details for username: " + username);

        UserModel user = profileService.getUserDetails(username);

        if (user != null) {
            if (user.getImageUrl() == null || user.getImageUrl().isEmpty()) {
                user.setImageUrl("default-profile.png");
            }
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
        } else {
            LOGGER.warning("No user details found for username: " + username);
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        LOGGER.info("Entering doPost method for Profile");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            LOGGER.warning("No active session or username");
            resp.sendRedirect("login");
            return;
        }

        String username = (String) session.getAttribute("username");
        LOGGER.info("Processing update for user: " + username);

        // Retrieve form parameters
        String fullName = req.getParameter("fullName");  // Make sure this matches the form field name
        String gender = req.getParameter("gender");
        String dobStr = req.getParameter("dob");
        String number = req.getParameter("number");      // Make sure this matches the form field name
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        Part image = req.getPart("profilePic");

        // Debug log the parameters
        LOGGER.info("Parameters received: fullName=" + fullName + ", gender=" + gender + 
                   ", dob=" + dobStr + ", number=" + number + ", address=" + address + 
                   ", email=" + email);

        // Validate required fields
        if (fullName == null || fullName.isEmpty() || email == null || email.isEmpty() ||
            gender == null || gender.isEmpty() || dobStr == null || dobStr.isEmpty() ||
            number == null || number.isEmpty()) {
            LOGGER.warning("Missing required fields for user: " + username);
            req.setAttribute("message", "All required fields must be filled.");
            reloadUserDetails(req, resp, username);
            return;
        }

        // Parse date of birth
        LocalDate dob;
        try {
            dob = LocalDate.parse(dobStr);
        } catch (Exception e) {
            LOGGER.warning("Invalid date format for dob: " + dobStr);
            req.setAttribute("message", "Invalid date of birth format.");
            reloadUserDetails(req, resp, username);
            return;
        }

        // Get the current user to preserve the existing password
        UserModel currentUser = profileService.getUserDetails(username);
        if (currentUser == null) {
            LOGGER.warning("Failed to retrieve current user details for username: " + username);
            req.setAttribute("message", "Error retrieving current user information.");
            req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, resp);
            return;
        }
        
        // Preserve the existing password
        String existingPassword = currentUser.getPassword();

        // Handle profile image
        String imageFileName = null;
        if (image != null && image.getSize() > 0) {
            String fileName = image.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty()) {
                LOGGER.warning("No valid image file uploaded for user: " + username);
                req.setAttribute("message", "Invalid image file.");
                reloadUserDetails(req, resp, username);
                return;
            }
            
            // Generate a secure filename to prevent path traversal
            String fileExtension = "";
            int i = fileName.lastIndexOf('.');
            if (i > 0) {
                fileExtension = fileName.substring(i);
            }
            
            // Use a combination of username and timestamp for uniqueness
            String secureFileName = username + "_" + System.currentTimeMillis() + fileExtension;
            
            LOGGER.info("Image part received: " + fileName + ", size: " + image.getSize() + ", secure filename: " + secureFileName);

            // Save image to resources/images/user/
            String uploadDir = getServletContext().getRealPath("/") + "resources/images/user/";
            Path uploadPath = Paths.get(uploadDir, secureFileName);
            try {
                Files.createDirectories(uploadPath.getParent());
                image.write(uploadPath.toString());
                LOGGER.info("Image uploaded to: " + uploadPath.toString());
                imageFileName = secureFileName;
                LOGGER.info("Image uploaded successfully: /resources/images/user/" + imageFileName);
            } catch (IOException e) {
                LOGGER.log(Level.WARNING, "Image upload failed for user: " + username, e);
                req.setAttribute("message", "Failed to upload image.");
                reloadUserDetails(req, resp, username);
                return;
            }
        } else {
            LOGGER.info("No image part received or empty for user: " + username);
            imageFileName = currentUser.getImageUrl();
            LOGGER.info("Using existing image: " + imageFileName);
        }

        // Create updated user model with preserved password
        UserModel updatedUser = new UserModel();
        updatedUser.setFullName(fullName);
        updatedUser.setGender(gender);
        updatedUser.setDob(dob);
        updatedUser.setNumber(number);
        updatedUser.setAddress(address);
        updatedUser.setEmail(email);
        updatedUser.setUsername(username); // Make sure the correct username is set
        updatedUser.setPassword(existingPassword);
        updatedUser.setImageUrl(imageFileName);
        
        LOGGER.info("Created UserModel for update with username: " + updatedUser.getUsername() + " and imageFileName: " + updatedUser.getImageUrl());

        // Update user in database
        boolean isUpdated = profileService.updateUser(updatedUser);

        // Get updated user details
        UserModel user = profileService.getUserDetails(username);
        if (user != null) {
            if (user.getImageUrl() == null || user.getImageUrl().isEmpty()) {
                user.setImageUrl("default-profile.png");
            }
            req.setAttribute("user", user);
        } else {
            LOGGER.warning("Failed to fetch updated user details for username: " + username);
            req.setAttribute("message", "Failed to retrieve updated profile.");
            req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, resp);
            return;
        }

        // Set success or error message
        if (isUpdated) {
            LOGGER.info("Profile updated successfully for username: " + username);
            req.setAttribute("message", "Profile updated successfully!");
        } else {
            LOGGER.warning("Failed to update profile for username: " + username);
            req.setAttribute("message", "Failed to update profile.");
        }

        req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, resp);
    }

    private void reloadUserDetails(HttpServletRequest req, HttpServletResponse resp, String username)
            throws ServletException, IOException {
        UserModel user = profileService.getUserDetails(username);
        if (user != null) {
            if (user.getImageUrl() == null || user.getImageUrl().isEmpty()) {
                user.setImageUrl("default-profile.png");
            }
            req.setAttribute("user", user);
        }
        req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, resp);
    }
}