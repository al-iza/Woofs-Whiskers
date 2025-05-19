<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Dashboard - Woofs&Whiskers</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
</head>
<body>
  <div class="page-container">
    <header>
      <div class="logo">
        <img src="https://img.icons8.com/fluency/96/null/dog-footprint.png" alt="Paw Logo">
        <h1>Woofs<span class="ampersand">&</span>Whiskers</h1>
      </div>
      
      <div class="header-right">
        <div class="notification">
          <i class="fas fa-bell"></i>
          <span class="notification-badge">5</span>
        </div>
        
        <div class="profile-header">
          <div class="profile-pic-small">
            <!-- Display user profile image -->
            <img src="${pageContext.request.contextPath}/resources/images/user/${user.imageUrl != null ? user.imageUrl : 'default-profile.png'}" 
                 alt="User Profile"
                 onerror="this.src='${pageContext.request.contextPath}/resources/images/default-profile.png';">
          </div>
          <!-- Display user's full name -->
          <span>${user.fullName != null ? user.fullName : "Admin"}</span>
          <i class="fas fa-angle-down"></i>
        </div>
        
        <div class="theme-toggle">
          <i class="fas fa-moon"></i>
        </div>
      </div>
    </header>

    <div class="content-wrapper">
      <nav class="sidebar">
        <div class="admin-info">
          <div class="admin-avatar">
            <!-- Display user profile image in sidebar too -->
            <img src="${pageContext.request.contextPath}/resources/images/user/${user.imageUrl != null ? user.imageUrl : 'default-profile.png'}" 
                 alt="User Avatar"
                 onerror="this.src='${pageContext.request.contextPath}/resources/images/default-profile.png';">
          </div>
          <h3>Admin Dashboard</h3>
          <p>Welcome, ${user.fullName != null ? user.fullName : "Admin"}</p>
        </div>
        
        <ul class="nav-links">
          <li class="active">
            <a href="${pageContext.request.contextPath}/admindashboard">
              <i class="fas fa-tachometer-alt"></i>
              <span>Dashboard</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/managepets">
              <i class="fas fa-paw"></i>
              <span>Manage Pets</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/addnewpet">
              <i class="fas fa-plus-circle"></i>
              <span>Add a Pet</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/managepets">
              <i class="fas fa-edit"></i>
              <span>Update Pet</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/adoptionrequests">
              <i class="fas fa-heart"></i>
              <span>Adoption Requests</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/manageusers">
              <i class="fas fa-users"></i>
              <span>Manage Users</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/adminprofile">
              <i class="fas fa-user-cog"></i>
              <span>Profile Settings</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/aboutus">
              <i class="fas fa-info-circle"></i>
              <span>About Us</span>
            </a>
          </li>
          <li class="logout">
            <a href="${pageContext.request.contextPath}/logout">
              <i class="fas fa-sign-out-alt"></i>
              <span>Logout</span>
            </a>
          </li>
        </ul>
      </nav>

      <main class="main-content">
        <!-- Display error message if exists -->
        <c:if test="${not empty error}">
          <div class="error-message">
            <i class="fas fa-exclamation-circle"></i>
            <span>${error}</span>
          </div>
        </c:if>
        
        <!-- Welcome Section -->
        <section class="welcome-section">
          <div class="welcome-text">
            <h2>Welcome back, ${user.fullName != null ? user.fullName.split(" ")[0] : "Admin"}!</h2>
            <p>Here's what's happening today at your shelter</p>
          </div>
          <div class="date-display">
            <i class="far fa-calendar-alt"></i>
            <span id="current-date">May 17, 2025</span>
          </div>
        </section>

        <!-- Overview Cards -->
        <section class="overview-cards">
          <div class="overview-card">
            <div class="card-icon">
              <i class="fas fa-paw"></i>
            </div>
            <div class="card-info">
              <h3>${totalPets}</h3>
              <p>Total Pets</p>
            </div>
            <div class="card-change positive">
              <i class="fas fa-arrow-up"></i>
              <span>12%</span>
            </div>
          </div>
          
          <div class="overview-card">
            <div class="card-icon">
              <i class="fas fa-users"></i>
            </div>
            <div class="card-info">
              <h3>${totalUsers}</h3>
              <p>Total Users</p>
            </div>
            <div class="card-change positive">
              <i class="fas fa-arrow-up"></i>
              <span>5%</span>
            </div>
          </div>
          
          <div class="overview-card">
            <div class="card-icon">
              <i class="fas fa-dollar-sign"></i>
            </div>
            <div class="card-info">
              <h3>${mostExpensivePet.adoptionFees} (${mostExpensivePet.petName})</h3>
              <p>Most Expensive Pet</p>
            </div>
            <div class="card-change positive">
              <i class="fas fa-arrow-up"></i>
              <span>10%</span>
            </div>
          </div>
        </section>

        <!-- Chart Section -->
        <section class="charts-grid">
          <div class="chart-card">
            <div class="chart-header">
              <h3>Total Pets by Category</h3>
              <div class="chart-actions">
                <button class="chart-action-btn"><i class="fas fa-sync-alt"></i></button>
                <button class="chart-action-btn"><i class="fas fa-ellipsis-v"></i></button>
              </div>
            </div>
            <div class="chart-body">
              <canvas id="categoryChart"></canvas>
            </div>
          </div>
          
          <div class="chart-card">
            <div class="chart-header">
              <h3>Total Pets by Gender</h3>
              <div class="chart-actions">
                <button class="chart-action-btn"><i class="fas fa-sync-alt"></i></button>
                <button class="chart-action-btn"><i class="fas fa-ellipsis-v"></i></button>
              </div>
            </div>
            <div class="chart-body">
              <canvas id="genderChart"></canvas>
            </div>
          </div>
        </section>
        
        <!-- Quick Actions Section -->
        <section class="quick-actions">
          <h2 class="section-title">Quick Actions</h2>
          <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/managepets" class="action-btn">
              <i class="fas fa-paw"></i>
              <span>View All Pets</span>
            </a>
            <a href="${pageContext.request.contextPath}/addnewpet" class="action-btn">
              <i class="fas fa-plus-circle"></i>
              <span>Add New Pet</span>
            </a>
            <a href="${pageContext.request.contextPath}/managepets" class="action-btn">
              <i class="fas fa-cog"></i>
              <span>Manage Pets</span>
            </a>
            <a href="${pageContext.request.contextPath}/adoptionrequests" class="action-btn">
              <i class="fas fa-clipboard-list"></i>
              <span>View Adoptions</span>
            </a>
            <a href="${pageContext.request.contextPath}/donations" class="action-btn">
              <i class="fas fa-hand-holding-heart"></i>
              <span>Donations</span>
            </a>
          </div>
        </section>
        
        <!-- Recent Pets Section -->
        <section class="recent-pets">
          <div class="section-header">
            <h2 class="section-title">Recently Added Pets</h2>
            <a href="${pageContext.request.contextPath}/managepets" class="view-all-link">View All</a>
          </div>
          
          <div class="pets-table-container">
            <table class="pets-table">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Age</th>
                  <th>Status</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="pet" items="${recentPets}" end="2">
                  <tr>
                    <td>${pet.petId}</td>
                    <td>
                      <div class="pet-name-cell">
                        <img src="${pageContext.request.contextPath}/Uploads/${pet.petImageUrl}" alt="${pet.petName}"
                             onerror="this.src='${pageContext.request.contextPath}/resources/images/default-pet.png';">
                        <span>${pet.petName}</span>
                      </div>
                    </td>
                    <td>${pet.petCategory}</td>
                    <td>${pet.age} ${pet.age eq 1 ? 'year' : 'years'}</td>
                    <td><span class="status-badge available">Available</span></td>
                    <td>
                      <div class="action-cell">
                        <a href="${pageContext.request.contextPath}/updatepet?id=${pet.petId}" class="table-action-btn edit"><i class="fas fa-edit"></i></a>
                        <a href="${pageContext.request.contextPath}/petdetails?id=${pet.petId}" class="table-action-btn view"><i class="fas fa-eye"></i></a>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
                <c:if test="${empty recentPets}">
                  <tr>
                    <td colspan="6" class="no-pets-message">No pets found. <a href="${pageContext.request.contextPath}/addnewpet">Add a new pet</a></td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </section>
        
        <!-- Inspirational Message -->
        <section class="inspiration-section">
          <div class="inspiration-content">
            <i class="fas fa-quote-left"></i>
            <h2>Your care creates families. Manage with love, lead with compassion!</h2>
            <i class="fas fa-quote-right"></i>
          </div>
        </section>
      </main>
    </div>

    <footer>
      <div class="footer-content">
        <div class="footer-column">
          <div class="footer-logo">
            <img src="https://img.icons8.com/fluency/48/null/dog-footprint.png" alt="Paw Logo">
            <h3>Woofs&Whiskers</h3>
          </div>
          <p>Administrative portal for animal shelter management.</p>
          <div class="footer-social">
            <a href="https://www.facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
            <a href="https://www.instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
            <a href="https://www.twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
          </div>
        </div>
        
        <div class="footer-column">
          <h3>Admin Tools</h3>
          <ul>
            <li><a href="${pageContext.request.contextPath}/managepets"><i class="fas fa-paw"></i> Manage Animals</a></li>
            <li><a href="${pageContext.request.contextPath}/manageusers"><i class="fas fa-users"></i> User Management</a></li>
            <li><a href="${pageContext.request.contextPath}/adminprofile"><i class="fas fa-cogs"></i> System Settings</a></li>
            <li><a href="${pageContext.request.contextPath}/admindashboard"><i class="fas fa-chart-line"></i> Analytics</a></li>
          </ul>
        </div>
        
        <div class="footer-column">
          <h3>Support</h3>
          <ul class="contact-info">
            <li><i class="fas fa-question-circle"></i> <a href="${pageContext.request.contextPath}/help">Help Center</a></li>
            <li><i class="fas fa-headset"></i> <a href="${pageContext.request.contextPath}/contact">Contact Support</a></li>
            <li><i class="fas fa-book"></i> <a href="${pageContext.request.contextPath}/guide">User Guide</a></li>
            <li><i class="fas fa-tools"></i> <a href="${pageContext.request.contextPath}/troubleshoot">Troubleshooting</a></li>
          </ul>
        </div>
        
        <div class="footer-column">
          <h3>Our Location</h3>
          <div class="footer-map">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.025597893126!2d85.32064327520194!3d27.717245027703195!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190d79aee9b9%3A0x4f0b07c7df1a0b3!2sLazimpat%2C%20Kathmandu%2044600!5e0!3m2!1sen!2snp!4v1714723943215!5m2!1sen!2snp" allowfullscreen="" loading="lazy"></iframe>
          </div>
          <div class="admin-status">
            <p><i class="fas fa-clock"></i> Last Login: Today 10:00 AM</p>
            <p><i class="fas fa-circle text-success"></i> Status: Online</p>
          </div>
        </div>
      </div>
      
      <div class="footer-bottom">
        <p>© 2025 Woofs&Whiskers Admin Portal. All rights reserved.</p>
      </div>
    </footer>
  </div>

