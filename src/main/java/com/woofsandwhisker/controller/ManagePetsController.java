package com.woofsandwhisker.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.woofsandwhisker.model.PetModel;
import com.woofsandwhisker.service.ManagePetsService;

@WebServlet("/managepets")
public class ManagePetsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ManagePetsService managePetsService = new ManagePetsService();
    
    public ManagePetsController() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get all pets first
            List<PetModel> allPets = managePetsService.getAllPets();
            
            // Set attributes for JSP
            request.setAttribute("allPets", allPets);
            
            // Forward to the JSP page
            request.getRequestDispatcher("/WEB-INF/pages/managepets.jsp").forward(request, response);
        } catch (Exception e) {
            handleError(request, response, "Error retrieving pets: " + e.getMessage());
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle pet deletion if needed
        String action = request.getParameter("action");
        String petId = request.getParameter("petId");
        
        if ("delete".equals(action) && petId != null && !petId.isEmpty()) {
            try {
                boolean success = managePetsService.deletePet(petId);
                if (success) {
                    handleSuccess(request, response, "Pet deleted successfully!", "/managepets");
                } else {
                    handleError(request, response, "Failed to delete pet. Please try again.");
                }
            } catch (Exception e) {
                handleError(request, response, "Error deleting pet: " + e.getMessage());
            }
        } else {
            // Redirect back to the manage pets page for any other POST requests
            response.sendRedirect(request.getContextPath() + "/managepets");
        }
    }
    
    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.getRequestDispatcher("/WEB-INF/pages/managepets.jsp").forward(req, resp);
    }
    
    private void handleSuccess(HttpServletRequest req, HttpServletResponse resp, String message, String redirectUrl)
            throws ServletException, IOException {
        req.getSession().setAttribute("success", message);
        resp.sendRedirect(req.getContextPath() + redirectUrl);
    }
}