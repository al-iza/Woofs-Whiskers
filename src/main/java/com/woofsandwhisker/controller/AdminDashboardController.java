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
import com.woofsandwhisker.service.AdminDashboardService;
import com.woofsandwhisker.service.ProfileService;

@WebServlet("/admindashboard")
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AdminDashboardService adminDashboardService = new AdminDashboardService();
    private final ProfileService profileService = new ProfileService();
    
    public AdminDashboardController() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if user is logged in
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("username") == null) {
                response.sendRedirect("login");
                return;
            }
            
            // Get logged in user information
            String username = (String) session.getAttribute("username");
            UserModel loggedInUser = profileService.getUserDetails(username);
            
            if (loggedInUser == null) {
                response.sendRedirect("login");
                return;
            }
            
            // Fetch dashboard data
            int totalPets = adminDashboardService.getTotalPets();
            int totalUsers = adminDashboardService.getTotalUsers();
            PetModel mostExpensivePet = adminDashboardService.getMostExpensivePet();
            Map<String, Integer> petsByCategory = adminDashboardService.getPetsByCategory();
            Map<String, Integer> petsByGender = adminDashboardService.getPetsByGender();
            List<PetModel> recentPets = adminDashboardService.getRecentPets();
            
            // Set attributes for JSP
            request.setAttribute("totalPets", totalPets);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("mostExpensivePet", mostExpensivePet);
            request.setAttribute("petsByCategory", petsByCategory);
            request.setAttribute("petsByGender", petsByGender);
            request.setAttribute("recentPets", recentPets);
            
            // Set logged in user details
            request.setAttribute("user", loggedInUser);
            
            // Forward to the JSP page
            request.getRequestDispatcher("/WEB-INF/pages/admindashboard.jsp").forward(request, response);
        } catch (Exception e) {
            handleError(request, response, "Error loading dashboard: " + e.getMessage());
        }
    }
    
    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.getRequestDispatcher("/WEB-INF/pages/admindashboard.jsp").forward(req, resp);
    }
}