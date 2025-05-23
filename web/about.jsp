<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About - Online Library</title>
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
                <a href="home.jsp">BACK</a>
            </nav>
        </header>
        <div class="center-wrapper">
            <section>
                <h1>Our Online Library</h1>
                <p>Welcome to our Online Library!<br>
                    Our mission is to provide easy access to a wide variety of books and resources to support learning, creativity, and personal growth.
                    Whether you're looking for fiction, non-fiction, academic papers, or reference materials, our library is here to offer you a world of knowledge at your fingertips.
                </p>
                <br><br>
                <h2>Our Features</h2>
                <p>Access thousands of books across various genres.<br>
                    Read books online.<br>
                    Personalized recommendations based on your reading preferences.<br>
                    Manage your book collection with a user-friendly interface.<br>
                    Join a community of readers and share book reviews.
                </p>
                <br><br>
                <h2>Our Vision</h2>
                <p>Our vision is to foster a global reading community, where knowledge is freely accessible to everyone. <br>
                    We believe in the power of books to transform lives and build a better future.
                </p>
                <br><br>
                <h2>Contact Us</h2>
                <p>If you have any questions or suggestions, feel free to reach out to us at <strong>contact@onlinelibrary.com</strong>.</p>
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
