
import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
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
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/registeredData", "root", "");
            
            Statement stm = conn.createStatement();
            String crateTableUsers = "CREATE TABLE IF NOT EXISTS users (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "Admin BOOLEAN DEFAULT FALSE," +
                    "first_name VARCHAR(250)," +
                    "last_name VARCHAR(250)," +
                    "id_number INT UNIQUE," +
                    "email VARCHAR(250)," +
                    "password VARCHAR(250))";
            stm.execute(crateTableUsers);
            
            String createTableBooks = "CREATE TABLE IF NOT EXISTS books (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "title VARCHAR(255) UNIQUE," +
                    "author VARCHAR(255)," +
                    "description TEXT," +
                    "image_path VARCHAR(255))";
            stm.execute(createTableBooks);

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
