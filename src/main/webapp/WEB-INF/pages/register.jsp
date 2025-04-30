<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Register - Woofs and Whiskers</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>
  <div class="container">
    <div class="logo">WOOFS AND WHISKERS</div>
    <div class="est">EST 2024</div>

    <div class="register-title">Create Your Account</div>
    <%
					String error = (String) request.getAttribute("error");
					if (error != null) {
					%>
					<p style="color: red;"><%=error%></p>
					<%
					}
					%>
					<%
					String success = (String) request.getAttribute("success");
					if (success != null) {
					%>
					<p style="color: green;"><%=success%></p>
					<%
					}
					%>
    

    <form id="registerForm" action = "${pageContext.request.contextPath}/register" method="POST" enctype="multipart/form-data">
      <input type="text" class="input-field" placeholder="Full Name" name="fullname" value="${fullname}" required>

      <input type="text" class="input-field" placeholder="Username" name="username" value="${username}" required>

      <input type="email" class="input-field" placeholder="Email" name="email" value="${email}" required>

      <input type="password" class="input-field" placeholder="Password" name="password" required>
      
      <input type="password" class="input-field" placeholder="Retype Password" name="retypePassword" required>
      
      <input type="number" class="input-field" placeholder="Contact Number" name="number" value="${number}" required>

      <input type="date" class="input-field" name="dob" value="${dob}" required>

      <select class="input-field" name="gender" required>
        <option value="" disabled selected>Select Gender</option>
        <option value="male">Male</option>
        <option value="female">Female</option>
        <option value="other">Other</option>
      </select>

      <input type="text" class="input-field" placeholder="Address" name="address" value="${address}" required>

      <input type="file" class="input-field" name="profile_photo" accept="image/*" required>

      <button type="submit" class="login-button">Register</button>

      <div class="create-account">
        Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a>
      </div>
    </form>

    <div class="tagline">LOOK-LOVE-ADOPT</div>
  </div>
</body>
</html>
