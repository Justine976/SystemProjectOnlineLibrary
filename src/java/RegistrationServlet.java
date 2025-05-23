
import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = "";
        String error = "";

        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String idNumber = request.getParameter("id_number");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/registeredData", "root", "12345"
            );

            String sql = "INSERT INTO users (first_name, last_name, id_number, email, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, idNumber);
            stmt.setString(4, email);
            stmt.setString(5, password);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                message = "Registration successful! You can now <br><button onclick=\"location.href='login.jsp'\">Login</button>";
                // Forward to a page that displays the success message
            } else {
                error = "Error: Registration failed!";
            }

            conn.close();
        } catch (Exception e) {
            error = "Error: " + e.getMessage();
        }

        // Set the message and error attributes to forward them to the JSP
        request.setAttribute("message", message);
        request.setAttribute("error", error);

        // Forward to the registration JSP to display the result
        RequestDispatcher dispatcher = request.getRequestDispatcher("/registration.jsp");
        dispatcher.forward(request, response);
    }
}
