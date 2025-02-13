<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String clientEmail = (String) session.getAttribute("clientEmail");
    if (clientEmail == null) {
        response.sendRedirect("client_login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Client Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url('3d-background.jpg') no-repeat center center/cover;
        }
        .navbar {
            background: rgba(0, 0, 0, 0.8);
            padding: 15px;
            text-align: center;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 18px;
        }
        .container {
            width: 80%;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.5);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background: #007BFF;
            color: white;
        }
        tr:hover {
            background: rgba(0, 123, 255, 0.2);
        }
        .logout-btn {
            display: block;
            width: 150px;
            margin: 20px auto;
            padding: 10px;
            background: red;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="Home.jsp">Home</a>
        <a href="#">Dashboard</a>
        <a href="Signout.jsp">Logout</a>
    </div>
    
    <div class="container">
        <h2>Welcome, <%= clientEmail %>!</h2>
        <table>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Skills</th>
                <th>Role</th>
                <th>Experience</th>
                <th>Resume</th>
            </tr>
            <%
                String jdbcURL = "jdbc:mysql://localhost:3306/mydb";
                String dbUser = "root";
                String dbPass = "root";
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);
                
                String sql = "SELECT * FROM job_applications WHERE client_id = (SELECT id FROM clients WHERE email=?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, clientEmail);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("skills") %></td>
                    <td><%= rs.getString("role") %></td>
                    <td><%= rs.getString("experience") %></td>
                    <td><a href="<%= rs.getString("resume") %>" download>Download</a></td>
                </tr>
            <%
                }
                rs.close();
                stmt.close();
                conn.close();
            %>
        </table>
        <a href="logout.jsp" class="logout-btn">Logout</a>
    </div>
</body>
</html>
