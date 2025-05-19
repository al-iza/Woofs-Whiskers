<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Register - Woofs&Whiskers</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
    <style>
        /* Additional style for left-aligned labels */
        label {
            text-align: left;
            margin-bottom: 5px;
            font-weight: 500;
        }
        
        small {
            display: block;
            text-align: left;
            margin-top: 3px;
            color: #666;
            font-size: 0.8em;
        }
    </style>
</head>

<body>
    <!-- Background Elements -->
    <div class="bg-shape bg-shape-1"></div>
    <div class="bg-shape bg-shape-2"></div>

    <!-- Animal silhouettes - slightly larger and more visible -->
    <div class="animal-icon animal-1">🐕</div>
    <div class="animal-icon animal-2">🐈</div>
    <div class="animal-icon animal-3">🐦</div>
    <div class="animal-icon animal-4">🐠</div>
    <div class="animal-icon animal-5">🐩</div>
    <div class="animal-icon animal-6">🐟</div>

    <!-- Paw prints -->
    <div class="paw-print paw-1">🐾</div>
    <div class="paw-print paw-2">🐾</div>
    <div class="paw-print paw-3">🐾</div>

    <!-- Header Brand -->
    <header class="top-left-brand">Woofs&Whiskers</header>

    <div class="container">
        <div class="register-box">
            <div class="logo">REGISTER</div>
            <div class="est">EST 2020</div>

            <div class="register-title">Create Your Account</div>
            
            <!-- Display error message if any -->
            <% if(request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="POST" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" class="input-field" id="username" placeholder="Username (4-20 chars, start with letter)" name="username" 
                           value="${username}" required minlength="4" maxlength="20">
                </div>
                <div class="form-group">
                    <label for="number">Phone Number</label>
                    <input type="number" class="input-field" id="number" placeholder="Phone Number (98xxxxxxxx)" name="number" 
                           value="${number}" required pattern="^98\d{8}$">
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="input-field" id="password" placeholder="Password (8+ chars, 1 uppercase, 1 number, 1 symbol)" 
                           name="password" required minlength="8">
                </div>
                <div class="form-group">
                    <label for="retypepassword">Confirm Password</label>
                    <input type="password" class="input-field" id="retypepassword" placeholder="Retype Password" name="retypepassword" 
                           required>
                </div>

                <div class="form-group">
                    <label for="dob">Date of Birth</label>
                    <input type="date" class="input-field" id="dob" name="dob" value="${dob}" required>
                    <small>(Must be 16+ years old)</small>
                </div>

                <div class="form-group">
                    <label for="fullname">Full Name</label>
                    <input type="text" class="input-field" id="fullname" placeholder="Full Name (First and Last Name)" name="fullname" 
                           value="${fullname}" required>
                </div>
                <div class="form-group">
                    <label for="gender">Gender</label>
                    <select class="input-field" id="gender" name="gender" required>
                        <option value="" disabled <%= (request.getAttribute("gender") == null) ? "selected" : "" %>>Select Gender</option>
                        <option value="male" <%= "male".equals(request.getAttribute("gender")) ? "selected" : "" %>>Male</option>
                        <option value="female" <%= "female".equals(request.getAttribute("gender")) ? "selected" : "" %>>Female</option>
                        <option value="other" <%= "other".equals(request.getAttribute("gender")) ? "selected" : "" %>>Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" class="input-field" id="email" placeholder="Email" name="email" 
                           value="${email}" required>
                </div>

                <div class="form-group full-width">
                    <label for="address">Address</label>
                    <input type="text" class="input-field" id="address" placeholder="Address (5-200 characters)" name="address" 
                           value="${address}" required minlength="5" maxlength="200">
                </div>

                <div class="form-group full-width">
                    <label for="profile-photo">Profile Photo</label>
                    <input type="file" id="profile-photo" name="profile_photo" accept="image/jpeg,image/jpg,image/png,image/gif" required>
                    <small>(JPG, PNG, GIF - Max 5MB)</small>
                </div>

                <button type="submit" class="register-button">Create Account</button>

                <div class="login-link">
                    Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a>
                </div>

                <div class="tagline">LOOK • LOVE • ADOPT</div>
            </form>
        </div>
    </div>
    
    <script>
        // Basic client-side validation
        document.getElementById('registerForm').addEventListener('submit', function(event) {
            // Validate username
            const username = document.querySelector('input[name="username"]');
            if (username.value.length < 4 || username.value.length > 20) {
                alert('Username must be between 4 and 20 characters.');
                event.preventDefault();
                return;
            }
            
            if (!/^[a-zA-Z]/.test(username.value)) {
                alert('Username must start with a letter.');
                event.preventDefault();
                return;
            }
            
            if (!/^[a-zA-Z0-9]+$/.test(username.value)) {
                alert('Username must contain only letters and numbers.');
                event.preventDefault();
                return;
            }
            
            // Validate password matching
            const password = document.querySelector('input[name="password"]').value;
            const retypePassword = document.querySelector('input[name="retypepassword"]').value;
            
            if (password !== retypePassword) {
                alert('Passwords do not match!');
                event.preventDefault();
                return;
            }
            
            // Validate password complexity
            const hasUppercase = /[A-Z]/.test(password);
            const hasNumber = /[0-9]/.test(password);
            const hasSpecial = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password);
            
            if (password.length < 8 || !hasUppercase || !hasNumber || !hasSpecial) {
                alert('Password must be at least 8 characters long with at least one uppercase letter, one number, and one symbol.');
                event.preventDefault();
                return;
            }
            
            // Validate phone number
            const phoneNumber = document.querySelector('input[name="number"]').value;
            if (phoneNumber.length !== 10 || !phoneNumber.startsWith('98')) {
                alert('Phone number must be 10 digits and start with 98');
                event.preventDefault();
                return;
            }
            
            // Validate full name (must have at least two parts)
            const fullname = document.querySelector('input[name="fullname"]').value;
            const nameParts = fullname.trim().split(/\s+/);
            if (nameParts.length < 2) {
                alert('Please enter your full name (first and last name).');
                event.preventDefault();
                return;
            }
            
            // Validate date of birth (must be at least 16 years old)
            const dob = document.getElementById('dob').value;
            const birthDate = new Date(dob);
            const today = new Date();
            let age = today.getFullYear() - birthDate.getFullYear();
            const monthDiff = today.getMonth() - birthDate.getMonth();
            
            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
                age--;
            }
            
            if (age < 16) {
                alert('You must be at least 16 years old to register.');
                event.preventDefault();
                return;
            }
            
            // Validate address length
            const address = document.querySelector('input[name="address"]').value;
            if (address.length < 5 || address.length > 200) {
                alert('Address must be between 5 and 200 characters.');
                event.preventDefault();
                return;
            }
            
            // Validate image file
            const profilePhoto = document.getElementById('profile-photo');
            if (profilePhoto.files.length > 0) {
                const file = profilePhoto.files[0];
                
                // Check file type
                const acceptedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
                if (!acceptedTypes.includes(file.type)) {
                    alert('Only JPG, PNG, and GIF files are allowed.');
                    event.preventDefault();
                    return;
                }
                
                // Check file size (max 5MB)
                const maxSize = 5 * 1024 * 1024; // 5MB in bytes
                if (file.size > maxSize) {
                    alert('Image size must be less than 5MB.');
                    event.preventDefault();
                    return;
                }
            }
        });
    </script>
</body>
</html>