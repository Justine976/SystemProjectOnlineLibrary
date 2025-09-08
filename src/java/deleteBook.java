
import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/deleteBook")
public class deleteBook extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/registeredData", "root", "");
            
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM books WHERE id = ?");
            stmt.setInt(1, id);

            stmt.executeUpdate();
            response.sendRedirect("manageBooks.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("Error: " + e.getMessage());
        }
    }
}
