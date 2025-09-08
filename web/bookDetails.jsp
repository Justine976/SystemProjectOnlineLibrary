<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    if (id == null) {
        response.sendRedirect("home.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/registeredData", "root", "");
        ps = conn.prepareStatement("SELECT * FROM books WHERE id = ?");
        ps.setInt(1, Integer.parseInt(id));
        rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book Details - Online Library</title>
        <link href="images/library-logo.png" rel="icon">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <header>
            <a href="home.jsp">BACK</a>
        </header>
        <main class="center-wrapper">
            <section>
                <% if (rs.next()) {%>
                <img src="<%= rs.getString("image_path")%>" alt="<%= rs.getString("title") != null ? rs.getString("title") : "Book Image"%>" width="200">
                <h2><%= rs.getString("title")%></h2><br>
                <h3>By: <%= rs.getString("author")%></h3><br>
                <p><%= rs.getString("description")%></p>
                <% } else { %>
                <p>Book not found.</p>
                <% } %>
            </section>
        </main>
        <footer>
            &copy; 2025 Online Library. All rights reserved.
        </footer>
    </body>
</html>
<%
    } catch (Exception e) {
        out.println("<p>Error loading book details.</p>");
        e.printStackTrace();
    } finally {
        if (rs != null) try {
            rs.close();
        } catch (SQLException ignored) {
        }
        if (ps != null) try {
            ps.close();
        } catch (SQLException ignored) {
        }
        if (conn != null) try {
            conn.close();
        } catch (SQLException ignored) {
        }
    }
%>
