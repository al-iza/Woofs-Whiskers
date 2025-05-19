package com.woofsandwhisker.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.woofsandwhisker.model.PetModel;
import com.woofsandwhisker.service.ViewPetDetailsService;

@WebServlet("/petdetails")
public class ViewPetDetailsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ViewPetDetailsService viewPetDetailsService = new ViewPetDetailsService();
    
    public ViewPetDetailsController() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get pet ID from request parameter
            String petId = request.getParameter("id");
            if (petId == null || petId.isEmpty()) {
                handleError(request, response, "Pet ID is missing.");
                return;
            }
            
            // Get pet details
            PetModel pet = viewPetDetailsService.getPetById(petId);
            
            // Set attributes for JSP
            request.setAttribute("pet", pet);
            
            // Forward to the JSP page
            request.getRequestDispatcher("/WEB-INF/pages/viewpetdetails.jsp").forward(request, response);
        } catch (Exception e) {
            handleError(request, response, "Error retrieving pet details: " + e.getMessage());
        }
    }
    
    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.getRequestDispatcher("/WEB-INF/pages/viewpetdetails.jsp").forward(req, resp);
    }
}