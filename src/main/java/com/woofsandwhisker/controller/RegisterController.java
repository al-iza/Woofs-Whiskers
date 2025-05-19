package com.woofsandwhisker.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.io.File;

import com.woofsandwhisker.model.UserModel;
import com.woofsandwhisker.service.RegisterService;
import com.woofsandwhisker.util.ImageUtil;
import com.woofsandwhisker.util.PasswordUtil;
import com.woofsandwhisker.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 * RegisterController handles user registration requests and processes form
 * submissions. It also manages file uploads and account creation.
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ImageUtil imageUtil = new ImageUtil();
    private final RegisterService registerService = new RegisterService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doPost called");
        try {
            // Debug - print all form parameters
            System.out.println("Form parameters:");
            System.out.println("username: " + req.getParameter("username"));
            System.out.println("fullname: " + req.getParameter("fullname"));
            System.out.println("email: " + req.getParameter("email"));
            System.out.println("number: " + req.getParameter("number"));
            System.out.println("dob: " + req.getParameter("dob"));
            System.out.println("gender: " + req.getParameter("gender"));
            System.out.println("address: " + req.getParameter("address"));
            System.out.println("password provided: " + (req.getParameter("password") != null ? "Yes" : "No"));
            System.out.println("retypepassword provided: " + (req.getParameter("retypepassword") != null ? "Yes" : "No"));
            
            // Validate form data first
            String validationMessage = validateRegistrationForm(req);
            if (validationMessage != null) {
                System.out.println("Validation failed: " + validationMessage);
                handleError(req, resp, validationMessage);
                return;
            }
            
            // Check for duplicate username/email
            String username = req.getParameter("username");
            String email = req.getParameter("email");

            if (registerService.isUsernameExists(username)) {
                handleError(req, resp, "Username already exists. Please choose another one.");
                return;
            }

            if (registerService.isEmailExists(email)) {
                handleError(req, resp, "Email already exists. Please use another email.");
                return;
            }

            // Extract user model
            UserModel userModel = extractUserModel(req);
            System.out.println("User model created: " + userModel);
            
            // First try to upload the image
            boolean imageUploaded = true;  // Assume success initially
            try {
                Part imagePart = req.getPart("profile_photo");
                if (imagePart != null && imagePart.getSize() > 0) {
                    System.out.println("Image part found: name=" + imagePart.getName() + 
                                      ", size=" + imagePart.getSize() + 
                                      ", contentType=" + imagePart.getContentType());
                    
                    // Get and log the application root path
                    String rootPath = req.getServletContext().getRealPath("/");
                    System.out.println("Application root path: " + rootPath);
                    
                    // Check target directories
                    String resourcesPath = rootPath + "resources";
                    String imagesPath = resourcesPath + "/images";
                    String userImagesPath = imagesPath + "/user";
                    
                    System.out.println("Resources directory exists: " + new File(resourcesPath).exists());
                    System.out.println("Images directory exists: " + new File(imagesPath).exists());
                    System.out.println("User images directory exists: " + new File(userImagesPath).exists());
                    
                    // Check file size
                    if (imagePart.getSize() > 5 * 1024 * 1024) {
                        handleError(req, resp, "Image file size should not exceed 5MB.");
                        return;
                    }
                    
                    imageUploaded = uploadImage(req);
                    System.out.println("Image upload result: " + imageUploaded);
                } else {
                    System.out.println("No image part found or empty image");
                    imageUploaded = false;
                }
                
                // If image upload failed, we can still continue with a default image
                if (!imageUploaded) {
                    System.out.println("Image upload failed, using default image");
                    // Set a default image URL if upload fails
                    userModel.setImageUrl("default_profile.png");
                }
            } catch (Exception e) {
                System.out.println("Exception during image upload: " + e.getMessage());
                e.printStackTrace();
                // Set a default image URL if upload fails
                userModel.setImageUrl("default_profile.png");
                imageUploaded = false;
            }
            
            // Add the user to the database
            Boolean isAdded = registerService.addUser(userModel);
            System.out.println("Database add result: " + isAdded);

            if (isAdded == null) {
                handleError(req, resp, "Our server is under maintenance. Please try again later!");
            } else if (isAdded) {
                System.out.println("User added successfully to database");
                
                // If user was added to db but image upload failed, still show success
                // but with a warning about the image
                if (!imageUploaded) {
                    handleSuccess(req, resp, 
                        "Your account is successfully created! However, we couldn't upload your profile image. You can add it later.", 
                        "/WEB-INF/pages/login.jsp");
                } else {
                    handleSuccess(req, resp, 
                        "Your account is successfully created!", 
                        "/WEB-INF/pages/login.jsp");
                }
            } else {
                handleError(req, resp, "Could not register your account. Please try again later!");
            }
        } catch (Exception e) {
            System.out.println("Unexpected exception: " + e.getMessage());
            e.printStackTrace();
            handleError(req, resp, "An unexpected error occurred. Please try again later!");
        }
    }
    
    private String validateRegistrationForm(HttpServletRequest req) {
        String fullname = req.getParameter("fullname");
        String username = req.getParameter("username");
        String dobStr = req.getParameter("dob");
        String gender = req.getParameter("gender");
        String email = req.getParameter("email");
        String number = req.getParameter("number");
        String password = req.getParameter("password");
        String retypepassword = req.getParameter("retypepassword");
        String address = req.getParameter("address");

        // Check for null or empty fields first
        if (ValidationUtil.isNullOrEmpty(fullname))
            return "Full name is required.";
        if (ValidationUtil.isNullOrEmpty(username))
            return "Username is required.";
        if (ValidationUtil.isNullOrEmpty(dobStr))
            return "Date of birth is required.";
        if (ValidationUtil.isNullOrEmpty(gender))
            return "Gender is required.";
        if (ValidationUtil.isNullOrEmpty(email))
            return "Email is required.";
        if (ValidationUtil.isNullOrEmpty(number))
            return "Phone number is required.";
        if (ValidationUtil.isNullOrEmpty(password))
            return "Password is required.";
        if (ValidationUtil.isNullOrEmpty(retypepassword))
            return "Please retype your password.";
        if (ValidationUtil.isNullOrEmpty(address))
            return "Address is required.";

        // Convert date of birth
        LocalDate dob;
        try {
            dob = LocalDate.parse(dobStr);
        } catch (Exception e) {
            return "Invalid date format. Please use YYYY-MM-DD.";
        }

        // Validate fields
        if (!ValidationUtil.isAlphanumericStartingWithLetter(username))
            return "Username must start with a letter and contain only letters and numbers.";
            
        // Add username length check
        if (username.length() < 4 || username.length() > 20)
            return "Username must be between 4 and 20 characters.";
            
        if (!ValidationUtil.isValidGender(gender))
            return "Gender must be 'male', 'female', or 'other'.";
            
        if (!ValidationUtil.isValidEmail(email))
            return "Invalid email format.";
            
        if (!ValidationUtil.isValidPhoneNumber(number))
            return "Phone number must be 10 digits and start with 98.";
            
        if (!ValidationUtil.isValidPassword(password))
            return "Password must be at least 8 characters long, with 1 uppercase letter, 1 number, and 1 symbol.";
            
        if (!password.equals(retypepassword))
            return "Passwords do not match.";
            
        // Add address length check
        if (address.length() < 5 || address.length() > 200)
            return "Address must be between 5 and 200 characters.";

        // Check if the date of birth is at least 16 years before today
        if (!ValidationUtil.isAgeAtLeast16(dob))
            return "You must be at least 16 years old to register.";
        
        // Check fullname has at least two parts
        String[] nameParts = fullname.trim().split("\\s+");
        if (nameParts.length < 2)
            return "Please enter your full name (first and last name).";
        
        try {
            Part image = req.getPart("profile_photo");
            if (image != null && image.getSize() > 0 && !ValidationUtil.isValidImageExtension(image))
                return "Invalid image format. Only jpg, jpeg, png, and gif are allowed.";
        } catch (IOException | ServletException e) {
            return "Error handling image file. Please ensure the file is valid.";
        }

        return null; // All validations passed
    }

    private UserModel extractUserModel(HttpServletRequest req) throws Exception {
        // Extract basic user information
        String fullname = req.getParameter("fullname");
        String username = req.getParameter("username");
        LocalDate dob = LocalDate.parse(req.getParameter("dob"));
        String gender = req.getParameter("gender");
        String number = req.getParameter("number");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        
        String password = req.getParameter("password");
        // Encrypt the password
        password = PasswordUtil.encrypt(username, password);
        
        // Get image part and extract image name
        Part image = req.getPart("profile_photo");
        String imageUrl;
        
        if (image != null && image.getSize() > 0) {
            imageUrl = imageUtil.getImageNameFromPart(image);
            System.out.println("Extracted image URL: " + imageUrl);
        } else {
            imageUrl = "default_profile.png";
            System.out.println("Using default image URL");
        }
        
        // Create and return the UserModel
        return new UserModel(fullname, username, dob, gender, number, email, address, password, imageUrl);
    }

    private boolean uploadImage(HttpServletRequest req) throws IOException, ServletException {
        Part image = req.getPart("profile_photo");
        String rootPath = req.getServletContext().getRealPath("/");
        System.out.println("Passing root path to ImageUtil: " + rootPath);
        
        // Ensure directories exist
        String resourcesPath = rootPath + "resources";
        String imagesPath = resourcesPath + "/images";
        String userImagesPath = imagesPath + "/user";
        
        File resourcesDir = new File(resourcesPath);
        File imagesDir = new File(imagesPath);
        File userImagesDir = new File(userImagesPath);
        
        if (!resourcesDir.exists()) {
            System.out.println("Creating resources directory: " + resourcesDir.mkdirs());
        }
        
        if (!imagesDir.exists()) {
            System.out.println("Creating images directory: " + imagesDir.mkdirs());
        }
        
        if (!userImagesDir.exists()) {
            System.out.println("Creating user images directory: " + userImagesDir.mkdirs());
        }
        
        boolean result = imageUtil.uploadImage(image, rootPath, "user");
        System.out.println("Image upload result from ImageUtil: " + result);
        return result;
    }

    private void handleSuccess(HttpServletRequest req, HttpServletResponse resp, String message, String redirectPage)
            throws ServletException, IOException {
        req.setAttribute("success", message);
        req.getRequestDispatcher(redirectPage).forward(req, resp);
    }

    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.setAttribute("fullname", req.getParameter("fullname"));
        req.setAttribute("username", req.getParameter("username"));
        req.setAttribute("dob", req.getParameter("dob"));
        req.setAttribute("gender", req.getParameter("gender"));
        req.setAttribute("email", req.getParameter("email"));
        req.setAttribute("number", req.getParameter("number"));
        req.setAttribute("address", req.getParameter("address"));
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }
}