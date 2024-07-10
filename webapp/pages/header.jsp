<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="Model.User.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Navigation Bar</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        header {
            background-color: #fafafa;
            padding: 2rem 9%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            z-index: 1000;
            box-shadow: 0 .5rem 1rem rgba(0, 0, 0, .1);
        }

        nav {
            display: flex;
            align-items: center;
        }

        nav span {
            margin-right: 20px;
        }

        ul {
            display: flex;
            gap: 30px;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        ul li {
            font-family: var(--font-family);
            font-size: 15px;
        }

        ul li a {
            text-decoration: none;
            position: relative;
            color: rgb(0, 0, 0);
            font-weight: 450;
        }

        ul li a::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -5px;
            width: 0;
            height: 2px;
            background-color: rgb(0, 0, 0);
            transition: width 0.3s ease;
        }

        ul li a:hover::after {
            width: 100%;
        }

        .login-signup {
            margin-left: auto;
        }

        .login-signup .button {
            font-size: 15px;
            display: inline-block;
            padding: 10px;
            background-color: #fafafa;
            color: #000000;
            text-decoration: none;
            border-radius: 5px;
            margin-left: 10px;
        }

        .login-signup .button i {
            color: rgb(0, 0, 0);
            font-size: medium;
            margin-right: 5px;
        }

        .cart {
        	display: inline-block;
        	margin-right: 5px;
            margin-left: 20px;
        }

        .cart .button {
            font-size: 25px;
            color: black;
            text-decoration: none;
        }
        
        .cart .button i {
            color: rgb(0, 0, 0);
            font-size: medium;
            margin-right: 5px;
        }
        
    </style>
</head>

<body>
    <%
    User user = (User) session.getAttribute("User");
    %>

    <header>
        <nav>
            <span><img src="<%= request.getContextPath() %>/images/download.png" alt="" srcset="" width="75px" height=""></span>
            <ul>
                <li><a href="<%= request.getContextPath() %>/pages/home.jsp" class="nav-link">HOME</a></li>
                <li><a href="<%= request.getContextPath() %>/pages/about.jsp" class="nav-link">ABOUT US</a></li>
            </ul>
            <div class="login-signup">
                <%
                if (user != null) {
                    if ("admin".equals(user.getRole())) {
                        out.print("<a href='" + request.getContextPath() + "/pages/admin.jsp' class='button'><i class='ri-user-line'></i>" + user.getFirstName() + "</a>");
                    } else {
                        out.print("<a href='" + request.getContextPath() + "/pages/profile.jsp' class='button'><i class='ri-user-line'></i>" + user.getFirstName() + "</a>");
                        out.print("<a href='" + request.getContextPath() + "/pages/Orders.jsp' class='button'><i class='ri-shopping-bag-line'></i>Orders</a>");
                    }
                    out.print("<a href='" + request.getContextPath() + "/LogoutServ' class='button'><i class='ri-logout-box-r-line'></i>Logout</a>");
                    // Show cart only if the user is logged in
                    out.print("<div class='cart'><a href='" + request.getContextPath() + "/pages/cart.jsp' class='button'><i class='ri-shopping-cart-line'></i></a></div>");
                } else {
                    out.print("<a href='" + request.getContextPath() + "/pages/login.jsp' class='button'><i class='ri-user-line'></i>Login</a>");
                    out.print("<a href='" + request.getContextPath() + "/pages/register.jsp' class='button'><i class='ri-user-add-line'></i>Sign Up</a>");
                }
                %>
            </div>
        </nav>
    </header>
</body>
</html>
