<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Delete Account</title>
        <link href="images/library-logo.png" rel="icon">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <header>
            <a href="user.jsp">BACK</a>
        </header>
        <div class="center-wrapper">
            <div class="login-container">
                <h2>Delete Your Account</h2>
                <form action="DeleteAccountServlet" method="post">
                    <input type="text" name="idNumber" placeholder="ID Number" required><br>
                    <input type="password" name="password" id="password" placeholder="Password" required><br>
                    <input id="show-password" type="checkbox" onclick="togglePassword()"> 
                    <label for="show-password">Show Password</label><br>
                    <p class="message">${message}</p>
                    <p class="error">${error}</p>
                    <button type="submit" >Delete Account</button>
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
