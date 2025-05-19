<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Woofs&Whiskers - Contact Us</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contactus.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
  <!-- Decorative Elements -->
  <div class="paw-print paw-print-1"><i class="fas fa-paw"></i></div>
  <div class="paw-print paw-print-2"><i class="fas fa-paw"></i></div>

  <!-- Header -->
  <header>
    <div class="logo">
      <h1>Woofs&Whiskers</h1>
    </div>
    <nav>
      <div class="nav-center">
        <ul class="nav-links">
          <li><a href="dashuser.html">Dashboard</a></li>
          <li><a href="viewpetdetaails.html">View Pets</a></li>
          <li><a href="adoptapet.html">Adopt</a></li>
          <li><a href="contactus.html" class="active">Contact Us</a></li>
          <li><a href="userprofile.html">Profile</a></li>
          <li><a href="aboutus.html">About Us</a></li>
          <li><a href="login.html">Logout</a></li>
        </ul>
      </div>
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
        <div class="dark-mode-icon"><i class="fas fa-moon"></i></div>
      </div>
    </nav>
  </header>

  <!-- Page Title -->
  <h1 class="page-title">Get in Touch</h1>

  <!-- Main Contact Container -->
  <div class="container">
    <div class="contact-info">
      <h2>Contact Information</h2>
      <p class="contact-message">Have questions about adoption or want to volunteer? We're here to help you with anything you need regarding our furry friends.</p>
      
      <p><i class="fas fa-phone icon"></i> +977 9866005678</p>
      <p><i class="fas fa-envelope icon"></i> woofsandwhiskers@gmail.com</p>
      <p><i class="fas fa-map-marker-alt icon"></i> Lazimpat, Kathmandu, Nepal</p>
      
      <div class="contact-hours">
        <h3>Opening Hours</h3>
        <p><span>Monday - Friday:</span> <span>9:00 AM - 6:00 PM</span></p>
        <p><span>Saturday:</span> <span>10:00 AM - 4:00 PM</span></p>
        <p><span>Sunday:</span> <span>Closed</span></p>
      </div>
    </div>

    <div class="contact-form">
      <h2>Send Us a Message</h2>
      <form>
        <div class="name-fields">
          <div class="input-group">
            <label for="firstName">First Name</label>
            <input type="text" id="firstName" placeholder="John" required>
          </div>
          <div class="input-group">
            <label for="lastName">Last Name</label>
            <input type="text" id="lastName" placeholder="Doe" required>
          </div>
        </div>
        
        <div class="input-group">
          <label for="email">Email Address</label>
          <input type="email" id="email" placeholder="john.doe@example.com" required>
        </div>
        
        <div class="input-group">
          <label for="phone">Phone Number</label>
          <input type="tel" id="phone" placeholder="+977 98XXXXXXXX">
        </div>
        
        <div class="input-group">
          <label for="subject">Subject</label>
          <select id="subject">
            <option value="adoption">Pet Adoption</option>
            <option value="donation">Donations</option>
            <option value="volunteer">Volunteering</option>
            <option value="other">Other Inquiry</option>
          </select>
        </div>
        
        <div class="input-group">
          <label for="message">Your Message</label>
          <textarea id="message" placeholder="Please provide details about your inquiry..." rows="5" required></textarea>
        </div>
        
        <button type="submit">Send Message</button>
        
        <p class="form-footer">We'll get back to you within 24 hours!</p>
      </form>
    </div>
  </div>

  <!-- Map Section -->
  <div class="map-section">
    <div class="map-container">
      <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.025597893126!2d85.32064327520194!3d27.717245027703195!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190d79aee9b9%3A0x4f0b07c7df1a0b3!2sLazimpat%2C%20Kathmandu%2044600!5e0!3m2!1sen!2snp!4v1714723943215!5m2!1sen!2snp" allowfullscreen="" loading="lazy"></iframe>
    </div>
  </div>

  <!-- FAQ Section -->
  <div class="faq-section">
    <h2>Frequently Asked Questions</h2>
    <div class="faq-grid">
      <div class="faq-item">
        <h3>What is the adoption process?</h3>
        <p>Our adoption process includes filling out an application, meeting the pet, a home visit if necessary, and finalizing paperwork if approved. The whole process usually takes 3-7 days.</p>
      </div>
      <div class="faq-item">
        <h3>Are all pets vaccinated?</h3>
        <p>Yes, all our pets are up-to-date on vaccinations, spayed/neutered, and microchipped before they go to their forever homes.</p>
      </div>
      <div class="faq-item">
        <h3>How can I volunteer?</h3>
        <p>We welcome volunteers! Please contact us through this form or call our office to learn about current volunteering opportunities.</p>
      </div>
      <div class="faq-item">
        <h3>Do you accept donations?</h3>
        <p>Absolutely! We accept monetary donations as well as supplies like food, blankets, toys, and cleaning products. Every bit helps!</p>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer>
    <div class="footer-content">
      <div class="footer-section">
        <img src="assets/icons/pet.png" alt="Pet Icon">
        <h3>Our Services</h3>
        <ul>
          <li><a href="#">Pet Adoption</a></li>
          <li><a href="#">Veterinary Care</a></li>
          <li><a href="#">Training Programs</a></li>
          <li><a href="#">Pet Supplies</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <img src="assets/icons/technical-support.png" alt="Support Icon">
        <h3>Support</h3>
        <ul>
          <li><a href="#">Help Center</a></li>
          <li><a href="#">FAQs</a></li>
          <li><a href="#">Contact Support</a></li>
          <li><a href="#">Donation Policy</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <img src="assets/icons/company.png" alt="About Icon">
        <h3>About Us</h3>
        <ul>
          <li><a href="#">Our Story</a></li>
          <li><a href="#">Team</a></li>
          <li><a href="#">Testimonials</a></li>
          <li><a href="#">Careers</a></li>
        </ul>
      </div>
      
      <div class="footer-section">
        <img src="assets/icons/marker.png" alt="Location Icon">
        <h3>Visit Us</h3>
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.025597893126!2d85.32064327520194!3d27.717245027703195!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190d79aee9b9%3A0x4f0b07c7df1a0b3!2sLazimpat%2C%20Kathmandu%2044600!5e0!3m2!1sen!2snp!4v1714723943215!5m2!1sen!2snp" allowfullscreen="" loading="lazy"></iframe>
      </div>
    </div>
    
    <div class="footer-social">
      <a href="#" aria-label="Facebook">
        <img class="social-icon" src="assets/icons/facebook-new.png" alt="Facebook">
      </a>
      <a href="#" aria-label="Instagram">
        <img class="social-icon" src="assets/icons/instagram-new.png" alt="Instagram">
      </a>
      <a href="#" aria-label="Twitter">
        <img class="social-icon" src="assets/icons/twitter.png" alt="Twitter">
      </a>
      <a href="#" aria-label="YouTube">
        <img class="social-icon" src="assets/icons/youtube-play.png" alt="YouTube">
      </a>
    </div>
    
    <div class="footer-bottom">
      © 2025 Woofs&Whiskers Pet Adoption Center. All rights reserved.
    </div>
  </footer>
</body>
</html>