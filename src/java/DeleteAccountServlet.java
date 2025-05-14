
import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idNumber = request.getParameter("idNumber");
        String password = request.getParameter("password");
        String message = "";
        String error = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/registeredData", "root", "12345");

            // Check if user exists
            PreparedStatement checkStmt = conn.prepareStatement(
                    "SELECT * FROM users WHERE id_number = ? AND password = ?");
            checkStmt.setString(1, idNumber);
            checkStmt.setString(2, password);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Delete user
                PreparedStatement deleteStmt = conn.prepareStatement(
                        "DELETE FROM users WHERE id_number = ? AND password = ?");
                deleteStmt.setString(1, idNumber);
                deleteStmt.setString(2, password);
                int rows = deleteStmt.executeUpdate();

                if (rows > 0) {
                    message = "Your account was successfully deleted.";
                    HttpSession session = request.getSession(false);
                    if (session != null) {
                        session.invalidate();
                    }
                } else {
                    error = "Error deleting account.";
                }
            } else {
                error = "Invalid ID number or password.";
            }

            conn.close();
        } catch (Exception e) {
            error = "Error: " + e.getMessage();
        }

        request.setAttribute("message", message);
        request.setAttribute("error", error);
        request.getRequestDispatcher("deleteAccount.jsp").forward(request, response);
    }
}
