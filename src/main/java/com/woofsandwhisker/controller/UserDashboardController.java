package com.woofsandwhisker.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.woofsandwhisker.model.PetModel;
import com.woofsandwhisker.model.UserModel;
import com.woofsandwhisker.service.UserDashboardService;

@WebServlet("/userdashboard")
public class UserDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDashboardService userDashboardService = new UserDashboardService();
    
    public UserDashboardController() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get the logged-in user from the session
            HttpSession session = request.getSession(false);
            UserModel user = (session != null && session.getAttribute("user") != null) 
                ? (UserModel) session.getAttribute("user") 
                : new UserModel(null, "Guest", null, null, null, null, null, null, null);
            
            // Fetch dashboard data
            Map<String, Integer> petCounts = userDashboardService.getPetCountsByCategory();
            List<PetModel> featuredPets = userDashboardService.getFeaturedPets();
            
            // Log user details for debugging
            System.out.println("User: Fullname=" + (user != null ? user.getFullName() : "null") + 
                             ", Image URL=" + (user != null ? user.getImageUrl() : "null"));
            
            // Set attributes for JSP
            request.setAttribute("petCounts", petCounts);
            request.setAttribute("featuredPets", featuredPets);
            request.setAttribute("user", user);
            
            // Forward to the JSP page
            request.getRequestDispatcher("/WEB-INF/pages/userdashboard.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in UserDashboardController: " + e.getMessage());
            handleError(request, response, "Error loading dashboard: " + e.getMessage());
        }
    }
    
    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.getRequestDispatcher("/WEB-INF/pages/userdashboard.jsp").forward(req, resp);
    }
}