package com.woofsandwhiskersss.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.woofsandwhiskersss.util.CookieUtil;
import com.woofsandwhiskersss.util.SessionUtil;

@WebFilter(urlPatterns = "/*")
public class AuthenticationFilter implements Filter {

    private static final List<String> PUBLIC_PATHS = Arrays.asList("/login", "/register", "/", "/welcome", "/about", "/portfolio", "/contact");
    private static final List<String> STATIC_EXTENSIONS = Arrays.asList(".css", ".js", ".png", ".jpg", ".jpeg", ".webp", ".svg", ".woff", ".woff2");

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // Allow static resources
        if (STATIC_EXTENSIONS.stream().anyMatch(uri::endsWith)) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = SessionUtil.getAttribute(req, "Email") != null;
        String role = CookieUtil.getCookie(req, "role") != null ? CookieUtil.getCookie(req, "role").getValue() : null;

        // Not logged in
        if (!isLoggedIn || role == null) {
            if (PUBLIC_PATHS.stream().anyMatch(uri::endsWith)) {
                chain.doFilter(request, response); // allow access to public pages
            } else {
                res.sendRedirect(contextPath + "/login");
            }
            return;
        }

        // If logged in as admin
        if ("admin".equalsIgnoreCase(role)) {
            if (uri.endsWith("/login") || uri.endsWith("/register")) {
                res.sendRedirect(contextPath + "/dashboard");
            } else {
                chain.doFilter(request, response);
            }
            return;
        }

        // If logged in as user
        if ("user".equalsIgnoreCase(role)) {
            if (uri.endsWith("/login") || uri.endsWith("/register")) {
                res.sendRedirect(contextPath + "/home");
            } else if (uri.contains("/dashboard") || uri.contains("/modifyStudents") || uri.contains("/adminOrder")) {
                res.sendRedirect(contextPath + "/home");
            } else {
                chain.doFilter(request, response);
            }
            return;
        }

        // Unknown role: redirect to login
        res.sendRedirect(contextPath + "/login");
    }
}
