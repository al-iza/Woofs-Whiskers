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
import com.woofsandwhisker.service.UpdatePetService;

@WebServlet("/updatepet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10, // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class UpdatePetController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UpdatePetService updatePetService = new UpdatePetService();

    public UpdatePetController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String petId = request.getParameter("id");
        
        if (petId != null && !petId.isEmpty()) {
            try {
                PetModel pet = updatePetService.getPetById(petId);
                
                if (pet != null) {
                    request.setAttribute("pet", pet);
                    request.getRequestDispatcher("/WEB-INF/pages/updatepet.jsp").forward(request, response);
                } else {
                    handleError(request, response, "Pet not found with ID: " + petId);
                }
            } catch (Exception e) {
                handleError(request, response, "Error retrieving pet details: " + e.getMessage());
            }
        } else {
            handleError(request, response, "No pet ID provided.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Extract form parameters
            String petId = request.getParameter("petID");
            String petName = request.getParameter("petName");
            String petCategory = request.getParameter("category");
            String breed = request.getParameter("breed");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            int adoptionFees = Integer.parseInt(request.getParameter("fees"));
            String petDescription = request.getParameter("description");
            Part image = request.getPart("petImage");

            // Handle image upload
            String imageFileName = null;
            if (image != null && image.getSize() > 0) {
                // Use the original file name
                String fileName = image.getSubmittedFileName();
                if (fileName == null || fileName.isEmpty()) {
                    handleError(request, response, "No valid image file uploaded.");
                    return;
                }
                System.out.println("Image part received: " + fileName + ", size: " + image.getSize());

                // Save the image to resources/images/user/
                String uploadDir = getServletContext().getRealPath("/") + "resources/images/user/";
                Path uploadPath = Paths.get(uploadDir, fileName);
                Files.createDirectories(uploadPath.getParent()); // Ensure directory exists
                image.write(uploadPath.toString());
                System.out.println("Image uploaded to: " + uploadPath.toString());

                // Use only the filename for the database
                imageFileName = fileName;
                System.out.println("Image uploaded successfully: /resources/images/user/" + imageFileName);
            } else {
                System.out.println("No image part received or empty");
                PetModel existingPet = updatePetService.getPetById(petId);
                imageFileName = (existingPet != null && existingPet.getPetImageUrl() != null)
                    ? existingPet.getPetImageUrl()
                    : "default-pet-image.jpg";
                System.out.println("Using existing or default image: " + imageFileName);
            }

            // Create pet model with updated data, storing only the filename
            PetModel updatedPet = new PetModel(petId, petName, petCategory, breed, age, gender, color, size, adoptionFees, petDescription, imageFileName);
            System.out.println("PetModel imageFileName: " + updatedPet.getPetImageUrl());

            // Update pet in database
            boolean success = updatePetService.updatePet(updatedPet);
            
            if (success) {
                System.out.println("Pet updated successfully for petId: " + petId);
                handleSuccess(request, response, "Pet updated successfully!", "/managepets");
            } else {
                System.out.println("Failed to update pet for petId: " + petId);
                handleError(request, response, "Failed to update pet. Please try again.");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            handleError(request, response, "Invalid number format. Please check age and fees fields.");
        } catch (Exception e) {
            e.printStackTrace();
            handleError(request, response, "An unexpected error occurred: " + e.getMessage());
        }
    }
    
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String petId = request.getParameter("id");
        
        if (petId != null && !petId.isEmpty()) {
            try {
                boolean success = updatePetService.deletePet(petId);
                
                if (success) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Pet deleted successfully");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Failed to delete pet");
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Error: " + e.getMessage());
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("No pet ID provided");
        }
    }

    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.getRequestDispatcher("/WEB-INF/pages/updatepet.jsp").forward(req, resp);
    }

    private void handleSuccess(HttpServletRequest req, HttpServletResponse resp, String message, String redirectPage)
            throws ServletException, IOException {
        req.getSession().setAttribute("success", message);
        resp.sendRedirect(req.getContextPath() + redirectPage);
    }
}