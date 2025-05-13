
import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String error = "";
        String idNumber = request.getParameter("id_number");
        String password = request.getParameter("password");

        // Database connection and login logic
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/registeredData", "root", "12345"
            );

            String sql = "SELECT * FROM users WHERE id_number = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, idNumber);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Set session attributes
                HttpSession session = request.getSession();
                session.setAttribute("id_number", rs.getString("id_number"));
                session.setAttribute("Admin", rs.getBoolean("Admin"));
                session.setAttribute("firstName", rs.getString("first_name"));
                session.setAttribute("user", rs.getString("first_name"));
                session.setAttribute("lastName", rs.getString("last_name"));
                session.setAttribute("email", rs.getString("email"));

                // Redirect to home.jsp
                response.sendRedirect("home.jsp");
            } else {
                error = "Invalid ID number or password.";
                request.setAttribute("error", error);
                // Forward to login.jsp with error message
                RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
                dispatcher.forward(request, response);
            }

            conn.close();
        } catch (Exception e) {
            error = "Error: " + e.getMessage();
            request.setAttribute("error", error);
            // Forward to login.jsp with error message
            RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
