<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Online Library</title>
        <link href="images/library-logo.png" rel="icon">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <header>
            <a href="index.html">BACK</a>
            <a href="registration.jsp">Register</a>
        </header>
        <div class="center-wrapper">
            <section>
                <h2>Login</h2>
                <form action="LoginServlet" method="post">
                    <input type="text" name="id_number" placeholder="ID Number" required><br>
                    <input type="password" name="password" id="password" placeholder="Password" required><br>
                    <input id="show-password" type="checkbox" onclick="togglePassword()"> 
                    <label for="show-password">Show Password</label><br>
                    <p class="error">${error}</p>
                    <button type="submit">Login</button>
                </form>
                <p>Don`t have an account? <a href="registration.jsp">Register</a></p>
            </section>
        </div>
        <footer>
            &copy; 2025 Online Library. All rights reserved.
        </footer>
        <script>
            function togglePassword() {
                var x = document.getElementById("password");
                x.type = x.type === "password" ? "text" : "password";
            }
        </script>
    </body>
</html>
