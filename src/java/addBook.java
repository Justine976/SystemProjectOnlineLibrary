
import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.nio.file.Paths;


@WebServlet("/addBook")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class addBook extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String message = "";
        String error = "";

        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Save file to /images folder
        String uploadPath = getServletContext().getRealPath("") + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);

        // Save info to database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/registeredData", "root", "12345");

            String sql = "INSERT INTO books (title, author, description, image_path) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setString(3, description);
            stmt.setString(4, "images/" + fileName);

            stmt.executeUpdate();
            
            message = "Book Added";
            
        } catch (Exception e) {
            error = "Error: " + e.getMessage();
        }

        request.setAttribute("message", message);
        request.setAttribute("error", error);
        request.getRequestDispatcher("manageBooks.jsp").forward(request, response);
        
    }
}
