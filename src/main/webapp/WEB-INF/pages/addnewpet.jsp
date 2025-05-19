D<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Pets - Woofs&Whiskers</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/addnewpet.css">
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
					<li><a href="${pageContext.request.contextPath}/admindashboard">Dashboard</a></li>
					<li><a href="${pageContext.request.contextPath}/managepets">Manage Pets</a></li>
					<li><a href="${pageContext.request.contextPath}/addnewpet" class="active">Add a Pet</a></li>
					<li><a href="${pageContext.request.contextPath}/managepets">Update Pet</a></li>
					<li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
					<li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
					<li><a href="${pageContext.request.contextPath}/login">Logout</a></li>
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
			<div class="page-title">
				<h2>Add a New Pet</h2>
				<p>Complete the form below to add a new pet to the Woofs&Whiskers family.</p>
			</div>

			<div class="add-pet-card">
				<div class="add-pet-form">
					<div class="details-section">
						<h3 class="form-title">
							<i class="fas fa-paw"></i> Pet Details
						</h3>

						<form class="pet-details-form"
							action="${pageContext.request.contextPath}/addnewpet"
							method="post" enctype="multipart/form-data">
							<div class="form-group image-upload-section full-width">
								<label for="petImage" class="image-upload-preview-box">
									<div id="uploadUI" class="upload-ui">
										<i class="fas fa-cloud-upload-alt upload-icon"></i>
										<div class="upload-text">
											<h3>Upload Pet Image</h3>
											<p>Drag & drop or click to browse</p>
											<p>Recommended: 800x600px, JPG or PNG</p>
										</div>
									</div> <img src="" alt="Preview" id="previewImage"
									class="preview-image">
								</label> <input type="file" id="petImage" name="petImage"
									accept="image/*" hidden required>
							</div>

							<div class="form-group">
								<label for="petID">Pet ID</label>
								<input type="text" id="petID" name="petID" placeholder="e.g., DOG-001"
									value="${petID}" required>
							</div>

							<div class="form-group">
								<label for="petName">Name</label>
								<input type="text" id="petName" name="petName" placeholder="Pet's name"
									value="${petName}" required>
							</div>

							<div class="form-group">
								<label for="category">Pet Category</label>
								<select id="category" name="category" required>
									<option value="">Select Category</option>
									<option value="Dog" ${petCategory == 'Dog' ? 'selected' : ''}>Dog</option>
									<option value="Cat" ${petCategory == 'Cat' ? 'selected' : ''}>Cat</option>
									<option value="Bird" ${petCategory == 'Bird' ? 'selected' : ''}>Bird</option>
									<option value="Fish" ${petCategory == 'Fish' ? 'selected' : ''}>Fish</option>
								</select>
							</div>

							<div class="form-group">
								<label for="breed">Breed</label>
								<input type="text" id="breed" name="breed" placeholder="Pet's breed"
									value="${breed}" required>
							</div>

							<h4 class="section-title">
								<i class="fas fa-info-circle"></i> Characteristics
							</h4>

							<div class="form-group">
								<label for="age">Age (years)</label>
								<input type="number" id="age" name="age" min="0" step="0.1"
									placeholder="e.g., 2.5" value="${age}" required>
							</div>

							<div class="form-group">
								<label for="gender">Gender</label>
								<select id="gender" name="gender" required>
									<option value="">Select Gender</option>
									<option value="Male" ${gender == 'Male' ? 'selected' : ''}>Male</option>
									<option value="Female" ${gender == 'Female' ? 'selected' : ''}>Female</option>
								</select>
							</div>

							<div class="form-group">
								<label for="color">Color</label>
								<input type="text" id="color" name="color" placeholder="Pet's color"
									value="${color}">
							</div>

							<div class="form-group">
								<label for="size">Size</label>
								<select id="size" name="size">
									<option value="">Select Size</option>
									<option value="Tiny" ${size == 'Tiny' ? 'selected' : ''}>Tiny</option>
									<option value="Small" ${size == 'Small' ? 'selected' : ''}>Small</option>
									<option value="Medium" ${size == 'Medium' ? 'selected' : ''}>Medium</option>
									<option value="Large" ${size == 'Large' ? 'selected' : ''}>Large</option>
									<option value="Extra Large" ${size == 'Extra Large' ? 'selected' : ''}>Extra Large</option>
								</select>
							</div>

							<h4 class="section-title">
								<i class="fas fa-dollar-sign"></i> Adoption Details
							</h4>

							<div class="form-group">
								<label for="fees">Adoption Fees ($)</label>
								<input type="number" id="fees" name="fees" min="0" step="0.01"
									placeholder="e.g., 120.00" value="${fees}">
							</div>

							<div class="form-group full-width">
								<label for="description">Pet Description</label>
								<textarea id="description" name="description" rows="4"
									placeholder="Describe the pet's personality, history, special needs, etc.">${description}</textarea>
							</div>

							<div class="form-buttons">
								<button type="button" class="btn btn-outline">
									<i class="fas fa-times"></i> Cancel
								</button>
								<button type="submit" class="btn btn-primary">
									<i class="fas fa-save"></i> Save Pet
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
						<li><a href="#"><i class="fas fa-paw"></i> Manage Animals</a></li>
						<li><a href="#"><i class="fas fa-users"></i> User Management</a></li>
						<li><a href="#"><i class="fas fa-cog"></i> System Settings</a></li>
					</ul>
				</div>

				<div class="footer-section">
					<h3 class="footer-title">Admin Support</h3>
					<ul class="footer-links">
						<li><a href="#"><i class="fas fa-question-circle"></i> Help Center</a></li>
						<li><a href="#"><i class="fas fa-headset"></i> Contact Support</a></li>
						<li><a href="#"><i class="fas fa-book"></i> User Guide</a></li>
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
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.025597893126!2d85.32064327520194!3d27.717245027703195!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190d79aee9b9%3A0x4f0b07c7df1a0b3!2sLazimpat%2C%20Kathmandu%2044600!5e0!3m2!1sen!2snp!4v1714723943215!5m2!1sen!2snp"
							allowfullscreen="" loading="lazy"></iframe>
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

		// Image upload and preview functionality
		document.addEventListener('DOMContentLoaded', function() {
			const petImageInput = document.getElementById('petImage');
			const previewImage = document.getElementById('previewImage');
			const uploadUI = document.getElementById('uploadUI');

			petImageInput.addEventListener('change', function(event) {
				const file = event.target.files[0];

				if (file) {
					const reader = new FileReader();

					reader.onload = function(e) {
						previewImage.src = e.target.result;
						previewImage.style.display = 'block';
						uploadUI.style.opacity = '0.2'; // Show upload UI with reduced opacity
					}

					reader.readAsDataURL(file);
				} else {
					previewImage.src = '';
					previewImage.style.display = 'none';
					uploadUI.style.opacity = '1';
				}
			});

			// Display error or success message in alert
			<c:if test="${not empty error}">
				alert("${error}");
			</c:if>
			<c:if test="${not empty success}">
				alert("${success}");
				// Redirect to viewallpets.jsp after alert
				window.location.href = "${pageContext.request.contextPath}/viewallpets";
			</c:if>
		});
	</script>
</body>
</html>