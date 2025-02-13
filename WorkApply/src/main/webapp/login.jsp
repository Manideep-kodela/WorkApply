<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
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
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .login-container {
            width: 300px;
            margin: 100px auto;
            padding: 20px;
            background: white;
            box-shadow: 0px 0px 10px 0px #0000001a;
            border-radius: 5px;
        }
        input[type="text"], input[type="password"] {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
  <div class="navbar">
    <img src="https://www.techtammina.com/wp-content/uploads/2022/04/techlogo.png" alt="Company Logo">
    <ul>
      <li><a href="welcome.jsp">Home</a></li>
      <li><a href="https://www.techtammina.com/" target="_blank">Profile</a></li>
      <li><a href="Logout.jsp">Logout</a></li>
    </ul>
  </div>
    <div class="login-container">
        <h2>Login</h2>
        <form action="login" method="post">
            <input type="text" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>

</body>
</html>
