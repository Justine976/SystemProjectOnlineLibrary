<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    Boolean Admin = (Boolean) session.getAttribute("Admin");
    if (user == null || !Admin) {
        response.sendRedirect("home.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/registeredData", "root", "");

        stmt = conn.prepareStatement("SELECT * FROM books WHERE id = ?");
        stmt.setInt(1, id);
        rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Book - Online Library</title>
        <link href="images/library-logo.png" rel="icon">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <header>
            <a href="manageBooks.jsp">BACK</a>
        </header>
        <section>
            <% if (rs.next()) { %>
                <h2>Edit Book</h2>
                <form action="updateBook" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="<%= id %>"><br><br>
                    
                    <label for="title">Title</label><br>
                    <input type="text" name="title" value="<%= rs.getString("title") %>" required><br><br>
                    
                    <label for="author">Author</label><br>
                    <input type="text" name="author" value="<%= rs.getString("author") %>" required><br><br>
                    
                    <label for="description">Description</label><br>
                    <textarea name="description" required><%= rs.getString("description") %></textarea><br><br>
                    
                    <p>Current Image</p>
                    <img src="<%= rs.getString("image_path") %>" width="200"><br><br>
                    
                    <label for="image">Change Image</label><br>
                    <input type="file" name="image" accept="image/*"><br>
                    
                    <button type="submit">Update</button>
                </form>
            <% } else { %>
                <p>Book not found.</p>
            <% } %>
        </section>
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
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
