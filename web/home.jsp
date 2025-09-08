<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.html");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/registeredData", "root", "");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM books");
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
            <a class="logo" href="home.jsp">
                <img src="images/library-logo.png" alt="Online Library Logo">
                Online Library
            </a>
            <div class="menu-toggle" onclick="toggleMenu()">
                <span></span>
                <span></span>
                <span></span>
            </div>
            <nav id="nav">
                <a href="about.jsp">About</a>
                <a href="user.jsp"><%= user %></a>
            </nav>
        </header>
        <section>
            <h1>Welcome to the Online Library</h1>
            <p>Explore a world of knowledge and imagination. Discover books and manage your library from anywhere.</p>
        </section>
        <section>
            <h2>Books</h2>
            <div class="book-cards">
                <%
                    while (rs.next()) {
                %>
                <div class="book-card" onclick="location.href='bookDetails.jsp?id=<%= rs.getInt("id") %>'">
                    <img src="<%= rs.getString("image_path") %>" alt="Cover of <%= rs.getString("title") %>">
                    <h3>Title: <%= rs.getString("title") %></h3>
                    <p>Author: <%= rs.getString("author") %></p>
                </div>
                <%
                    }
                %>
            </div>
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
<%
    } catch (Exception e) {
        out.println("<p>Error loading books: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignore) {}
        if (stmt != null) try { stmt.close(); } catch (Exception ignore) {}
        if (conn != null) try { conn.close(); } catch (Exception ignore) {}
    }
%>
