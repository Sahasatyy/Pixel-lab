<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="Model.User.UserMessage" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Account</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/header.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --font-family: "Poppins", sans-serif;
        }

        body {
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url(<%=request.getContextPath()%>/images/loginback.jpg);
            background-color: lightgray;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }

        .container {
            max-width: 350px;
            background-color: rgba(255, 255, 255, 0.461);
            border-radius: 15px;
            overflow: hidden;
        }

        form {
            display: flex;
            align-items: center;
            flex-direction: column;
            padding: 32px 24px 24px;
            gap: 16px;
            text-align: center;
        }

        ::placeholder {
            color: #000000;
            font-family: var(--font-family);
        }

        form .head {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        form .head span {
            font-size: 1.6rem;
            font-weight: bolder;
            color: black;
            font-family: var(--font-family);
        }

        form .head p {
            font-size: 1.1rem;
            color: #000000;
            font-family: var(--font-family);
        }

        form .inputs {
            overflow: hidden;
            background-color: #fff;
            width: 100%;
            margin: 1rem 0.5rem;
            border-radius: 8px;
            border-bottom: none;
            outline: 0;
        }

        form .inputs input {
            border: none;
            outline: none;
            padding: 8px 15px;
            width: 100%;
            height: 40px;
            border-bottom: 1px solid rgba(128, 128, 128, 0.299);
            font-weight: 200;
        }

        input[type=text] {
            background-color: rgba(255, 255, 255, 0.461);
        }

        form button {
            font-family: var(--font-family);
            background-color: #4287ef;
            color: white;
            width: 100%;
            height: 40px;
            padding-top: 8px;
            padding-bottom: 8px;
            border: 0;
            overflow: hidden;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 1s ease-in-out;
        }

        form button:hover {
            background-color: #005ce6;
        }

        .form-footer {
            font-family: var(--font-family);
            background-color: #e0ecfb;
            padding: 16px;
            font-size: 1rem;
            text-align: center;
            height: 20px;
        }

        .form-footer a {
            font-family: var(--font-family);
            font-weight: bolder;
            color: #0066ff;
            transition: all 3s ease-in-out;
        }

        .form-footer a:hover {
            color: #005ce6;
        }
    </style>
</head>

<body>

    <section class="content">
        <div class="container">
            <form name="registerForm" action="<%=request.getContextPath()%>/Register" method="post" enctype="multipart/form-data">
                <div class="head">
                    <span class="form_title">Create an Account</span>
                    
                    <%
                    UserMessage msg = (UserMessage)session.getAttribute("Message");
                    if (msg != null) {
                    %>
                    <div class="alert alert-info"><%=msg.getMessageCssClass() %></div>
                    <%
                        session.removeAttribute("Message");
                    }
                    %>
                </div>
                
                <div class="inputs">
                    <input type="text" name="FirstName" id="FirstName" placeholder="First Name" required>
                </div>

                <div class="inputs">
                    <input type="text" name="LastName" id="LastName" placeholder="Last Name" required>
                </div>

                <div class="inputs">
                    <input type="tel" name="Contact" id="Contact" placeholder="Contact Number" required>
                </div>

                <div class="inputs">
                    <input type="email" name="Email" id="Email" placeholder="Email Address" required>
                </div>

                <div class="inputs">
                    <input type="password" name="Password" id="Password" placeholder="Create Password" required>
                </div>

                <div class="inputs">
                    <input type="file" name="ProfilePicture" id="ProfilePicture" accept="image/*">
                </div>

                <button type="submit" value="send">Register Now</button>

                <div class="form-footer">
                    Already have an account? <a href="login.jsp">Login</a>
                </div>
            </form>
        </div>
    </section>
</body>
</html>