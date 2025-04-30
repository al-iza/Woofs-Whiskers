package com.woofsandwhiskersss.controller;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;

import com.woofsandwhiskersss.model.CustomerModel;
import com.woofsandwhiskersss.service.RegisterService;
import com.woofsandwhiskersss.util.ImageUtil;
import com.woofsandwhiskersss.util.PasswordUtil;
import com.woofsandwhiskersss.util.ValidationUtil;

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
        try {
            // Validate and extract user model
            String validationMessage = validateRegistrationForm(req);
            if (validationMessage != null) {
                handleError(req, resp, validationMessage);
                return;
            }

            String username = req.getParameter("username");
            if (registerService.isUsernameTaken(username)) {
                handleError(req, resp, "Username is already taken. Please choose another one.");
                return;
            }

            CustomerModel customerModel = extractCustomerModel(req);
            Boolean isAdded = registerService.addCustomer(customerModel);

            if (isAdded == null) {
                handleError(req, resp, "Our server is under maintenance. Please try again later!");
            } else if (isAdded) {
                System.out.print("added");
                try {
                    if (uploadImage(req)) {
                        handleSuccess(req, resp, "Your account is successfully created!", "/WEB-INF/pages/login");
                    } else {
                        handleError(req, resp, "Could not upload the image. Please try again later!");
                    }
                } catch (IOException | ServletException e) {
                    handleError(req, resp, "An error occurred while uploading the image. Please try again later!");
                    e.printStackTrace(); // Log the exception
                }
            } else {
                handleError(req, resp, "Could not register your account. Please try again later!");
            }
        } catch (Exception e) {
            handleError(req, resp, "An unexpected error occurred. Please try again later!");
            e.printStackTrace(); // Log the exception
        }
    }

    private String validateRegistrationForm(HttpServletRequest req) {
        String fullname = req.getParameter("fullname");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String number = req.getParameter("number");
        String dobStr = req.getParameter("dob");
        String gender = req.getParameter("gender");
        String address = req.getParameter("address");
        String retypePassword = req.getParameter("retypePassword");

        // Check for null or empty fields
        if (ValidationUtil.isNullOrEmpty(fullname))
            return "Name is required.";
        if (ValidationUtil.isNullOrEmpty(gender))
            return "Gender is required.";
        if (ValidationUtil.isNullOrEmpty(dobStr))
            return "Date of birth is required.";
        if (ValidationUtil.isNullOrEmpty(address))
            return "Address is required.";
        if (ValidationUtil.isNullOrEmpty(number))
            return "Phone number is required.";
        if (ValidationUtil.isNullOrEmpty(email))
            return "Email is required.";
        if (ValidationUtil.isNullOrEmpty(password))
            return "Password is required.";
        if (ValidationUtil.isNullOrEmpty(retypePassword))
            return "Please retype the password.";

        // Convert date of birth
        LocalDate dob;
        try {
            dob = LocalDate.parse(dobStr);
        } catch (Exception e) {
            return "Invalid date format. Please use YYYY-MM-DD.";
        }

        // Validate fields
        if (!ValidationUtil.isValidGender(gender))
            return "Gender must be 'male' or 'female'.";
        if (!ValidationUtil.isValidEmail(email))
            return "Invalid email format.";
        if (!ValidationUtil.isValidPhoneNumber(number))
            return "Phone number must be 10 digits and start with 98.";
        if (!ValidationUtil.isValidPassword(password))
            return "Password must be at least 8 characters long, with 1 uppercase letter, 1 number, and 1 symbol.";
        if (!ValidationUtil.doPasswordsMatch(password, retypePassword))
            return "Passwords do not match.";

        // Check if the date of birth is at least 16 years before today
        if (!ValidationUtil.isAgeAtLeast16(dob))
            return "You must be at least 16 years old to register.";

        try {
            Part image = req.getPart("profile_photo");
            if (!ValidationUtil.isValidImageExtension(image))
                return "Invalid image format. Only jpg, jpeg, png, and gif are allowed.";
        } catch (IOException | ServletException e) {
            return "Error handling image file. Please ensure the file is valid.";
        }

        return null; // All validations passed
    }

    private CustomerModel extractCustomerModel(HttpServletRequest req) throws Exception {
        String fullname = req.getParameter("fullname");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String number = req.getParameter("number");
        LocalDate dob = LocalDate.parse(req.getParameter("dob"));
        String gender = req.getParameter("gender");
        String address = req.getParameter("address");

        // Encrypt the password
        password = PasswordUtil.encrypt(email, password);

        Part image = req.getPart("profile_photo");
        String imageUrl = imageUtil.getImageNameFromPart(image);

        return new CustomerModel(fullname, username, dob, gender, number, email, address, password, imageUrl);
    }

    private boolean uploadImage(HttpServletRequest req) throws IOException, ServletException {
        Part image = req.getPart("profile_photo");
        return imageUtil.uploadImage(image, req.getServletContext().getRealPath("/"), "user");
    }
    
    

    private void handleSuccess(HttpServletRequest req, HttpServletResponse resp, String message, String redirectPage)
            throws IOException {
        // Optionally, store the success message in the session if you want to show it on the login page
        req.getSession().setAttribute("success", message);
        resp.sendRedirect("login");
    }


    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
 
        req.setAttribute("error", message);
        req.setAttribute("fullname", req.getParameter("fullname"));
        req.setAttribute("username", req.getParameter("username"));
        req.setAttribute("email", req.getParameter("email"));
        req.setAttribute("password", req.getParameter("password"));
        req.setAttribute("number", req.getParameter("number"));
        req.setAttribute("dob", req.getParameter("dob"));
        req.setAttribute("gender", req.getParameter("gender"));
        req.setAttribute("address", req.getParameter("address"));
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }
}
