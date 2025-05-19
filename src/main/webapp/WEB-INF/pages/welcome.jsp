<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Woofs & Whiskers - Welcome</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/welcome.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="background-container">
        <div class="overlay"></div>
    </div>
    
    <!-- Background Decoration -->
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
    
    <header>
        <div class="logo">
            <span class="paw-icon">🐾</span>
            <h2>Woofs & Whiskers</h2>
        </div>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/aboutus">About</a></li>
                <li><a href="${pageContext.request.contextPath}/login">Adoption</a></li>
                <li><a href="${pageContext.request.contextPath}/contactus">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/register" class="register-btn">Register</a></li>
                <li><a href="${pageContext.request.contextPath}/login" class="login-btn">Login</a></li>
            </ul>
        </nav>
    </header>

    <section class="hero">
        <div class="hero-content">
            <h1>Find Your Perfect <span class="highlight">Furry Friend</span></h1>
            <p>Where love and companionship meet. Start your journey to find a pet that will bring joy to your life!</p>
            <div class="cta-buttons">
                <a href="${pageContext.request.contextPath}/login" class="cta-primary">Get Started</a>
                <a href="#adoption-process" class="cta-secondary">Learn More</a>
            </div>
        </div>
    </section>

    <section class="features">
        <div class="feature-box">
            <div class="feature-icon">🏠</div>
            <h3>Find a Home</h3>
            <p>Help our adorable animals find their forever homes with caring families.</p>
        </div>
        <div class="feature-box">
            <div class="feature-icon">❤️</div>
            <h3>Spread Love</h3>
            <p>Our pets are waiting to shower you with unconditional love and affection.</p>
        </div>
        <div class="feature-box">
            <div class="feature-icon">🤝</div>
            <h3>Community</h3>
            <p>Join our growing community of pet lovers and animal advocates.</p>
        </div>
    </section>

    <section id="about" class="about">
        <h2>About Woofs & Whiskers</h2>
        <p>Woofs & Whiskers is dedicated to finding loving homes for animals in need. Since our founding in 2020, we've successfully matched thousands of pets with their perfect families. Our mission is to ensure every animal experiences the joy of a caring home.</p>
        <div class="tagline">LOOK • LOVE • ADOPT</div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-logo">
                <span class="paw-icon">🐾</span>
                <p>Woofs & Whiskers</p>
                <div class="est">EST 2020</div>
            </div>
            <div class="footer-links">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/viewallpets">Adoption Process</a></li>
                    <li><a href="${pageContext.request.contextPath}/contactus">Contact</a></li>
                </ul>
            </div>
            <div class="footer-contact">
                <h4>Contact Us</h4>
                <p>Email: info@woofsandwhiskers.com</p>
                <p>Phone: (123) 456-7890</p>
            </div>
        </div>
        <div class="copyright">
            <p>&copy; 2025 Woofs & Whiskers. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>