<script>
// Chart.js logic
document.addEventListener('DOMContentLoaded', function() {
  // Total Pets by Category (Bar Graph)
  new Chart(document.getElementById('categoryChart'), {
    type: 'bar',
    data: {
      labels: [<c:forEach var="category" items="${petsByCategory}">'${category.key}', </c:forEach>],
      datasets: [{
        label: 'Pets by Category',
        data: [<c:forEach var="category" items="${petsByCategory}">${category.value}, </c:forEach>],
        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF']
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          title: {
            display: true,
            text: 'Number of Pets'
          }
        },
        x: {
          title: {
            display: true,
            text: 'Category'
          }
        }
      }
    }
  });

  // Total Pets by Gender (Donut Chart)
  new Chart(document.getElementById('genderChart'), {
    type: 'doughnut',
    data: {
      labels: [<c:forEach var="gender" items="${petsByGender}">'${gender.key}', </c:forEach>],
      datasets: [{
        data: [<c:forEach var="gender" items="${petsByGender}">${gender.value}, </c:forEach>],
        backgroundColor: ['#36A2EB', '#FF6384', '#FFCE56']
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      cutout: '70%',
      plugins: {
        legend: {
          position: 'top'
        }
      }
    }
  });

  // Set current date
  document.getElementById('current-date').textContent = new Date().toLocaleDateString('en-US', {
    month: 'long',
    day: 'numeric',
    year: 'numeric'
  });

  // Theme toggle functionality
  const themeToggle = document.querySelector('.theme-toggle');
  themeToggle.addEventListener('click', function() {
    document.body.classList.toggle('dark-mode');
    const icon = themeToggle.querySelector('i');
    if (document.body.classList.contains('dark-mode')) {
      icon.className = 'fas fa-sun';
    } else {
      icon.className = 'fas fa-moon';
    }
  });
});
</script>

<style>
/* Add additional styles for user profile display */
.profile-pic-small img {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #fff;
}

.admin-avatar img {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid #fff;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.profile-header {
  display: flex;
  align-items: center;
  gap: 10px;
  background-color: rgba(255, 255, 255, 0.1);
  padding: 6px 12px;
  border-radius: 30px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.profile-header:hover {
  background-color: rgba(255, 255, 255, 0.2);
}

.error-message {
  background-color: #f8d7da;
  color: #721c24;
  padding: 10px 15px;
  border-radius: 5px;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 10px;
}

.error-message i {
  font-size: 20px;
}

.no-pets-message {
  text-align: center;
  padding: 20px;
  color: #6c757d;
}

.no-pets-message a {
  color: #0d6efd;
  text-decoration: none;
  font-weight: 500;
}

.no-pets-message a:hover {
  text-decoration: underline;
}

/* Dark mode adjustments */
body.dark-mode {
  --bg-color: #121212;
  --card-bg: #1e1e1e;
  --text-color: #e0e0e0;
  --border-color: #333;
  --highlight: #ff6384;

  background-color: var(--bg-color);
  color: var(--text-color);
}

body.dark-mode .chart-card,
body.dark-mode .overview-card,
body.dark-mode .recent-pets,
body.dark-mode .sidebar {
  background-color: var(--card-bg);
  border-color: var(--border-color);
}

body.dark-mode .nav-links li a {
  color: var(--text-color);
}

body.dark-mode .sidebar {
  border-right: 1px solid var(--border-color);
}

body.dark-mode .pets-table th,
body.dark-mode .pets-table td {
  border-color: var(--border-color);
}

body.dark-mode .action-btn {
  background-color: var(--card-bg);
  color: var(--text-color);
  border-color: var(--border-color);
}

body.dark-mode .action-btn:hover {
  background-color: var(--highlight);
  color: #fff;
}
</style>

</body>
</html>