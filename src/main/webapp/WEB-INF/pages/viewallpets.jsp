<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Woofs & Whiskers - View All Pets</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewallpets.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
  <header>
    <div class="logo">
      <h1>Woofs&Whiskers</h1>
    </div>
    <nav>
      <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/viewallpets" class="active">View Pets</a></li>
        <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
        <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
      </ul>
      <div class="user-actions">
        <div class="dark-mode-icon" onclick="toggleDarkMode()"><i class="fas fa-moon"></i></div>
      </div>
    </nav>
  </header>

  <div class="container">
    <h1 class="page-title">View All Pets</h1>
    
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
    
    <section class="filter-section">
      <h2 class="filter-title">
        <i class="fas fa-filter filter-icon"></i>
        Filter Pets
      </h2>
      <div class="filter-container">
        <div class="filter-group">
          <label class="filter-label" for="sort-gender">Gender</label>
          <select class="filter-input" id="sort-gender">
            <option value="">All Genders</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
          </select>
        </div>
        
        <div class="filter-group">
          <label class="filter-label" for="sort-category">Category</label>
          <select class="filter-input" id="sort-category">
            <option value="">All Categories</option>
            <option value="Dog">Dog</option>
            <option value="Cat">Cat</option>
            <option value="Fish">Fish</option>
            <option value="Bird">Bird</option>
            <option value="Small Animal">Small Animal</option>
            <option value="Reptile">Reptile</option>
          </select>
        </div>
        
        <div class="filter-group search-group">
          <label class="filter-label" for="search-pet">Search</label>
          <input type="text" class="filter-input" id="search-pet" placeholder="Search by pet name">
          <i class="fas fa-search search-icon"></i>
        </div>
      </div>
    </section>
    
    <div class="pet-gallery" id="pet-gallery">
      <c:choose>
        <c:when test="${empty allPets}">
          <div class="no-pets" style="display: block;">
            <i class="fas fa-paw" style="font-size: 100px; color: #863434;"></i>
            <h3>No Pets Found</h3>
            <p>Try adjusting your search or filters to find what you're looking for.</p>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach var="pet" items="${allPets}">
            <div class="pet-card" data-name="${pet.petName.toLowerCase()}" data-category="${pet.petCategory.toLowerCase()}" data-gender="${pet.gender.toLowerCase()}">
              <c:choose>
                <c:when test="${not empty pet.petImageUrl}">
                  <img src="${pageContext.request.contextPath}/resources/images/user/${pet.petImageUrl}" alt="${pet.petName}" class="pet-image" onerror="this.src='${pageContext.request.contextPath}/resources/images/user/pet-placeholder.jpg'">
                </c:when>
                <c:otherwise>
                  <img src="${pageContext.request.contextPath}/resources/images/user/pet-placeholder.jpg" alt="${pet.petName}" class="pet-image">
                </c:otherwise>
              </c:choose>
              <div class="pet-details">
                <h3 class="pet-name">${pet.petName}</h3>
                <div class="pet-info">
                  <span class="info-tag">
                    <i class="fas fa-paw"></i>
                    ${pet.petCategory}
                  </span>
                  <span class="info-tag">
                    <i class="fas ${pet.gender eq 'Male' ? 'fa-mars' : 'fa-venus'}"></i>
                    ${pet.gender}
                  </span>
                  <span class="info-tag">
                    <i class="fas fa-dog"></i>
                    ${pet.breed}
                  </span>
                  <span class="info-tag">
                    <i class="fas fa-clock"></i>
                    ${pet.age} ${pet.age eq 1 ? 'year' : 'years'}
                  </span>
                </div>
                <div class="pet-price">$${pet.adoptionFees}</div>
                <div class="pet-actions">
                  <a href="${pageContext.request.contextPath}/petdetails?id=${pet.petId}" class="pet-btn view-btn">
                    <i class="fas fa-eye"></i>
                    View Details
                  </a>
                  <a href="${pageContext.request.contextPath}/adoptpet?id=${pet.petId}" class="pet-btn adopt-btn">
                    <i class="fas fa-heart"></i>
                    Adopt
                  </a>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
    
    <div class="pagination">
      <button class="page-btn" id="viewMoreBtn" onclick="showMorePets()">
        <i class="fas fa-chevron-down"></i>
        View More
      </button>
      <button class="page-btn" id="viewLessBtn" onclick="showLessPets()" style="display: none;">
        <i class="fas fa-chevron-up"></i>
        View Less
      </button>
    </div>
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
            <i class="fas fa-envelope contact-icon"></i>
            <span>info@woofswhiskers.com</span>
          </div>
          <div class="contact-item">
            <i class="fas fa-phone contact-icon"></i>
            <span>+977-1-1234567</span>
          </div>
        </div>
        
        <div class="footer-social">
          <a href="https://www.facebook.com" target="_blank" class="social-link">
            <i class="fab fa-facebook-f social-icon"></i>
          </a>
          <a href="https://www.instagram.com" target="_blank" class="social-link">
            <i class="fab fa-instagram social-icon"></i>
          </a>
          <a href="https://www.twitter.com" target="_blank" class="social-link">
            <i class="fab fa-twitter social-icon"></i>
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
      const darkModeIcon = document.querySelector('.dark-mode-icon i');
      darkModeIcon.className = document.body.classList.contains('dark-mode') ? 'fas fa-sun' : 'fas fa-moon';
    }
    
    // Client-side filtering
    const sortGender = document.getElementById('sort-gender');
    const sortCategory = document.getElementById('sort-category');
    const searchPet = document.getElementById('search-pet');
    const petGallery = document.getElementById('pet-gallery');
    const viewMoreBtn = document.getElementById('viewMoreBtn');
    const viewLessBtn = document.getElementById('viewLessBtn');
    
    let visibleCount = 12;
    
    function filterPets() {
      const gender = sortGender.value.toLowerCase();
      const category = sortCategory.value.toLowerCase();
      const nameSearch = searchPet.value.toLowerCase();
      
      const petCards = document.querySelectorAll('.pet-card');
      let shown = 0;
      let matchedCount = 0;
      
      petCards.forEach(card => {
        const cardGender = card.getAttribute('data-gender');
        const cardCategory = card.getAttribute('data-category');
        const cardName = card.getAttribute('data-name');
        
        const genderMatch = !gender || cardGender === gender;
        const categoryMatch = !category || cardCategory === category;
        const nameMatch = !nameSearch || cardName.includes(nameSearch);
        
        if (genderMatch && categoryMatch && nameMatch) {
          matchedCount++;
          if (shown < visibleCount) {
            card.style.display = 'block';
            shown++;
          } else {
            card.style.display = 'none';
          }
        } else {
          card.style.display = 'none';
        }
      });
      
      // Show no pets message if no matches
      const noPetsMessage = document.querySelector('.no-pets');
      if (noPetsMessage) {
        if (matchedCount === 0) {
          noPetsMessage.style.display = 'block';
        } else {
          noPetsMessage.style.display = 'none';
        }
      }
      
      // Update buttons visibility
      viewMoreBtn.style.display = (shown < matchedCount) ? 'block' : 'none';
      viewLessBtn.style.display = (visibleCount > 12 && matchedCount > 0) ? 'block' : 'none';
    }
    
    function showMorePets() {
      visibleCount += 5;
      filterPets();
    }
    
    function showLessPets() {
      visibleCount = 12;
      filterPets();
    }
    
    // Add event listeners
    if (sortGender) sortGender.addEventListener('change', filterPets);
    if (sortCategory) sortCategory.addEventListener('change', filterPets);
    if (searchPet) searchPet.addEventListener('input', filterPets);
    
    // Initialize filtering
    document.addEventListener('DOMContentLoaded', function() {
      // Filter pets after DOM is fully loaded
      filterPets();
    });
  </script>
</body>
</html>