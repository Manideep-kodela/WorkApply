package servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


// Enable file upload
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet("/ApplyInternshipServlet")
public class ApplyInternshipServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Database Connection Parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/mydb"; // Replace with your database name
        String dbUser = "root";  // Replace with your MySQL username
        String dbPass = "root";  // Replace with your MySQL password

        try {
            // Get form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String skills = request.getParameter("skills");
            String role = request.getParameter("Role");

            // Handle File Upload
            Part filePart = request.getPart("resume"); 
            String fileName = filePart.getSubmittedFileName();
            String savePath = "C:/uploads/" + fileName; // Change this path as needed
            
            // Save file on the server
            File fileSaveDir = new File("C:/uploads/");
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdir();
            }
            FileOutputStream fos = new FileOutputStream(savePath);
            InputStream is = filePart.getInputStream();
            byte[] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
            fos.close();
            is.close();

            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

            // Insert data into MySQL table
            String sql = "INSERT INTO internship_applications (name, email, skills, role, resume) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, skills);
            stmt.setString(4, role);
            stmt.setString(5, savePath);
            
            int result = stmt.executeUpdate();

            if (result > 0) {
                out.println("<h3>Application submitted successfully!</h3>");
            } else {
                out.println("<h3>Error submitting application. Try again.</h3>");
            }

            // Close resources
            stmt.close();
            conn.close();

        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
    }
}
