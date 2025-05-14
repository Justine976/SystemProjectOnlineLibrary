<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("user");
    Boolean Admin = (Boolean) session.getAttribute("Admin");
    if (user == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Profile - Online Library</title>
        <link href="images/library-logo.png" rel="icon">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <header>
            <a class="logo" href="home.jsp">
                <img src="images/library-logo.png" alt="LOAD ERROR">
                Online Library
            </a>
            <div class="menu-toggle" onclick="toggleMenu()">
                <span></span>
                <span></span>
                <span></span>
            </div>
            <nav id="nav">
                <a href="home.jsp">Home</a>
                <a href="about.jsp">About</a>
            </nav>
        </header>
        <div class="center-wrapper">
            <section>
                <% if (Admin != null && Admin) { %>
                <h3>{ADMIN}</h3>
                <% }%>
                <h2>${firstName} ${lastName}</h2><br>
                <p><strong>ID Number: </strong>${id_number}</p><br>
                <p><strong>Email: </strong>${email}</p><br>
                <button onclick="location.href = 'logout.jsp'">Logout</button>
                <% if (Admin != null && Admin) { %>
                <button onclick="location.href = 'manageBooks.jsp'">Manage Books</button>
                <% }%>
                <a href="deleteAccount.jsp" class="delete">Delete Account</a>
            </section>
        </div>
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
