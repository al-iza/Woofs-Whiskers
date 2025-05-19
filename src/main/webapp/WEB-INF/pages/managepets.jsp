<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Woofs & Whiskers - Pet Management</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/managepets.css">
</head>
<body>
  <header>
    <div class="logo">
      <h1>Woofs&Whiskers</h1>
    </div>
    <nav>
      <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/admindashboard">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/managepets" class="active">Manage Pets</a></li>
        <li><a href="${pageContext.request.contextPath}/addnewpet">Add a Pet</a></li>
        <li><a href="${pageContext.request.contextPath}/updatepet">Update Pet</a></li>
        <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
        <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
      </ul>
      <div class="admin-actions">
        <div class="notification">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
            <path d="M12 24c1.1 0 2-.9 2-2h-4a2 2 0 0 0 2 2zm6.4-6V11c0-3.1-1.6-5.6-4.4-6.3V4a2 2 0 0 0-4 0v.7C7.2 5.4 5.6 7.9 5.6 11v7L4 19v1h16v-1l-1.6-1z"/>
          </svg>
        </div>
        <div class="profile-header">
          <div class="profile-pic-small"></div>
          <span>Admin</span>
        </div>
        <div class="dark-mode-icon" onclick="toggleDarkMode()">🌙</div>
      </div>
    </nav>
  </header>

  <div class="container">
    <h1 class="page-title">Manage Pets</h1>
    
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
        <svg class="filter-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
        </svg>
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
          <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"></circle>
            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
          </svg>
        </div>
      </div>
    </section>
    
    <div class="pet-gallery" id="pet-gallery">
      <c:choose>
        <c:when test="${empty allPets}">
          <div class="no-pets" style="display: block;">
            <img src="https://img.icons8.com/ios/200/paw-print.png" alt="No pets found">
            <h3>No Pets Found</h3>
            <p>Try adjusting your search or filters to find what you're looking for.</p>
            <a href="${pageContext.request.contextPath}/addnewpet" class="add-new-btn">Add New Pet</a>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach var="pet" items="${allPets}">
            <div class="pet-card" data-name="${pet.petName.toLowerCase()}" data-category="${pet.petCategory.toLowerCase()}" data-gender="${pet.gender.toLowerCase()}">
              <c:choose>
                <c:when test="${not empty pet.petImageUrl}">
                  <!-- Updated image path to use the correct resources/images/user directory -->
                  <img src="${pageContext.request.contextPath}/resources/images/user/${pet.petImageUrl}" alt="${pet.petName}" class="pet-image">
                </c:when>
                <c:otherwise>
                  <img src="${pageContext.request.contextPath}/images/pet-placeholder.jpg" alt="${pet.petName}" class="pet-image">
                </c:otherwise>
              </c:choose>
              <div class="pet-details">
                <h3 class="pet-name">${pet.petName}</h3>
                <div class="pet-info">
                  <span class="info-tag">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                      <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78L12 21.23l8.84-8.84a5.5 5.5 0 0 0 0-7.78z"></path>
                    </svg>
                    ${pet.petCategory}
                  </span>
                  <span class="info-tag">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                      <c:choose>
                        <c:when test="${pet.gender eq 'Male'}">
                          <circle cx="12" cy="7" r="4"></circle><path d="M12 11v8"></path><path d="M9 18h6"></path>
                        </c:when>
                        <c:otherwise>
                          <circle cx="12" cy="8" r="4"></circle><path d="M12 12v8"></path><path d="M9 16h6"></path><path d="M12 16c-1.5 0-3 0.5-3 2v1c0 1.5 1.5 2 3 2s3-0.5 3-2v-1c0-1.5-1.5-2-3-2z"></path>
                        </c:otherwise>
                      </c:choose>
                    </svg>
                    ${pet.gender}
                  </span>
                  <span class="info-tag">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                      <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"></path>
                      <circle cx="12" cy="10" r="3"></circle>
                    </svg>
                    ${pet.breed}
                  </span>
                  <span class="info-tag">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                      <circle cx="12" cy="12" r="10"></circle>
                      <polyline points="12 6 12 12 16 14"></polyline>
                    </svg>
                    ${pet.age} ${pet.age eq 1 ? 'year' : 'years'}
                  </span>
                </div>
                <div class="pet-price">$${pet.adoptionFees}</div>
                <div class="pet-actions">
                  <a href="${pageContext.request.contextPath}/updatepet?id=${pet.petId}" class="pet-btn edit-btn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                      <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                      <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                    </svg>
                    Edit
                  </a>
                  <form action="${pageContext.request.contextPath}/managepets" method="post" onsubmit="return confirmDelete('${pet.petName}')">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="petId" value="${pet.petId}">
                    <button type="submit" class="pet-btn delete-btn">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="3 6 5 6 21 6"></polyline>
                        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                        <line x1="10" y1="11" x2="10" y2="17"></line>
                        <line x1="14" y1="11" x2="14" y2="17"></line>
                      </svg>
                      Delete
                    </button>
                  </form>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
    
    <div class="pagination">
      <button class="page-btn" id="viewMoreBtn" onclick="showMorePets()">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="6 9 12 15 18 9"></polyline>
        </svg>
        View More
      </button>
      <button class="page-btn" id="viewLessBtn" onclick="showLessPets()" style="display: none;">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="18 15 12 9 6 15"></polyline>
        </svg>
        View Less
      </button>
    </div>
  </div>

  <footer>
    <div class="footer-content">
      <div class="footer-section">
        <h3 class="footer-title">Admin Tools</h3>
        <ul class="footer-links">
          <li>
            <a href="${pageContext.request.contextPath}/managepets">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 16V7a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2v9m16 0H4m16 0l-1.58-5.27A2 2 0 0 0 16.54 9H7.46a2 2 0 0 0-1.88 1.73L4 16m16 0v2a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2v-2"></path>
              </svg>
              Manage Animals
            </a>
          </li>
          <li>
            <a href="#">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                <circle cx="9" cy="7" r="4"></circle>
                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
              </svg>
              User Management
            </a>
          </li>
          <li>
            <a href="#">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="12" cy="12" r="3"></circle>
                <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
              </svg>
              System Settings
            </a>
          </li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h3 class="footer-title">Admin Support</h3>
        <ul class="footer-links">
          <li>
            <a href="#">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="12" cy="12" r="10"></circle>
                <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                <line x1="12" y1="17" x2="12.01" y2="17"></line>
              </svg>
              Help & FAQ
            </a>
          </li>
          <li>
            <a href="#">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"></path>
              </svg>
              Contact Support
            </a>
          </li>
          <li>
            <a href="#">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
              </svg>
              User Guide
            </a>
          </li>
        </ul>
      </div>
      
      <div class="footer-section">
        <h3 class="footer-title">Admin Information</h3>
        <div class="footer-contact">
          <div class="contact-item">
            <svg class="contact-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="2" y="4" width="20" height="16" rx="2"></rect>
              <path d="M22 7l-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"></path>
            </svg>
            <span>admin@woofswhiskers.com</span>
          </div>
          <div class="contact-item">
            <svg class="contact-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="10"></circle>
              <circle cx="12" cy="10" r="3"></circle>
              <path d="M7 20.662V19a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1.662"></path>
            </svg>
            <span>Last Login: Today 10:00 AM</span>
          </div>
          <div class="contact-item">
            <svg class="contact-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M20 14.66V20a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h5.34"></path>
              <polygon points="18 2 22 6 12 16 8 16 8 12 18 2"></polygon>
            </svg>
            <span>Status: Online</span>
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
      &copy; 2025 Woofs&Whiskers. All rights reserved.
    </div>
  </footer>

  <script>
    // Add a simple image error handler to detect issues with image paths
    document.addEventListener('DOMContentLoaded', function() {
      const petImages = document.querySelectorAll('.pet-image');
      
      petImages.forEach(img => {
        img.onerror = function() {
          console.error('Failed to load image:', this.src);
          // Fall back to placeholder image if the main image fails to load
          this.src = '${pageContext.request.contextPath}/images/pet-placeholder.jpg';
        };
      });
    });
  
    function toggleDarkMode() {
      document.body.classList.toggle('dark-mode');
      const darkModeIcon = document.querySelector('.dark-mode-icon');
      darkModeIcon.innerHTML = document.body.classList.contains('dark-mode') ? '☀️' : '🌙';
    }
    
    function confirmDelete(petName) {
      return confirm('Are you sure you want to delete ' + petName + '?');
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