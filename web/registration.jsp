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
        <title>Registration - Online Library</title>
        <link href="images/library-logo.png" rel="icon">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <header>
            <a href="index.html">BACK</a>
            <a href="login.jsp">Login</a>
        </header>
        <div class="center-wrapper">
            <div class="reg-container">
                <form action="RegistrationServlet" method="post">
                    <h2>Registration</h2><br><br>
                    <div>
                    <label for="first_name">First Name</label><br>
                    <input type="text" name="first_name" required><br><br>
                    </div>
                    <div>
                    <label for="last_name">Last Name</label><br>
                    <input type="text" name="last_name" required><br><br>
                    </div>
                    <div>
                    <label for="id_number">ID Number</label><br>
                    <input type="text" name="id_number" required><br><br>
                    </div>
                    <div>
                    <label for="email">Email</label><br>
                    <input type="email" name="email" required><br><br>
                    </div>
                    <div>
                    <label for="password">Password</label><br>
                    <input type="password" name="password" id="password" required><br>
                    </div>
                    <input id="show-password" type="checkbox" onclick="togglePassword()"> 
                    <label for="show-password">Show Password</label><br>
                    <button type="submit">Register</button>
                    <p class="message">${message}</p>
                    <p class="error">${error}</p>
                    <p>Have an account? <a href="login.jsp">Login</a></p>
                </form>
            </div>
        </div>
        <footer>
            &copy; 2025 Online Library. All rights reserved.
        </footer>
        <script>
            function toggleMenu() {
                document.getElementById('nav').classList.toggle('active');
            }
            function togglePassword() {
                var x = document.getElementById("password");
                x.type = x.type === "password" ? "text" : "password";
            }
        </script>
    </body>
</html>
