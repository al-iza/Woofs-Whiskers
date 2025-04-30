<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Woofs and Whiskers - Login</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>
  <div class="container">
    <div class="logo">WOOFS AND WHISKERS</div>
    <div class="est">EST 2024</div>

    <div class="login-title">Login to your Account</div>

    <form id="loginForm" action = "${pageContext.request.contextPath}/login" method="POST">
      <input type="text" class="input-field" placeholder="Username" name="username">
      <input type="password" class="input-field" placeholder="Password" name="password">


      <button class="login-button" type="submit">Login</button>

      <div class="forgot-password">
        <span>Forgot Password?</span>
      </div>

      <div class="create-account" >
        <span><a href="${pageContext.request.contextPath}/register">Create new account</a></span>
      </div>
    </form>

    <div class="tagline">LOOK-LOVE-ADOPT</div>
  </div>
</body>
</html>
