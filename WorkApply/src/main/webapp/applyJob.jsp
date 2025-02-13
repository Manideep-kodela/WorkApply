<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Internship Application</title>
  <style>
    /* Navbar */
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

    /* Body and Background */
    body {
      font-family: Arial, sans-serif;
      background: url('https://www.techtammina.com/wp-content/uploads/2019/03/Tech-Tammina.png') no-repeat center center fixed;
      background-size: cover;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
      flex-direction: column;
    }

    body::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.5);
      z-index: -1;
    }

    /* Container */
    .container {
      background: rgba(255, 255, 255, 0.9);
      padding: 20px 53px 10px 21px;
      border-radius: 10px;
      box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
      width: 450px;
      text-align: left;
      opacity: 0;
      transform: scale(0.8);
      animation: fadeIn 0.5s ease-in-out forwards;
      margin-top: 80px; /* Push form down to avoid navbar overlap */
    }

    @keyframes fadeIn {
      to {
        opacity: 1;
        transform: scale(1);
      }
    }

    /* Form Styling */
    form {
      display: flex;
      flex-direction: column;
    }
    label {
      font-weight: bold;
      margin-top: 10px;
      text-align: left;
    }
    select {
      width: 100%;
      padding: 5px 0px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
      background-color: white;
      font-size: 16px;
      cursor: pointer;
    }
    input, button {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    button {
      background-color: #28a745;
      color: white;
      border: none;
      cursor: pointer;
    }
    button:hover {
      background-color: #218838;
    }

    /* Skills Section */
    .skills-container {
      text-align: left;
      margin: 10px 0;
    }
    .skill-box {
      display: inline-block;
      background: #f1f1f1;
      padding: 5px 10px;
      border-radius: 5px;
      margin: 5px;
    }
    .remove-skill {
      color: red;
      cursor: pointer;
      margin-left: 5px;
    }
  </style>
  <script>
    function validateForm() {
      var name = document.getElementById("name").value;
      var email = document.getElementById("email").value;
      var resume = document.getElementById("resume").files[0];

      if (name === "" || email === "" || !resume) {
        alert("Please fill in all required fields.");
        return false;
      }

      // File validation
      var allowedExtensions = /(\.pdf|\.doc|\.docx)$/i;
      if (!allowedExtensions.exec(resume.name)) {
        alert("Only PDF, DOC, and DOCX files are allowed.");
        return false;
      }

      if (resume.size > 5 * 1024 * 1024) { // 5MB limit
        alert("File size must be less than 5MB.");
        return false;
      }

      return true;
    }

    function addSkill() {
      var skillInput = document.getElementById("skillInput");
      var skillValue = skillInput.value.trim();
      if (skillValue === "") return;

      var skillContainer = document.getElementById("skillContainer");
      var skillElement = document.createElement("span");
      skillElement.classList.add("skill-box");
      skillElement.innerHTML = skillValue + ' <span class="remove-skill" onclick="removeSkill(this)">x</span>';
      skillContainer.appendChild(skillElement);

      skillInput.value = "";
    }

    function removeSkill(element) {
      element.parentElement.remove();
    }
  </script>
</head>
<body>
  <!-- Navigation Bar -->
  <div class="navbar">
    <img src="https://www.techtammina.com/wp-content/uploads/2022/04/techlogo.png" alt="Company Logo">
    <ul>
      <li><a href="welcome.jsp">Home</a></li>
      <li><a href="https://www.techtammina.com/" target="_blank">Profile</a></li>
      <li><a href="Logout.jsp">Logout</a></li>
    </ul>
  </div>

  <!-- Form Container -->
  <div class="container">
    <h1>Job Application</h1>
   <form action="ApplyJobServlet" method="post" enctype="multipart/form-data">
       <label for="name">Name:</label>
      <input type="text" id="name" name="name" required>

      <label for="email">Email:</label>
      <input type="email" id="email" name="email" required>

      <label for="skills">Skills:</label>
      <input type="text" id="skillInput" name="skills" placeholder="Enter skill and click Add">
      <button type="button" onclick="addSkill()">Add</button>
      <div id="skillContainer" class="skills-container"></div>
      
      <label for="Role">Select Role:</label>
      <select id="Role" name="role" required>
        <option value="" disabled selected>-- Select an Option --</option>
        <option value="Software Trainee">Software Trainee</option>
        <option value="IT Sales">IT Sales</option>
        <option value="Business Development Associate">Business Development Associate</option>
      </select>
          <label for="experience">Work Experience (Years):</label>
      <select id="experience" name="experience" required>
        <option value="" disabled selected>-- Select Experience --</option>
        <% for(int i = 0; i <= 12; i++) { %>
          <option value="<%= i %>"><%= i %> years</option>
        <% } %>
      </select>

      <label for="resume">Upload Resume (PDF/DOC, max 5MB):</label>
      <input type="file" id="resume" name="resume" accept=".pdf, .doc, .docx" required>

      <button type="submit">Submit Application</button>
   </form>
  </div>
</body>
</html>
