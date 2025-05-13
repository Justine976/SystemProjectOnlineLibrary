<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/registeredData", "root", "12345");

    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM books WHERE id = ?");
    stmt.setInt(1, id);
    ResultSet rs = stmt.executeQuery();

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Book</title>
        <link href="images/library-logo.png" rel="icon">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <header>
            <a href="manageBooks.jsp">BACK</a>
        </header>
        <section>
            <%                if (rs.next()) {
            %>
            <h2>Edit Book</h2>
            <form action="updateBook" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= id%>"><br><br>
                <label for="title">Title</label><br>
                <input type="text" name="title" value="<%= rs.getString("title")%>" required><br><br>
                <label for="author">Author</label><br>
                <input type="text" name="author" value="<%= rs.getString("author")%>" required><br><br>
                <label for="description">Description</label><br>
                <textarea name="description" required><%= rs.getString("description")%></textarea><br><br>
                <p>Current Image</p>
                <img src="<%= rs.getString("image_path")%>" width="200"><br><br>
                <label for="image">Change Image</label><br>
                <input type="file" name="image" accept="image/*"><br>
                <button type="submit">Update</button>
            </form>
            <%
                } else {
                    out.print("Book not found.");
                }
            %>
        </section>
        <footer>
            &copy; 2025 Online Library. All rights reserved.
        </footer>
        <script>
            function toggleMenu() {
                document.getElementById('nav').classList.toggle('active');
            }
        </script>
    </body>
</html>
