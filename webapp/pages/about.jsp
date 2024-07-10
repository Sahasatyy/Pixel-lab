<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.0.0/fonts/remixicon.css" rel="stylesheet"/>
    <style>
      .cart {
    position: absolute;
    right: 100px;
    margin-top: 8px;
}

.cart .button {
    position: absolute;
    font-size: 25px;
    color: black;
}

.aboutus {
    display: flex;
    gap: 40px;
}

.aboutus1 {
    display: flex;
    margin-left: 270px;
    gap: 40px;
}

.flip-card {
    margin-top: 120px;
    margin-left: 95px;
    background-color: transparent;
    width: 350px;
    height: 350px;
    perspective: 1000px;
    font-family: sans-serif;
}

.title {
    font-size: 1.5em;
    font-weight: 900;
    text-align: center;
    margin: 0;
}

.role {
    font-size: 12px;
    font-weight: 1000;
}

.flip-card-inner {
    position: relative;
    width: 100%;
    height: 100%;
    text-align: center;
    transition: transform 0.8s;
    transform-style: preserve-3d;
}

.flip-card:hover .flip-card-inner {
    transform: rotateY(180deg);
}

.flip-card-front,
.flip-card-back {
    box-shadow: 0 8px 14px 0 rgba(0, 0, 0, 0.2);
    position: absolute;
    display: flex;
    flex-direction: column;
    justify-content: center;
    width: 100%;
    height: 100%;
    -webkit-backface-visibility: hidden;
    backface-visibility: hidden;
    border: 1px solid rgb(241, 237, 237);
    border-radius: 1rem;
}

.flip-card-back p {
    border: 1px solid rgb(255, 255, 255);
    margin-bottom: 30px;
}

.cardbuttons {
    gap: 20px;
    display: flex;
    flex-direction: row;
    justify-content: center;
}

.flip-card-back a {
    text-decoration: none;
    color: black;
    border-radius: 60%;
    padding: 5px 7px;
    font-size: 29px;
}

.flip-card-back a:nth-child(1):hover {
    background: linear-gradient(#f9ce34, #ee2a7b, #6228d7);
}

.flip-card-back a:nth-child(2):hover {
    background: linear-gradient(#1901f3, #ffffff);
}

.flip-card-back a:nth-child(3):hover {
    background: linear-gradient(#0A66C2, #0A66C2);
}

.flip-card-front {
    background: #fafafa;
}

.flip-card-front img {
    margin-bottom: 19px;
    width: 60%;
    margin-left: 65px;
    border-radius: 50%;
}

.flip-card-back {
    background: #fafafa;
    color: white;
    transform: rotateY(180deg);
}
    </style>
</head>
<body>
    <!-- navbar starts here -->
    <%@include file="header.jsp"%>
    <!-- navbar ends here -->
    <div class="card">
        <div class="aboutus">
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                     	<img src="<%= request.getContextPath() %>/images/taukir.jpg" width="200" alt="">
                        <p class="title">MD Taukir Reza</p>
                        <p class="role">Back End Developer</p>
                    </div>
                    <div class="flip-card-back">
                        <p style="color: black;" class="title">9762717838 jackhart3312@gmail.com</p>
                        <div class="cardbuttons">
                            <a class="button" href=""><i class="ri-instagram-line"></i></a>
                            <a class="button" href=""><i class="ri-facebook-fill"></i></a>
                            <a class="button" href=""><i class="ri-linkedin-fill"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                    	<img src="<%= request.getContextPath() %>/images/sahas.jpg" width="200" alt="">                       
                    	<p class="title">Sahas Amatya</p>
                        <p class="role">Graphic Designer</p>
                    </div>
                    <div class="flip-card-back">
                        <p style="color: black;" class="title"> </p>
                        <div class="cardbuttons">
                            <a class="button" href=""><i class="ri-instagram-line"></i></a>
                            <a class="button" href=""><i class="ri-facebook-fill"></i></a>
                            <a class="button" href=""><i class="ri-linkedin-fill"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                    	<img src="<%= request.getContextPath() %>/images/srijan.jpg" width="200" alt="">                        
                    	<p class="title">Srijan Bhattarai</p>
                        <p class="role">Front End Developer</p>
                    </div>
                    <div class="flip-card-back">
                        <p style="color: black;" class="title"> </p>
                        <div class="cardbuttons">
                            <a class="button" href=""><i class="ri-instagram-line"></i></a>
                            <a class="button" href=""><i class="ri-facebook-fill"></i></a>
                            <a class="button" href=""><i class="ri-linkedin-fill"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="aboutus1">
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                    	<img src="<%= request.getContextPath() %>/images/sohil.jpg" width="200" height="240px" alt="">                        
                    	<p class="title">Sohil Maharjan</p>
                        <p class="role">Front End Developer</p>
                    </div>
                    <div class="flip-card-back">
                        <p style="color: black;" class="title"> </p>
                        <div class="cardbuttons">
                            <a class="button" href=""><i class="ri-instagram-line"></i></a>
                            <a class="button" href=""><i class="ri-facebook-fill"></i></a>
                            <a class="button" href=""><i class="ri-linkedin-fill"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
						<img src="<%= request.getContextPath() %>/images/sanish1.jpg" width="200" height="240px" alt="">                        
						<p class="title">Sanish Piya</p>
                        <p class="role">Junior Developer</p>
                    </div>
                    <div class="flip-card-back">
                        <p style="color: black;" class="title">9843218769 piyame04@gmail.com </p>
                        <div class="cardbuttons">
                            <a class="button" href=""><i class="ri-instagram-line"></i></a>
                            <a class="button" href=""><i class="ri-facebook-fill"></i></a>
                            <a class="button" href=""><i class="ri-linkedin-fill"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>