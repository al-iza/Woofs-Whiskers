S
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Woofs&Whiskers - Profile</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
</head>
<body>
  
  <!-- Header -->
  <header>
    <div class="container">
      <div class="logo">
        <h1>Woofs&Whiskers</h1>
      </div>
      <nav>
        <ul class="nav-links">
          <li><a href="${pageContext.request.contextPath}/userdashboard">Dashboard</a></li>
          <li><a href="${pageContext.request.contextPath}/managepets">Manage Pets</a></li>
          <li><a href="${pageContext.request.contextPath}/addpet">Add a Pet</a></li>
          <li><a href="${pageContext.request.contextPath}/updatepet">Update Pet</a></li>
          <li><a href="${pageContext.request.contextPath}/profile" class="active">Profile</a></li>
          <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
          <li><form id="logoutForm" action="${pageContext.request.contextPath}/logout" method="POST" style="display: inline;">
            <a href="#" onclick="document.getElementById('logoutForm').submit(); return false;">Logout</a>
          </form></li>
        </ul>
        <div class="admin-actions">
          <div class="notification">
            <i class="fas fa-bell"></i>
            <div class="badge"></div>
          </div>
          <div class="profile-header">
            <!-- Use img tag for small profile pic -->
            <img src="${pageContext.request.contextPath}/resources/images/user/${user.imageUrl != null ? user.imageUrl : 'default-profile.png'}" 
                 alt="Profile" 
                 class="profile-pic-small"
                 onerror="this.src='${pageContext.request.contextPath}/resources/images/default-profile.png';">
            <span>${user.fullName != null ? user.fullName : "User"}</span>
          </div>
          <div class="dark-mode-icon" onclick="toggleDarkMode()">
            <i class="fas fa-moon"></i>
          </div>
        </div>
      </nav>
    </div>
  </header>

  <!-- Main Content - Profile Section -->
  <main class="main-content">
    <div class="container">
      <div class="profile-container">
        <div class="profile-header-banner"></div>
        <div class="profile-header-content">
          <div class="profile-picture-container">
            <!-- Use img tag for main profile pic -->
            <img id="profilePic" 
                 src="${pageContext.request.contextPath}/resources/images/user/${user.imageUrl != null ? user.imageUrl : 'default-profile.png'}" 
                 alt="Profile Picture" 
                 class="profile-picture"
                 onerror="this.src='${pageContext.request.contextPath}/resources/images/default-profile.png';">
            <label for="fileUpload" class="profile-upload-icon">
              <i class="fas fa-camera"></i>
            </label>
            <input type="file" id="fileUpload" accept="image/*" style="display: none;" onchange="updateProfilePic()">
          </div>
          <div class="profile-title">
            <h2>Profile Settings</h2>
            <p>Manage your account information and settings</p>
          </div>
        </div>
        
        <div class="profile-form-container">
          <!-- Display message if exists -->
          <c:if test="${not empty message}">
            <div class="message ${message.contains('success') ? 'success' : 'error'}">
              ${message}
            </div>
          </c:if>

          <!-- Debug information (remove in production) -->
          <div class="debug-info" style="background-color: #f8f9fa; padding: 10px; margin-bottom: 20px; border: 1px solid #ddd; border-radius: 5px; font-family: monospace; font-size: 12px;">
            <p><strong>Username:</strong> ${user.username}</p>
            <p><strong>Current ImageUrl:</strong> ${user.imageUrl}</p>
          </div>
          
          <form class="profile-form" action="${pageContext.request.contextPath}/profile" method="POST" enctype="multipart/form-data" onsubmit="return validateProfileForm()">
            <div class="form-section">
              <h3 class="form-section-title">
                <i class="fas fa-user"></i> Account Information
              </h3>
              <div class="form-row">
                <div class="form-group">
                  <label for="username">Username</label>
                  <input type="text" id="username" name="username" value="${user.username}" readonly>
                  <small>Username cannot be changed</small>
                </div>
                <div class="form-group">
                  <label for="email">Email</label>
                  <input type="email" id="email" name="email" value="${user.email}" required>
                </div>
              </div>
              <div class="form-row">
                <div class="form-group">
                  <label for="fullName">Full Name</label>
                  <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
                </div>
              </div>
            </div>
            
            <div class="form-section">
              <h3 class="form-section-title">
                <i class="fas fa-address-card"></i> Personal Information
              </h3>
              <div class="form-row">
                <div class="form-group">
                  <label for="address">Address</label>
                  <input type="text" id="address" name="address" value="${user.address}">
                </div>
                <div class="form-group">
                  <label for="number">Contact</label>
                  <input type="tel" id="number" name="number" value="${user.number}" required>
                </div>
              </div>
              <div class="form-row">
                <div class="form-group">
                  <label for="gender">Gender</label>
                  <select id="gender" name="gender" required>
                    <option value="">Select</option>
                    <option value="male" ${user.gender == 'male' ? 'selected' : ''}>Male</option>
                    <option value="female" ${user.gender == 'female' ? 'selected' : ''}>Female</option>
                    <option value="other" ${user.gender == 'other' ? 'selected' : ''}>Other</option>
                  </select>
                </div>
                <div class="form-group">
                  <label for="dob">Date of Birth</label>
                  <input type="date" id="dob" name="dob" value="${user.dob}" required>
                </div>
              </div>
            </div>
            
            <div class="form-section">
              <h3 class="form-section-title">
                <i class="fas fa-image"></i> Profile Picture
              </h3>
              <div class="form-group">
                <label>Upload New Profile Picture</label>
                <div class="file-input-wrapper">
                  <div class="file-input-button">
                    <i class="fas fa-upload"></i> Choose File
                  </div>
                  <input type="file" name="profilePic" id="profilePicInput" accept="image/*" onchange="previewProfileImage(this)">
                  <small>Current image: ${user.imageUrl != null ? user.imageUrl : 'default-profile.png'}</small>
                </div>
              </div>
            </div>
            
            <div class="form-buttons">
              <button type="button" class="btn btn-outline" onclick="window.location.href='${pageContext.request.contextPath}/userdashboard'">Cancel</button>
              <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </main>

  <!-- Footer -->
  <footer>
    <div class="container">
      <div class="footer-content">
        <div class="footer-section">
          <h3 class="footer-title">Quick Links</h3>
          <ul class="footer-links">
            <li>
              <a href="${pageContext.request.contextPath}/userdashboard">
                <i class="fas fa-home"></i>
                Dashboard
              </a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/managepets">
                <i class="fas fa-paw"></i>
                Manage Pets
              </a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/profile">
                <i class="fas fa-user"></i>
                Profile
              </a>
            </li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h3 class="footer-title">Support</h3>
          <ul class="footer-links">
            <li>
              <a href="${pageContext.request.contextPath}/help">
                <i class="fas fa-question-circle"></i>
                Help Center
              </a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/contact">
                <i class="fas fa-headset"></i>
                Contact Us
              </a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/faq">
                <i class="fas fa-book"></i>
                FAQs
              </a>
            </li>
          </ul>
        </div>
        
        <div class="footer-section">
          <h3 class="footer-title">Contact Info</h3>
          <div class="footer-contact">
            <div class="contact-item">
              <i class="fas fa-map-marker-alt contact-icon"></i>
              <span>Lazimpat, Kathmandu, Nepal</span>
            </div>
            <div class="contact-item">
              <i class="fas fa-phone contact-icon"></i>
              <span>+977 9841234567</span>
            </div>
            <div class="contact-item">
              <i class="fas fa-envelope contact-icon"></i>
              <span>info@woofsandwhiskers.com</span>
            </div>
          </div>
        </div>
        
        <div class="footer-section">
          <h3 class="footer-title">Our Location</h3>
          <div class="footer-map">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.025597893126!2d85.32064327520194!3d27.717245027703195!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190d79aee9b9%3A0x4f0b07c7df1a0b3!2sLazimpat%2C%20Kathmandu%2044600!5e0!3m2!1sen!2snp!4v1714723943215!5m2!1sen!2snp" allowfullscreen="" loading="lazy"></iframe>
          </div>
        </div>
      </div>
      
      <div class="footer-social">
        <a href="https://www.facebook.com" target="_blank" class="social-link">
          <i class="fab fa-facebook-f"></i>
        </a>
        <a href="https://www.instagram.com" target="_blank" class="social-link">
          <i class="fab fa-instagram"></i>
        </a>
        <a href="https://www.twitter.com" target="_blank" class="social-link">
          <i class="fab fa-twitter"></i>
        </a>
      </div>
      
      <div class="footer-bottom">
        &copy; 2025 Woofs&Whiskers. All rights reserved.
      </div>
    </div>
  </footer>

  <script>
    // Prevent form resubmission on page refresh
    if (window.history.replaceState) {
      window.history.replaceState(null, null, window.location.href);
    }

    function toggleDarkMode() {
      document.body.classList.toggle('dark-mode');
      const darkModeIcon = document.querySelector('.dark-mode-icon i');
      if (document.body.classList.contains('dark-mode')) {
        darkModeIcon.className = 'fas fa-sun';
      } else {
        darkModeIcon.className = 'fas fa-moon';
      }
    }

    function updateProfilePic() {
      const file = document.getElementById("fileUpload").files[0];
      const reader = new FileReader();
      reader.onload = function (e) {
        document.getElementById("profilePic").src = e.target.result;
        
        // Also update the form file input
        if (file) {
          const profilePicInput = document.getElementById('profilePicInput');
          
          // Create a DataTransfer object
          const dataTransfer = new DataTransfer();
          dataTransfer.items.add(file);
          
          // Set the files property on the file input
          profilePicInput.files = dataTransfer.files;
        }
      };
      if (file) {
        reader.readAsDataURL(file);
      }
    }
    
    // Preview profile image when selected from the form
    function previewProfileImage(input) {
      if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
          document.getElementById('profilePic').src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
      }
    }
    
    // Form validation
    function validateProfileForm() {
      let isValid = true;
      
      // Validate full name
      const fullName = document.getElementById('fullName');
      if (fullName.value.trim() === '') {
        showError(fullName, 'Full Name is required');
        isValid = false;
      } else {
        clearError(fullName);
      }
      
      // Validate email
      const email = document.getElementById('email');
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(email.value.trim())) {
        showError(email, 'Please enter a valid email address');
        isValid = false;
      } else {
        clearError(email);
      }
      
      // Validate phone
      const number = document.getElementById('number');
      if (number.value.trim() === '') {
        showError(number, 'Contact number is required');
        isValid = false;
      } else {
        clearError(number);
      }
      
      // Validate gender
      const gender = document.getElementById('gender');
      if (gender.value === '') {
        showError(gender, 'Please select a gender');
        isValid = false;
      } else {
        clearError(gender);
      }
      
      // Validate date of birth
      const dob = document.getElementById('dob');
      if (dob.value === '') {
        showError(dob, 'Date of Birth is required');
        isValid = false;
      } else {
        clearError(dob);
      }
      
      return isValid;
    }
    
    // Helper function to show error message
    function showError(element, message) {
      clearError(element);
      const errorDiv = document.createElement('div');
      errorDiv.className = 'error-message';
      errorDiv.style.color = '#dc3545';
      errorDiv.style.fontSize = '0.85rem';
      errorDiv.style.marginTop = '5px';
      errorDiv.innerHTML = message;
      element.parentNode.appendChild(errorDiv);
      element.style.borderColor = '#dc3545';
    }
    
    // Helper function to clear error message
    function clearError(element) {
      const errorDiv = element.parentNode.querySelector('.error-message');
      if (errorDiv) {
        errorDiv.remove();
      }
      element.style.borderColor = '';
    }
    
    // Add event listener for document loaded
    document.addEventListener('DOMContentLoaded', function() {
      // Fix for image loading errors
      const images = document.querySelectorAll('img');
      images.forEach(function(img) {
        img.addEventListener('error', function() {
          console.log('Image failed to load: ' + this.src);
          if (!this.src.includes('default-profile.png')) {
            this.src = '${pageContext.request.contextPath}/resources/images/default-profile.png';
          }
        });
      });
      
      // Auto hide messages after 5 seconds
      const message = document.querySelector('.message');
      if (message) {
        setTimeout(function() {
          message.style.opacity = '0';
          setTimeout(function() {
            message.style.display = 'none';
          }, 500);
        }, 5000);
      }
    });
  </script>
  
  <style>
    /* Add styles for success/error messages */
    .message {
      padding: 12px 20px;
      border-radius: 8px;
      margin-bottom: 20px;
      text-align: center;
      font-weight: 500;
      opacity: 1;
      transition: opacity 0.5s ease;
    }
    
    .message.success {
      background-color: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }
    
    .message.error {
      background-color: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }
    
    /* Additional form validation styles */
    .error-message {
      margin-top: 5px;
      color: #dc3545;
      font-size: 0.85rem;
    }
    
    input:invalid, select:invalid {
      border-color: #dc3545;
    }
  </style>
</body>
</html>