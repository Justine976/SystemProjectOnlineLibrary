<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("user");
    Boolean Admin = (Boolean) session.getAttribute("Admin");
    if (user == null || Admin != true) {
        response.sendRedirect("home.jsp");
        return;
    }
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/registeredData", "root", "12345");
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM books");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home - Online Library</title>
        <link href="images/library-logo.png" rel="icon">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <header>
            <a href="user.jsp">BACK</a>
        </header>
        <section>
            <h1>Books Management</h1><br>
            <h2>Add Book</h2><br>
            <form action="addBook" method="post" enctype="multipart/form-data">
                <input type="text" name="title" placeholder="Book Title" required><br>
                <input type="text" name="author" placeholder="Author" required><br>
                <textarea name="description" placeholder="Description" required></textarea><br>
                <input type="file" name="image" accept="image/*" required><br>
                <p class="message">${message}</p>
                <p class="error">${error}</p>
                <button type="submit">Add Book</button>
            </form>
        </section>
        <section>
            <h2>Book List</h2><br>
            <table border="1" cellpadding="10">
                <tr>
                    <th>Image</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
                <% while (rs.next()) {%>
                <tr>
                    <td><img src="<%= rs.getString("image_path")%>" width="100"></td>
                    <td><%= rs.getString("title")%></td>
                    <td><%= rs.getString("author")%></td>
                    <td><%= rs.getString("description")%></td>
                    <td>
                        <form action="editBook.jsp" method="get" >
                            <input type="hidden" name="id" value="<%= rs.getInt("id")%>">
                            <button type="submit">Edit</button>
                        </form>
                        <form action="deleteBook" method="post" onsubmit="return confirm('Are you sure?');">
                            <input type="hidden" name="id" value="<%= rs.getInt("id")%>">
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
                <% }%>
            </table>

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
