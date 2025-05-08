<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("user");
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
        <title>Home - Online Library</title>
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
                <a href="about.jsp">About</a>
                <a href="user.jsp"><%= user%></a>
            </nav>
        </header>
        <section>
            <h1>Welcome to the Online Library</h1>
            <p>Explore a world of knowledge and imagination. Discover books, read online, and manage your library from anywhere.</p>
        </section>
        <section class="book-suggestions">
            <h2>Popular Book Suggestions</h2>
            <div class="book-cards">
                <div class="book-card">
                    <img src="images/book.avif" alt="Book 1">
                    <div class="book-info">
                        <h3>Book Title 1</h3>
                        <p>Author: John Doe</p>
                    </div>
                </div>
                <div class="book-card">
                    <img src="images/book.avif" alt="Book 2">
                    <div class="book-info">
                        <h3>Book Title 2</h3>
                        <p>Author: Jane Smith</p>
                    </div>
                </div>
                <div class="book-card">
                    <img src="images/book.avif" alt="Book 3">
                    <div class="book-info">
                        <h3>Book Title 3</h3>
                        <p>Author: Mark Johnson</p>
                    </div>
                </div>
                <div class="book-card">
                    <img src="images/book.avif" alt="Book 1">
                    <div class="book-info">
                        <h3>Book Title 4</h3>
                        <p>Author: John Doe</p>
                    </div>
                </div>
                <div class="book-card">
                    <img src="images/book.avif" alt="Book 2">
                    <div class="book-info">
                        <h3>Book Title 5</h3>
                        <p>Author: Jane Smith</p>
                    </div>
                </div>
                <div class="book-card">
                    <img src="images/book.avif" alt="Book 3">
                    <div class="book-info">
                        <h3>Book Title 6</h3>
                        <p>Author: Mark Johnson</p>
                    </div>
                </div>
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
