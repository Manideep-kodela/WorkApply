<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Form</title>
<style>
     .navbar {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background-color: #333;
      padding: 10px 20px;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      z-index: 1000;
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
      margin-right:25px;
    }
    .navbar ul li a:hover {
      background-color: #575757;
      border-radius: 5px;
    }
    /* Basic Reset */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }

    /* Centering the form */
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background: linear-gradient(135deg, #74b9ff, #0984e3);
    }

    .form-container {
        background: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        width: 350px;
        text-align: center;
    }

    h2 {
        margin-bottom: 20px;
        color: #2d3436;
    }

    input {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
        outline: none;
    }

    input:focus {
        border-color: #0984e3;
    }

    button {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        background: #0984e3;
        color: white;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s ease;
    }

    button:hover {
        background: #074d8c;
    }

    .login-link {
        margin-top: 15px;
        font-size: 14px;
    }

    .login-link a {
        color: #0984e3;
        text-decoration: none;
        font-weight: bold;
    }

    .login-link a:hover {
        text-decoration: underline;
    }

    .error {
        color: red;
        font-size: 14px;
        margin-bottom: 10px;
        display: none;
    }

    /* Responsive Design */
    @media (max-width: 400px) {
        .form-container {
            width: 90%;
        }
    }
</style>
<script>
    function validateForm(event) {
        event.preventDefault(); // Prevent form submission if validation fails

        let username = document.getElementById("username").value.trim();
        let email = document.getElementById("email").value.trim();
        let password = document.getElementById("password").value.trim();
        let errorMessage = document.getElementById("error-message");

        // Check if the username is at least 6 characters
        if (username.length < 6) {
            errorMessage.innerText = "Name must be at least 6 characters.";
            errorMessage.style.display = "block";
            return false;
        }

        // Check if email ends with "@gmail.com"
        if (!email.endsWith("@gmail.com")) {
            errorMessage.innerText = "Email must end with @gmail.com.";
            errorMessage.style.display = "block";
            return false;
        }

        // Check if password is at least 8 characters, contains an uppercase letter, and a special character
        let passwordPattern = /^(?=.*[A-Z])(?=.*[\W_]).{8,}$/;
        if (!passwordPattern.test(password)) {
            errorMessage.innerText = "Password must be at least 8 characters, contain one uppercase letter, and one special character.";
            errorMessage.style.display = "block";
            return false;
        }

        // If all validations pass, submit the form
        errorMessage.style.display = "none";
        document.getElementById("register-form").submit();
    }
</script>
</head>
<body>
   <div class="navbar">
    <img src="https://www.techtammina.com/wp-content/uploads/2022/04/techlogo.png" alt="Company Logo">
    <ul>
      <li><a href="welcome.jsp">Home</a></li>
      <li><a href="https://www.techtammina.com/" target="_blank">Profile</a></li>
      <li><a href="logout.jsp">Logout</a></li>
    </ul>
  </div>
    <div class="form-container">
        <h2>Register</h2>
        <p id="error-message" class="error"></p> <!-- Error message section -->
        <form id="register-form" action="register" method="post" onsubmit="return validateForm(event)">
            <input type="text" id="username" name="username" placeholder="Full Name" required><br>
            <input type="email" id="email" name="email" placeholder="Email" required><br>
            <input type="password" id="password" name="password" placeholder="Password" required><br>
            <button type="submit">Register</button>
        </form>
        <div class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>
</body>
</html>
