<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Woofs&Whiskers</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aboutus.css">
</head>
<body>
    <!-- Header Section -->
    <header>
        <div class="logo">
            <h1>Woofs&Whiskers</h1>
        </div>
        <nav>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/userdashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/viewpetdetails">View Pet Details</a></li>
                <li><a href="${pageContext.request.contextPath}/adoptapet">Adopt a Pet</a></li>
                <li><a href="${pageContext.request.contextPath}/contactus">Contact Us</a></li>
                <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/aboutus">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/login">Logout</a></li>
            </ul>
            <div class="admin-actions">
                <div class="notification">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#861616" viewBox="0 0 24 24">
                        <path d="M12 24c1.1 0 2-.9 2-2h-4a2 2 0 0 0 2 2zm6.4-6V11c0-3.1-1.6-5.6-4.4-6.3V4a2 2 0 0 0-4 0v.7C7.2 5.4 5.6 7.9 5.6 11v7L4 19v1h16v-1l-1.6-1z"/>
                    </svg>
                </div>
                <div class="profile-header">
                    <div class="profile-pic-small"></div>
                    <span>Admin Name</span>
                </div>
                <div class="dark-mode-icon">🌙</div>
            </div>
        </nav>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <h2>About Woofs&Whiskers</h2>
        <p>Where Every Pet Finds Their Forever Home</p>
    </section>

    <!-- Main Content -->
    <div class="container">
        <section class="about-section">
            <div class="about-grid">
                <!-- Mission Card -->
                <div class="about-card">
                    <div class="card-header">
                        <h3>Our Mission</h3>
                    </div>
                    <div class="card-content">
                        <p>
                            Founded by Aliza Shrestha, a passionate animal lover, Woofs&Whiskers is a sanctuary where animals get a second chance at life. Based in Kathmandu, Nepal, our mission is to reduce unnecessary euthanasia, provide top-tier care, and create lasting, meaningful connections between pets and families.
                        </p>
                        <p>
                            Whether it's a playful dog, a curious cat, a colorful bird, or a peaceful fish, we are here to ensure that every animal finds its perfect match.
                        </p>
                        <p>
                            At Woofs&Whiskers, we believe that adopting a pet is not just about bringing home a companion. It's about finding your soulmate. With personalized care and attention for every animal, we ensure that each one is ready to bring love, joy, and happiness into your life.
                        </p>
                        <p>
                            Our team's unwavering dedication and a 98% Save Rate speak volumes about our commitment to each animal's well-being and future.
                        </p>
                    </div>
                </div>

                <!-- Founder's Story Card -->
                <div class="about-card">
                    <div class="card-header">
                        <h3>The Heart Behind Woofs&Whiskers</h3>
                    </div>
                    <div class="card-content">
                        <p>
                            Aliza Shrestha, the founder of Woofs&Whiskers, has always had a deep love for animals. However, her true journey began in 2020, during the challenging days of the COVID-19 pandemic. While the world stood still, Aliza found herself facing moments of loneliness and uncertainty.
                        </p>
                        <p>
                            In her search for comfort, Aliza turned to the stray animals of Kathmandu. Their unconditional love and simple joy became her lifeline, filling the emptiness she felt. Through caring for them, she found solace and healing.
                        </p>
                        <p>
                            It was in that moment that the idea for Woofs&Whiskers was born. Aliza realized that the pure, unwavering love animals offer could heal not only her, but everyone in need of a companion.
                        </p>
                        <p>
                            Today, Woofs&Whiskers is more than just an adoption center. It is a sanctuary built on Aliza's belief that animals are pure and full of love. Her journey from a time of loneliness to founding a life-changing organization is a testament to her incredible vision.
                        </p>
                    </div>
                </div>

                <!-- Impact Card -->
                <div class="about-card">
                    <div class="card-header">
                        <h3>Our Impact</h3>
                    </div>
                    <div class="card-content">
                        <p>
                            Woofs&Whiskers has been a beacon of hope for both animals and people alike. Since its founding in 2020, it has been a transformative force, not just for the animals we've rescued, but for the countless individuals whose lives have been changed through the adoption process.
                        </p>
                        <p>
                            In 2025 alone, we are proud to have facilitated 222 successful adoptions, marking another milestone in our mission to connect people with their perfect animal companions. Since opening our doors, Woofs&Whiskers has helped more than 890 animals find loving homes.
                        </p>
                        <p>
                            The impact on our adopters has been profound. Many have shared how adopting a pet from Woofs&Whiskers has brought them joy, comfort, and emotional support, especially during tough times.
                        </p>
                        <p>
                            Every adoption is a new chapter in our story and a reminder of how powerful the bond between humans and animals can be.
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="stats-container">
            <h2 class="stats-heading">Our Achievements</h2>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">222</div>
                    <div class="stat-label">Adoptions in 2025</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">890+</div>
                    <div class="stat-label">Total Lives Changed</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">98%</div>
                    <div class="stat-label">Save Rate</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">5+</div>
                    <div class="stat-label">Years of Service</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="team-section">
        <h2 class="team-heading">Meet Our Team</h2>
        <div class="team-grid">
            <div class="team-card">
                <div class="team-img"></div>
                <div class="team-info">
                    <h3 class="team-name">Aliza Shrestha</h3>
                    <div class="team-role">Founder & Director</div>
                    <p class="team-desc">With a passion for animal welfare that began in childhood, Aliza founded Woofs&Whiskers in 2020, turning her love for animals into a mission to help both pets and people find their perfect match.</p>
                </div>
            </div>
            <div class="team-card">
                <div class="team-img"></div>
                <div class="team-info">
                    <h3 class="team-name">Dr. Raj Sharma</h3>
                    <div class="team-role">Veterinarian</div>
                    <p class="team-desc">Dr. Sharma brings 15 years of veterinary experience, ensuring all our animals receive the highest standard of care before finding their forever homes.</p>
                </div>
            </div>
            <div class="team-card">
                <div class="team-img"></div>
                <div class="team-info">
                    <h3 class="team-name">Maya Tamang</h3>
                    <div class="team-role">Adoption Coordinator</div>
                    <p class="team-desc">With her intuitive ability to match pets with the perfect families, Maya has facilitated hundreds of successful adoptions since joining our team.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <h2 class="cta-heading">Ready to Meet Your New Best Friend?</h2>
        <a href="adopt.html" class="cta-btn">Adopt Now!</a>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <img src="https://img.icons8.com/ios-filled/50/admin-settings-male.png" alt="Admin Tools Icon">
                <h3>Admin Tools</h3>
                <ul>
                    <li><a href="#">Manage Animals</a></li>
                    <li><a href="#">User Management</a></li>
                    <li><a href="#">System Settings</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <img src="https://img.icons8.com/ios-filled/50/technical-support.png" alt="Support Icon">
                <h3>Admin Support</h3>
                <ul>
                    <li><a href="#">Help</a></li>
                    <li><a href="#">Contact Support</a></li>
                    <li><a href="#">User Guide</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <img src="https://img.icons8.com/?size=100&id=CWiCmUhQTh3E&format=png&color=000000" alt="Info Icon">
                <h3>Admin Info</h3>
                <ul>
                    <li>Last Login: Today 10:00 AM</li>
                    <li>Status: Online</li>
                </ul>
            </div>
            <div class="footer-section footer-map">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.025597893126!2d85.32064327520194!3d27.717245027703195!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190d79aee9b9%3A0x4f0b07c7df1a0b3!2sLazimpat%2C%20Kathmandu%2044600!5e0!3m2!1sen!2snp!4v1714723943215!5m2!1sen!2snp" allowfullscreen="" loading="lazy"></iframe>
            </div>
        </div>
        <div class="footer-social">
            <a href="https://www.facebook.com" target="_blank">
                <img class="social-icon" src="https://img.icons8.com/ios-filled/30/facebook-new.png" alt="Facebook">
            </a>
            <a href="https://www.instagram.com" target="_blank">
                <img class="social-icon" src="https://img.icons8.com/ios-filled/30/instagram-new.png" alt="Instagram">
            </a>
            <a href="https://www.twitter.com" target="_blank">
                <img class="social-icon" src="https://img.icons8.com/ios-filled/30/twitter.png" alt="Twitter">
            </a>
        </div>
        <div class="footer-bottom">&copy; 2025 Woofs&Whiskers. All rights reserved.</div>
    </footer>
</body>
</html>