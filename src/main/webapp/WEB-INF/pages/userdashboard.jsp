<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>User Dashboard - Woofs&Whiskers</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css">
</head>
<body>
  
  <div class="page-container">
    <header>
      <div class="logo">
        <img src="https://img.icons8.com/fluency/96/null/dog-footprint.png" alt="Paw Logo">
        <h1>Woofs<span class="ampersand">&</span>Whiskers</h1>
      </div>
      
      <div class="header-right">
        <div class="notification">
          <i class="fas fa-bell"></i>
          <span class="notification-badge">3</span>
        </div>
        
        <div class="profile-header">
          <div class="profile-pic-small">
            <c:choose>
              <c:when test="${not empty sessionScope.user and not empty sessionScope.user.imageUrl}">
                <img src="${pageContext.request.contextPath}/resources/images/user/${sessionScope.user.imageUrl}" 
                     alt="Profile" 
                     class="profile-pic-small"
                     onerror="this.src='${pageContext.request.contextPath}/resources/images/default-profile.png';">
              </c:when>
              <c:otherwise>
                <img src="${pageContext.request.contextPath}/resources/images/default-profile.png" 
                     alt="Profile" 
                     class="profile-pic-small">
              </c:otherwise>
            </c:choose>
          </div>
          <!-- Fix: Explicitly use sessionScope to access the user object -->
          <span><c:out value="${sessionScope.user.fullName}" default="Guest" /></span>
          <i class="fas fa-angle-down"></i>
        </div>
        
        <div class="theme-toggle">
          <i class="fas fa-moon"></i>
        </div>
        
        <div class="mobile-menu-toggle">
          <i class="fas fa-bars"></i>
        </div>
      </div>
    </header>

    <div class="content-wrapper">
      <nav class="sidebar">
        <ul class="nav-links">
          <li class="active">
            <a href="${pageContext.request.contextPath}/userdashboard">
              <i class="fas fa-home"></i>
              <span>Dashboard</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/viewpetdetails">
              <i class="fas fa-paw"></i>
              <span>View Pets</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/adoptapet">
              <i class="fas fa-heart"></i>
              <span>Adopt a Pet</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/contactus">
              <i class="fas fa-envelope"></i>
              <span>Contact Us</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/profile">
              <i class="fas fa-user"></i>
              <span>Profile</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/aboutus">
              <i class="fas fa-info-circle"></i>
              <span>About Us</span>
            </a>
          </li>
          <li class="logout">
            <a href="${pageContext.request.contextPath}/login">
              <i class="fas fa-sign-out-alt"></i>
              <span>Logout</span>
            </a>
          </li>
        </ul>
      </nav>

      <main class="main-content">
        <!-- Welcome Banner -->
        <section class="welcome-banner">
          <div class="welcome-text">
            <!-- Personalized welcome message -->
            <h2>Welcome<c:if test="${not empty sessionScope.user.fullName}">, ${sessionScope.user.fullName}</c:if>!</h2>
            <p>Find your perfect furry companion and make a difference in their life.</p>
            <a href="${pageContext.request.contextPath}/adoptapet" class="adopt-btn">Adopt Now</a>
          </div>
          <div class="welcome-image">
            <img src="https://images.unsplash.com/photo-1560743641-3914f2c45636?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80" alt="Happy dog and cat">
          </div>
        </section>

        <!-- Statistics Cards -->
        <section class="stats-cards">
          <div class="stat-card">
            <div class="stat-icon">
              <i class="fas fa-dog"></i>
            </div>
            <div class="stat-info">
              <h3>${petCounts['Dog']}</h3>
              <p>Dogs Available</p>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">
              <i class="fas fa-cat"></i>
            </div>
            <div class="stat-info">
              <h3>${petCounts['Cat']}</h3>
              <p>Cats Available</p>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">
              <i class="fas fa-fish"></i>
            </div>
            <div class="stat-info">
              <h3>${petCounts['Fish']}</h3>
              <p>Fish Available</p>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">
              <i class="fas fa-dove"></i>
            </div>
            <div class="stat-info">
              <h3>${petCounts['Bird']}</h3>
              <p>Birds Available</p>
            </div>
          </div>
        </section>

        <!-- Featured Pets Section -->
        <section class="featured-pets">
          <h2 class="section-title">Featured Pets</h2>
          <div class="pets-grid">
            <c:forEach var="pet" items="${featuredPets}">
              <div class="pet-card">
                <div class="pet-image">
                  <img src="${pet.petImageUrl}" alt="${pet.petName}">
                  <span class="pet-tag">${pet.petCategory}</span>
                </div>
                <div class="pet-info">
                  <h3>${pet.petName}</h3>
                  <p>${pet.breed} • ${pet.age} years</p>
                  <p class="pet-description">${pet.petDescription}</p>
                  <a href="${pageContext.request.contextPath}/petdetails?petId=${pet.petId}" class="pet-details-btn">View Details</a>
                </div>
              </div>
            </c:forEach>
          </div>
          <div class="see-all-link">
            <a href="${pageContext.request.contextPath}/viewallpets">See All Pets <i class="fas fa-arrow-right"></i></a>
          </div>
        </section>

        <!-- Adoption Process Section -->
        <section class="adoption-process">
          <h2 class="section-title">How to Adopt</h2>
          <div class="process-steps">
            <div class="process-step">
              <div class="step-icon">
                <i class="fas fa-search"></i>
                <span class="step-number">1</span>
              </div>
              <h3>Browse Pets</h3>
              <p>Explore our available pets and find your perfect match</p>
            </div>
            
            <div class="process-step">
              <div class="step-icon">
                <i class="fas fa-file-alt"></i>
                <span class="step-number">2</span>
              </div>
              <h3>Apply</h3>
              <p>Complete an adoption application for your chosen pet</p>
            </div>
            
            <div class="process-step">
              <div class="step-icon">
                <i class="fas fa-comments"></i>
                <span class="step-number">3</span>
              </div>
              <h3>Meet & Greet</h3>
              <p>Schedule a meeting to get to know your potential pet</p>
            </div>
            
            <div class="process-step">
              <div class="step-icon">
                <i class="fas fa-home"></i>
                <span class="step-number">4</span>
              </div>
              <h3>Take Home</h3>
              <p>Complete the adoption process and welcome your new family member</p>
            </div>
          </div>
        </section>
      </main>
    </div>

    <footer>
      <div class="footer-content">
        <div class="footer-column">
          <div class="footer-logo">
            <img src="https://img.icons8.com/fluency/48/null/dog-footprint.png" alt="Paw Logo">
            <h3>Woofs&Whiskers</h3>
          </div>
          <p>Connecting loving homes with pets in need since 2020.</p>
          <div class="footer-social">
            <a href="https://www.facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
            <a href="https://www.instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
            <a href="https://www.twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
          </div>
        </div>
        
        <div class="footer-column">
          <h3>Quick Links</h3>
          <ul>
            <li><a href="${pageContext.request.contextPath}/adoptapet">Adopt a Pet</a></li>
            <li><a href="#">Donation</a></li>
            <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/contactus">Contact Us</a></li>
          </ul>
        </div>
        
        <div class="footer-column">
          <h3>Contact Info</h3>
          <ul class="contact-info">
            <li><i class="fas fa-map-marker-alt"></i> Lazimpat, Kathmandu 44600, Nepal</li>
            <li><i class="fas fa-phone"></i> +977 1-23456789</li>
            <li><i class="fas fa-envelope"></i> info@woofsandwhiskers.com</li>
          </ul>
        </div>
        
        <div class="footer-column">
          <h3>Our Location</h3>
          <div class="footer-map">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.025597893126!2d85.32064327520194!3d27.717245027703195!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190d79aee9b9%3A0x4f0b07c7df1a0b3!2sLazimpat%2C%20Kathmandu%2044600!5e0!3m2!1sen!2snp!4v1714723943215!5m2!1sen!2snp" allowfullscreen="" loading="lazy"></iframe>
          </div>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>© 2025 Woofs&Whiskers. All rights reserved. | Designed with <i class="fas fa-heart"></i> for pet lovers</p>
      </div>
    </footer>
  </div>

  <script>
    // Add event listener for image error handling
    document.addEventListener('DOMContentLoaded', function() {
      const images = document.querySelectorAll('img.profile-pic-small');
      images.forEach(function(img) {
        img.addEventListener('error', function() {
          console.log('Image failed to load: ' + this.src);
          if (!this.src.includes('default-profile.png')) {
            this.src = '${pageContext.request.contextPath}/resources/images/default-profile.png';
          }
        });
      });
    });
  </script>
</body>
</html>