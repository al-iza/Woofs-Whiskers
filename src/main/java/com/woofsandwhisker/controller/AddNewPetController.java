package com.woofsandwhisker.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import com.woofsandwhisker.model.PetModel;
import com.woofsandwhisker.service.AddNewPetService;
import com.woofsandwhisker.util.ValidationUtil;

@WebServlet("/addnewpet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10MB
public class AddNewPetController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ValidationUtil validationUtil = new ValidationUtil();

    public AddNewPetController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/addnewpet.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Retrieve form parameters
            String petID = request.getParameter("petID");
            String petName = request.getParameter("petName");
            String petCategory = request.getParameter("category");
            String breed = request.getParameter("breed");
            String ageStr = request.getParameter("age");
            String gender = request.getParameter("gender");
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            String feesStr = request.getParameter("fees");
            String petDescription = request.getParameter("description");
            Part image = request.getPart("petImage");

            // Initialize error message
            StringBuilder errorMessage = new StringBuilder();

            // Validate Pet ID
            if (ValidationUtil.isNullOrEmpty(petID)) {
                errorMessage.append("Pet ID is required. ");
            } else if (!validationUtil.isAlphanumericStartingWithLetter(petID) || petID.length() > 20) {
                errorMessage.append("Pet ID must start with a letter, contain only letters and numbers, and be at most 20 characters. ");
            }

            // Validate Pet Name
            if (ValidationUtil.isNullOrEmpty(petName)) {
                errorMessage.append("Pet Name is required. ");
            } else if (!petName.matches("^[a-zA-Z\\s]+$") || petName.length() > 50) {
                errorMessage.append("Pet Name must contain only letters and spaces, and be at most 50 characters. ");
            }

            // Validate Pet Category
            if (ValidationUtil.isNullOrEmpty(petCategory)) {
                errorMessage.append("Pet Category is required. ");
            } else if (!petCategory.matches("^(Dog|Cat|Bird|Fish)$")) {
                errorMessage.append("Invalid Pet Category. Choose Dog, Cat, Bird, or Fish. ");
            }

            // Validate Breed
            if (ValidationUtil.isNullOrEmpty(breed)) {
                errorMessage.append("Breed is required. ");
            } else if (!breed.matches("^[a-zA-Z\\s]+$") || breed.length() > 50) {
                errorMessage.append("Breed must contain only letters and spaces, and be at most 50 characters. ");
            }

            // Validate Age
            double age = 0;
            try {
                age = Double.parseDouble(ageStr);
                if (age < 0 || age > 30) {
                    errorMessage.append("Age must be between 0 and 30 years. ");
                }
            } catch (NumberFormatException e) {
                errorMessage.append("Age must be a valid number. ");
            }

            // Validate Gender
            if (ValidationUtil.isNullOrEmpty(gender)) {
                errorMessage.append("Gender is required. ");
            } else if (!validationUtil.isValidGender(gender)) {
                errorMessage.append("Gender must be Male or Female. ");
            }

            // Validate Color (optional)
            if (!ValidationUtil.isNullOrEmpty(color)) {
                if (!color.matches("^[a-zA-Z\\s]+$") || color.length() > 50) {
                    errorMessage.append("Color must contain only letters and spaces, and be at most 50 characters. ");
                }
            }

            // Validate Size (optional)
            if (!ValidationUtil.isNullOrEmpty(size)) {
                if (!size.matches("^(Tiny|Small|Medium|Large|Extra Large)$")) {
                    errorMessage.append("Invalid Size. Choose Tiny, Small, Medium, Large, or Extra Large. ");
                }
            }

            // Validate Adoption Fees (optional)
            double fees = 0;
            if (!ValidationUtil.isNullOrEmpty(feesStr)) {
                try {
                    fees = Double.parseDouble(feesStr);
                    if (fees < 0 || fees > 10000) {
                        errorMessage.append("Adoption Fees must be between 0 and 10000. ");
                    }
                } catch (NumberFormatException e) {
                    errorMessage.append("Adoption Fees must be a valid number. ");
                }
            }

            // Validate Pet Description (optional)
            if (!ValidationUtil.isNullOrEmpty(petDescription)) {
                if (petDescription.length() > 1000) {
                    errorMessage.append("Pet Description must be at most 1000 characters. ");
                }
            }

            // Validate Pet Image
            if (image == null || !validationUtil.isValidImageExtension(image)) {
                errorMessage.append("A valid image file (JPG, JPEG, PNG, GIF) is required. ");
            }

            // Preserve form inputs
            request.setAttribute("petID", petID);
            request.setAttribute("petName", petName);
            request.setAttribute("petCategory", petCategory);
            request.setAttribute("breed", breed);
            request.setAttribute("age", ageStr);
            request.setAttribute("gender", gender);
            request.setAttribute("color", color);
            request.setAttribute("size", size);
            request.setAttribute("fees", feesStr);
            request.setAttribute("description", petDescription);

            // If there are validation errors, forward to addnewpet.jsp
            if (errorMessage.length() > 0) {
                request.setAttribute("error", errorMessage.toString());
                request.getRequestDispatcher("/WEB-INF/pages/addnewpet.jsp").forward(request, response);
                return;
            }

            // Use the original file name
            String fileName = image.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty()) {
                request.setAttribute("error", "No image file uploaded.");
                request.getRequestDispatcher("/WEB-INF/pages/addnewpet.jsp").forward(request, response);
                return;
            }

            // Save the image to webapp/resources/images/user/ using Part.write()
            String uploadDir = getServletContext().getRealPath("/resources/images/user/");
            Path uploadPath = Paths.get(uploadDir, fileName);
            Files.createDirectories(uploadPath.getParent()); // Ensure directory exists
            image.write(uploadPath.toString());

            // Use the original file name as the image URL
            String imageUrl = fileName;

            // Create PetModel with validated data
            PetModel model = new PetModel(petID, petName, petCategory, breed, (int) age, gender, color, size, (int) fees, petDescription, imageUrl);

            // Check petID uniqueness and create account
            AddNewPetService service = new AddNewPetService();
            if (service.isPetIdUnique(petID)) {
                boolean success = service.createAccount(model);
                if (success) {
                    request.setAttribute("success", "Pet added successfully!");
                    request.getRequestDispatcher("/WEB-INF/pages/managepets.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Failed to add pet. Please try again.");
                    request.getRequestDispatcher("/WEB-INF/pages/addnewpet.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Pet ID already exists. Please choose a different ID.");
                request.getRequestDispatcher("/WEB-INF/pages/addnewpet.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace(); // Log the error for debugging
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.setAttribute("petID", request.getParameter("petID"));
            request.setAttribute("petName", request.getParameter("petName"));
            request.setAttribute("petCategory", request.getParameter("category"));
            request.setAttribute("breed", request.getParameter("breed"));
            request.setAttribute("age", request.getParameter("age"));
            request.setAttribute("gender", request.getParameter("gender"));
            request.setAttribute("color", request.getParameter("color"));
            request.setAttribute("size", request.getParameter("size"));
            request.setAttribute("fees", request.getParameter("fees"));
            request.setAttribute("description", request.getParameter("description"));
            request.getRequestDispatcher("/WEB-INF/pages/addnewpet.jsp").forward(request, response);
        }
    }
}