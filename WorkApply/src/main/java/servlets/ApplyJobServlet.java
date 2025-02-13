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



@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet("/ApplyJobServlet")
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String jdbcURL = "jdbc:mysql://localhost:3306/mydb"; 
        String dbUser = "root";  
        String dbPass = "root";  

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String skills = request.getParameter("skills");
            String role = request.getParameter("role");
            String experience = request.getParameter("experience");

            Part filePart = request.getPart("resume"); 
            String fileName = filePart.getSubmittedFileName();
            String savePath = "C:/uploads/" + fileName;

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

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

            String sql = "INSERT INTO job_applications (name, email, skills, role, experience, resume) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, skills);
            stmt.setString(4, role);
            stmt.setString(5, experience);
            stmt.setString(6, savePath);
            
            int result = stmt.executeUpdate();

            if (result > 0) {
                out.println("<h3>Job application submitted successfully!</h3>");
            } else {
                out.println("<h3>Error submitting application. Try again.</h3>");
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
    }
}
