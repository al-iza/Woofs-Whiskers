<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Woofs & Whiskers - Pet Details</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewpetdetails.css">
</head>
<body>
  <header>
    <div class="logo">
      <h1>Woofs&Whiskers</h1>
    </div>
    <nav>
      <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/viewallpets">View Pets</a></li>
        <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
        <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
      </ul>
      <div class="user-actions">
        <div class="dark-mode-icon" onclick="toggleDarkMode()">🌙</div>
      </div>
    </nav>
  </header>

  <div class="container">
    <h1 class="page-title">Pet Details</h1>
    
    <!-- Display success/error messages -->
    <c:if test="${not empty sessionScope.success}">
      <div class="alert alert-success">
        ${sessionScope.success}
        <c:remove var="success" scope="session" />
      </div>
    </c:if>
    
    <c:if test="${not empty requestScope.error}">
      <div class="alert alert-error">
        ${requestScope.error}
      </div>
    </c:if>
    
    <c:choose>
      <c:when test="${empty pet}">
        <div class="no-pet">
          <img src="https://img.icons8.com/ios/200/paw-print.png" alt="No pet found">
          <h3>Pet Not Found</h3>
          <p>The pet you are looking for could not be found. Please try another pet.</p>
          <a href="${pageContext.request.contextPath}/viewallpets" class="back-btn">Back to Pets</a>
        </div>
      </c:when>
      <c:otherwise>
        <section class="pet-details-section">
          <div class="pet-details-container">
            <div class="pet-image-container">
              <c:choose>
                <c:when test="${not empty pet.petImageUrl}">
                  <img src="${pageContext.request.contextPath}/Uploads/${pet.petImageUrl}" alt="${pet.petName}" class="pet-image">
                </c:when>
                <c:otherwise>
                  <img src="${pageContext.request.contextPath}/images/pet-placeholder.jpg" alt="${pet.petName}" class="pet-image">
                </c:otherwise>
              </c:choose>
            </div>
            <div class="pet-info-container">
              <h2 class="pet-name">${pet.petName}</h2>
              <div class="pet-info-grid">
                <div class="info-item">
                  <span class="info-label">Category:</span>
                  <span class="info-value">${pet.petCategory}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">Breed:</span>
                  <span class="info-value">${pet.breed}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">Age:</span>
                  <span class="info-value">${pet.age} ${pet.age eq 1 ? 'year' : 'years'}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">Gender:</span>
                  <span class="info-value">${pet.gender}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">Color:</span>
                  <span class="info-value">${pet.color}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">Size:</span>
                  <span class="info-value">${pet.size}</span>
                </div>
                <div class="info-item">
                  <span class="info-label">Adoption Fee:</span>
                  <span class="info-value">$${pet.adoptionFees}</span>
                </div>
              </div>
              <div class="pet-description">
                <h3>Description</h3>
                <p>${pet.petDescription}</p>
              </div>
              <div class="pet-actions">
                <a href="${pageContext.request.contextPath}/adoptpet?id=${pet.petId}" class="pet-btn adopt-btn">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78L12 21.23l8.84-8.84a5.5 5.5 0 0 0 0-7.78z"></path>
                  </svg>
                  Adopt
                </a>
                <a href="${pageContext.request.contextPath}/viewallpets" class="pet-btn back-btn">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M19 12H5"></path>
                    <path d="M12 19l-7-7 7-7"></path>
                  </svg>
                  Back to Pets
                </a>
              </div>
            </div>
          </div>
        </section>
      </c:otherwise>
    </c:choose>
  </div>

  <footer>
    <div class="footer-content">
      <div class="footer-section">
        <h3 class="footer-title">About Us</h3>
        <p>Woofs & Whiskers is dedicated to finding loving homes for pets. We connect adorable animals with caring families.</p>
      </div>
      
      <div class="footer-section">
        <h3 class="footer-title">Quick Links</h3>
        <ul class="footer-links">
          <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
          <li><a href="${pageContext.request.contextPath}/viewallpets">View Pets</a></li>
          <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
          <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h3 class="footer-title">Contact Us</h3>
        <div class="footer-contact">
          <div class="contact-item">
            <svg class="contact-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="2" y="4" width="20" height="16" rx="2"></rect>
              <path d="M22 7l-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"></path>
            </svg>
            <span>info@woofswhiskers.com</span>
          </div>
          <div class="contact-item">
            <svg class="contact-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M5 4h4l2 5-2.5 1.5a11 11 0 0 0 5 5l1.5-2.5 5 2v4a2 2 0 0 1-2 2A16 16 0 0 1 3 6a2 2 0 0 1 2-2"></path>
            </svg>
            <span>+977-1-1234567</span>
          </div>
        </div>
        
        <div class="footer-social">
          <a href="https://www.facebook.com" target="_blank" class="social-link">
            <svg class="social-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
              <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path>
            </svg>
          </a>
          <a href="https://www.instagram.com" target="_blank" class="social-link">
            <svg class="social-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
              <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
              <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
              <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
            </svg>
          </a>
          <a href="https://www.twitter.com" target="_blank" class="social-link">
            <svg class="social-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
              <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path>
            </svg>
          </a>
        </div>
      </div>
      
      <div class="footer-section">
        <h3 class="footer-title">Location</h3>
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.025597893126!2d85.32064327520194!3d27.717245027703195!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190d79aee9b9%3A0x4f0b07c7df1a0b3!2sLazimpat%2C%20Kathmandu%2044600!5e0!3m2!1sen!2snp!4v1714723943215!5m2!1sen!2snp" allowfullscreen="" loading="lazy"></iframe>
      </div>
    </div>
    
    <div class="footer-bottom">
      © 2025 Woofs&Whiskers. All rights reserved.
    </div>
  </footer>

  <script>
    function toggleDarkMode() {
      document.body.classList.toggle('dark-mode');
      const darkModeIcon = document.querySelector('.dark-mode-icon');
      darkModeIcon.innerHTML = document.body.classList.contains('dark-mode') ? '☀️' : '🌙';
    }
  </script>
</body>
</html>