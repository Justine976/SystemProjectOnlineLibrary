
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.nio.file.Paths;

@WebServlet("/updateBook")
@MultipartConfig
public class updateBook extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");

        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/registeredData", "root", "12345");

            String sql;
            if (!fileName.isEmpty()) {
                // Update including image
                String uploadPath = getServletContext().getRealPath("") + "images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                filePart.write(uploadPath + File.separator + fileName);

                sql = "UPDATE books SET title=?, author=?, description=?, image_path=? WHERE id=?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, author);
                stmt.setString(3, description);
                stmt.setString(4, "images/" + fileName);
                stmt.setInt(5, id);
                stmt.executeUpdate();
            } else {
                // Update without image
                sql = "UPDATE books SET title=?, author=?, description=? WHERE id=?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, author);
                stmt.setString(3, description);
                stmt.setInt(4, id);
                stmt.executeUpdate();
            }

            response.sendRedirect("manageBooks.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("Error: " + e.getMessage());
        }
    }
}
