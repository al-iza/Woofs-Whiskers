<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Woofs&Whiskers - Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>

<body>
<!-- Background Elements -->
<div class="bg-shape bg-shape-1"></div>
<div class="bg-shape bg-shape-2"></div>

<!-- Animal silhouettes -->
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
<div class="login-box">
<div class="logo">WELCOME</div>
<div class="est">EST 2020</div>

<div class="login-title">Login to Your Account</div>

<form id="loginForm" action="${pageContext.request.contextPath}/login" method="POST">
<div class="input-group">
<input type="text" class="input-field" placeholder="Username" name="username"
value="${username}" required>
<c:if test="${not empty usernameError}">
<div class="error-message">${usernameError}</div>
</c:if>
</div>

<div class="input-group">
<div class="password-container">
<input type="password" class="input-field" id="password" placeholder="Password" name="password" required>
<span class="password-toggle" onclick="togglePassword()">
<i class="fas fa-eye"></i>
</span>
</div>
<c:if test="${not empty passwordError}">
<div class="error-message">${passwordError}</div>
</c:if>
</div>

<c:if test="${not empty error}">
<div class="error-message">${error}</div>
</c:if>

<button type="submit" class="login-button">Sign In</button>

<div class="auth-links">
<a href="#">Forgot Password?</a>
<a href="${pageContext.request.contextPath}/register">Create new account</a>
</div>
</form>

<div class="tagline">LOOK • LOVE • ADOPT</div>
</div>
</div>
<!-- Add this script at the end of your body tag -->
<script>
function togglePassword() {
  const passwordField = document.getElementById('password');
  const toggleIcon = document.querySelector('.password-toggle i');
  
  if (passwordField.type === 'password') {
    passwordField.type = 'text';
    toggleIcon.className = 'fas fa-eye-slash'; // Change to closed eye icon
  } else {
    passwordField.type = 'password';
    toggleIcon.className = 'fas fa-eye'; // Change to open eye icon
  }
}
</script>
</body>
</html>