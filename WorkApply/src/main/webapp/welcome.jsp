<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
    String username = (String) sessionObj.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome, <%= username %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #ff7e5f, #33a2ff);
        }
        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #333;
            padding: 10px 20px;
        }
        .navbar img {
            height: 50px;
        }
        .navbar ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .navbar ul li {
            margin-left: 20px;
        }
        .navbar ul li a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            padding: 8px 12px;
        }
        .navbar ul li a:hover {
            background-color: #575757;
            border-radius: 5px;
        }
        .container {
            text-align: center;
            margin-top: 50px;
            color: white;
        }
        .card-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 20px;
        }
        .card {
            width: 300px;
            height: 300px;
            border-radius: 10px;
            overflow: hidden;
            position: relative;
            cursor: pointer;
            background: rgba(255, 255, 255, 0.1);
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
        }
        .card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        .card:hover img {
            transform: scale(1.1);
        }
        .card-content {
            position: absolute;
            bottom: -100%;
            left: 0;
            width: 100%;
            background: rgba(0, 0, 0, 0.7);
            color: white;
            text-align: center;
            padding: 15px;
            transition: bottom 0.5s ease;
        }
        .card:hover .card-content {
            bottom: 0;
        }
        .apply-btn {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s ease;
        }
        .apply-btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <div class="navbar">
        <img src="https://www.techtammina.com/wp-content/uploads/2022/04/techlogo.png" alt="Company Logo">
        <ul>
            <li><a href="welcome.jsp">Home</a></li>
            <li><a href="https://www.techtammina.com/" target = "_blank">Profile</a></li>
            <li><a href="Logout.jsp">Logout</a></li>
        </ul>
    </div>

    <!-- Welcome Message -->
    <div class="container">
        <h2>Welcome  <%= username %>!</h2>
        <p>Choose an option below to apply:</p>
    </div>

    <!-- Cards Section -->
    <div class="card-container">
        <div class="card">
            <img src="https://idreamcareer.com/wp-content/uploads/2020/03/Tips-for-Interns.jpg" alt="Internship">
            <div class="card-content">
                <h3>Internship</h3>
                <p>Gain valuable experience by applying for an internship.</p>
                <a href="applyInternship.jsp" class="apply-btn">Apply</a>
            </div>
        </div>
        <div class="card">
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdprqQQRVye5tcFiDNvuRFaVKW73R8A4EPFg&s" alt="Job">
            <div class="card-content">
                <h3>Job</h3>
                <p>Start your career by applying for a full-time job.</p>
                <a href="applyJob.jsp" class="apply-btn">Apply</a>
            </div>
        </div>
        <div class="card">
            <img src="https://etimg.etb2bimg.com/photo/97297322.cms" alt="Freelancing">
            <div class="card-content">
                <h3>Freelancing</h3>
                <p>Work on freelance projects and grow your skills.</p>
                <a href="applyFreelance.jsp" class="apply-btn">Apply</a>
            </div>
        </div>
    </div>

</body>
</html>
