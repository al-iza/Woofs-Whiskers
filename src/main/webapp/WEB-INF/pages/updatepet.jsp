<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Pet - Woofs&Whiskers</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/updatepet.css">
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
                    <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/managepets">Manage Pets</a></li>
                    <li><a href="${pageContext.request.contextPath}/addnewpet">Add a Pet</a></li>
                    <li><a href="${pageContext.request.contextPath}/updatepet" class="active">Update Pet</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                </ul>
                <div class="admin-actions">
                    <div class="notification">
                        <i class="fas fa-bell"></i>
                        <div class="badge"></div>
                    </div>
                    <div class="profile-header">
                        <div class="profile-pic-small"></div>
                        <span>Admin Name</span>
                    </div>
                    <div class="dark-mode-icon" onclick="toggleDarkMode()">
                        <i class="fas fa-moon"></i>
                    </div>
                </div>
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Display error message if any -->
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-error">
                    ${requestScope.error}
                </div>
            </c:if>
            
            <div class="update-pet-container">
                <div class="container-header">
                    <div class="header-action">
                        <h2>
                            <i class="fas fa-paw"></i> Update Pet
                            <span class="pet-id-badge"><i class="fas fa-tag"></i> ${pet.petId}</span>
                        </h2>
                        <button class="delete-button" onclick="confirmDelete('${pet.petId}', '${pet.petName}')" title="Delete Pet">
                            <i class="fas fa-trash-alt"></i> Delete Pet
                        </button>
                    </div>
                </div>
                
                <div class="container-body">
                    <div class="add-pet-form">
                        <form class="pet-details-form" method="POST" action="${pageContext.request.contextPath}/updatepet" enctype="multipart/form-data">
                            <div class="form-section">
                                <h3 class="form-section-title">
                                    <i class="fas fa-info-circle"></i> Basic Information
                                </h3>
                            </div>
                            
                            <div class="form-group">
                                <label for="petID"><i class="fas fa-tag"></i> Pet ID</label>
                                <input type="text" id="petID" name="petID" value="${pet.petId}" readonly>
                            </div>
                            
                            <div class="form-group">
                                <label for "petName"><i class="fas fa-font"></i> Name</label>
                                <input type="text" id="petName" name="petName" value="${pet.petName}" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="category"><i class="fas fa-list"></i> Pet Category</label>
                                <select id="category" name="category" required>
                                    <option value="Dog" ${pet.petCategory eq 'Dog' ? 'selected' : ''}>Dog</option>
                                    <option value="Cat" ${pet.petCategory eq 'Cat' ? 'selected' : ''}>Cat</option>
                                    <option value="Bird" ${pet.petCategory eq 'Bird' ? 'selected' : ''}>Bird</option>
                                    <option value="Fish" ${pet.petCategory eq 'Fish' ? 'selected' : ''}>Fish</option>
                                    <option value="Small Animal" ${pet.petCategory eq 'Small Animal' ? 'selected' : ''}>Small Animal</option>
                                    <option value="Reptile" ${pet.petCategory eq 'Reptile' ? 'selected' : ''}>Reptile</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="breed"><i class="fas fa-certificate"></i> Breed</label>
                                <input type="text" id="breed" name="breed" value="${pet.breed}" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="petImage" class="combined-image-container">
                                    <div id="imageUploadUI" class="image-upload-ui">
                                        <i class="fas fa-cloud-upload-alt upload-icon"></i>
                                        <div class="upload-text">
                                            <h3>Update Pet Image</h3>
                                            <p>Click to upload a new photo</p>
                                            <p>Recommended: 800×600px (JPG, PNG)</p>
                                        </div>
                                    </div>
                                    <img id="previewImage" src="${pageContext.request.contextPath}/resources/images/user/${pet.petImageUrl}" alt="Pet Image Preview" class="preview-image">
                                    <div class="image-overlay">
                                        <i class="fas fa-search-plus fa-2x"></i>
                                    </div>
                                </label>
                                <input type="file" id="petImage" name="petImage" accept="image/*" hidden>
                            </div>
                            
                            <div class="form-section">
                                <h3 class="form-section-title">
                                    <i class="fas fa-paw"></i> Pet Characteristics
                                </h3>
                            </div>
                            
                            <div class="form-group">
                                <label for="age"><i class="fas fa-birthday-cake"></i> Age</label>
                                <input type="number" id="age" name="age" value="${pet.age}" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="gender"><i class="fas fa-venus-mars"></i> Gender</label>
                                <select id="gender" name="gender" required>
                                    <option value="Male" ${pet.gender eq 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${pet.gender eq 'Female' ? 'selected' : ''}>Female</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="color"><i class="fas fa-palette"></i> Color</label>
                                <input type="text" id="color" name="color" value="${pet.color}">
                            </div>
                            
                            <div class="form-group">
                                <label for="size"><i class="fas fa-arrows-alt-v"></i> Size</label>
                                <select id="size" name="size">
                                    <option value="Tiny" ${pet.size eq 'Tiny' ? 'selected' : ''}>Tiny</option>
                                    <option value="Small" ${pet.size eq 'Small' ? 'selected' : ''}>Small</option>
                                    <option value="Medium" ${pet.size eq 'Medium' ? 'selected' : ''}>Medium</option>
                                    <option value="Large" ${pet.size eq 'Large' ? 'selected' : ''}>Large</option>
                                    <option value="Extra Large" ${pet.size eq 'Extra Large' ? 'selected' : ''}>Extra Large</option>
                                </select>
                            </div>
                            
                            <div class="form-section">
                                <h3 class="form-section-title">
                                    <i class="fas fa-dollar-sign"></i> Adoption Details
                                </h3>
                            </div>
                            
                            <div class="form-group">
                                <label for="fees"><i class="fas fa-tag"></i> Adoption Fees ($)</label>
                                <input type="number" id="fees" name="fees" value="${pet.adoptionFees}">
                            </div>
                            
                            <div class="form-group full-width">
                                <label for="description"><i class="fas fa-align-left"></i> Pet Description</label>
                                <textarea id="description" name="description" rows="4">${pet.petDescription}</textarea>
                            </div>
                            
                            <div class="form-actions">
                                <a href="${pageContext.request.contextPath}/managepets" class="btn btn-outline">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Save Updates
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3 class="footer-title">Admin Tools</h3>
                    <ul class="footer-links">
                        <li>
                            <a href="${pageContext.request.contextPath}/managepets">
                                <i class="fas fa-paw"></i>
                                Manage Animals
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-users"></i>
                                User Management
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-cog"></i>
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
                                <i class="fas fa-question-circle"></i>
                                Help Center
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-headset"></i>
                                Contact Support
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fas fa-book"></i>
                                User Guide
                            </a>
                        </li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3 class="footer-title">Admin Info</h3>
                    <div class="footer-contact">
                        <div class="contact-item">
                            <i class="fas fa-clock contact-icon"></i>
                            <span>Last Login: Today 10:00 AM</span>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-circle contact-icon"></i>
                            <span>Status: Online</span>
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
                © 2025 Woofs&Whiskers. All rights reserved.
            </div>
        </div>
    </footer>

    <!-- Script for dark mode toggle and image preview -->
    <script>
        function toggleDarkMode() {
            document.body.classList.toggle('dark-mode');
            const darkModeIcon = document.querySelector('.dark-mode-icon i');
            if (document.body.classList.contains('dark-mode')) {
                darkModeIcon.className = 'fas fa-sun';
            } else {
                darkModeIcon.className = 'fas fa-moon';
            }
        }

        // Image upload preview
        document.addEventListener('DOMContentLoaded', function() {
            const petImageInput = document.getElementById('petImage');
            const previewImage = document.getElementById('previewImage');
            const imageUploadUI = document.getElementById('imageUploadUI');
            
            // Check if there's an existing image
            if (previewImage.src && previewImage.src !== window.location.href) {
                previewImage.style.display = 'block';
                imageUploadUI.style.opacity = 0.3;
            } else {
                previewImage.style.display = 'none';
                imageUploadUI.style.opacity = 1;
            }
            
            petImageInput.addEventListener('change', function(event) {
                const file = event.target.files[0];
                
                if (file) {
                    const reader = new FileReader();
                    
                    reader.onload = function(e) {
                        previewImage.src = e.target.result;
                        previewImage.style.display = 'block';
                        imageUploadUI.style.opacity = 0.3;
                    }
                    
                    reader.readAsDataURL(file);
                }
            });
        });
        
        // Delete confirmation
        function confirmDelete(petId, petName) {
            if (confirm('Are you sure you want to delete ' + petName + '?')) {
                // Create a form and submit it to the server
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/updatepet';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                const petIdInput = document.createElement('input');
                petIdInput.type = 'hidden';
                petIdInput.name = 'id';
                petIdInput.value = petId;
                
                form.appendChild(actionInput);
                form.appendChild(petIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>