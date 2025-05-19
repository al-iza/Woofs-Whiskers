package com.woofsandwhisker.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.woofsandwhisker.model.PetModel;
import com.woofsandwhisker.service.ViewAllPetsService;

@WebServlet("/viewallpets")
public class ViewAllPetsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ViewAllPetsService viewAllPetsService = new ViewAllPetsService();
    
    public ViewAllPetsController() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get all pets
            List<PetModel> allPets = viewAllPetsService.getAllPets();
            
            // Set attributes for JSP
            request.setAttribute("allPets", allPets);
            
            // Forward to the JSP page
            request.getRequestDispatcher("/WEB-INF/pages/viewallpets.jsp").forward(request, response);
        } catch (Exception e) {
            handleError(request, response, "Error retrieving pets: " + e.getMessage());
        }
    }
    
    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.getRequestDispatcher("/WEB-INF/pages/viewallpets.jsp").forward(req, resp);
    }
}