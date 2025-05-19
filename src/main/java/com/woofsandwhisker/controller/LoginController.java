package com.woofsandwhisker.controller;
import java.io.IOException;
import com.woofsandwhisker.model.UserModel;
import com.woofsandwhisker.service.LoginService;
import com.woofsandwhisker.util.CookieUtil;
import com.woofsandwhisker.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * LoginController is responsible for handling login requests. It interacts with
 * the LoginService to authenticate users.
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final LoginService loginService;
    
    /**
     * Constructor initializes the LoginService.
     */
    public LoginController() {
        this.loginService = new LoginService();
    }
    
    /**
     * Handles GET requests to the login page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }
    
    /**
     * Handles POST requests for user login.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        boolean hasError = false;
        
        // Validate username
        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("usernameError", "Username is required");
            hasError = true;
        }
        
        // Validate password
        if (password == null || password.trim().isEmpty()) {
            req.setAttribute("passwordError", "Password is required");
            hasError = true;
        }
        
        // If validation errors exist, return to login page with error messages
        if (hasError) {
            req.setAttribute("username", username); // Preserve username input
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            return;
        }
        
        // Continue with existing authentication logic
        UserModel fullUserModel = loginService.getUserByCredentials(username, password);
        
        if (fullUserModel != null) {
            // Authentication successful - existing code
            SessionUtil.setAttribute(req, "username", username);
            SessionUtil.setAttribute(req, "user", fullUserModel);
            
            if (username.equals("admin123")) {
                CookieUtil.addCookie(resp, "role", "admin", 5 * 30);
                resp.sendRedirect(req.getContextPath() + "/dashboard");
            } else {
                CookieUtil.addCookie(resp, "role", "user", 5 * 30);
                resp.sendRedirect(req.getContextPath() + "/welcome");
            }
        } else {
            handleLoginFailure(req, resp, fullUserModel != null);
        }
    }
    
    /**
     * Handles login failures.
     */
    private void handleLoginFailure(HttpServletRequest req, HttpServletResponse resp, Boolean loginStatus)
            throws ServletException, IOException {
        String errorMessage;
        if (loginStatus == null) {
            errorMessage = "Our server is under maintenance. Please try again later!";
        } else {
            errorMessage = "User credential mismatch. Please try again!";
        }
        req.setAttribute("error", errorMessage);
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }
}