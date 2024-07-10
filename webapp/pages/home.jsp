<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@page import="Model.User.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/header.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #FFFFFF;
        }

        .content {
            padding: 40px;
            background-color: #FFFFFF;
            flex-grow: 1;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            grid-gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .product-card {
            position: relative;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            width: 300px;
            height: 400px;
            background-color: #FFFFFF;
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .product-image {
            height: 70%;
            width: 100%;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .product-image img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }

        .product-card:hover .product-image img {
            transform: scale(1.1);
        }

        .product-info {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 10px;
            background-color: rgba(255, 255, 255, 0.9);
            text-align: center;
            backdrop-filter: blur(10px);
            height: 30%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .product-name {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333333;
        }

        .product-price {
            font-size: 14px;
            font-weight: 500;
            color: #666666;
            margin-bottom: 5px;
        }

        .product-stock {
            font-size: 12px;
            color: #999999;
            margin-bottom: 10px;
        }

        .add-to-cart {
            display: inline-block;
            padding: 8px 16px;
            background-color: #333333;
            color: #FFFFFF;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            font-size: 14px;
        }

        .add-to-cart:hover {
            background-color: #666666;
        }

        /* Carousel Styles */
        .carousel {
            position: relative;
            width: 100%;
            overflow: hidden;
        }

        .carousel-inner {
            display: flex;
            transition: transform 0.5s ease;
        }

        .carousel-item {
            flex: 0 0 100%;
            display: none;
        }

        .carousel-item.active {
            display: block;
        }

        .carousel-item img {
            width: 100%;
            height: auto;
        }

        .carousel-nav {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 100%;
            display: flex;
            justify-content: space-between;
            padding: 0 20px;
            z-index: 1;
        }

        .carousel-prev,
        .carousel-next {
            background: rgba(0, 0, 0, 0.5);
            border: none;
            font-size: 24px;
            color: #fff;
            cursor: pointer;
            padding: 10px;
            border-radius: 50%;
        }
        .product-section {
    		align-items: center;
    	}
    	
    	.product-head{
    		background-color: #fafafa;
    		border-radius: 5px;
    		margin-left: 32px;
    		position: relative;
    		margin-top: 20px;
    		display: flex;
    		/* border: 2px solid gold; */
    		height: 165px;
    		gap: 50px;
    		justify-content: center;

  }
  
        
        .product-head1 img {
            align-items: center;
            /* width:80px ; */
            margin-left: 50px;
            /* margin-bottom: 20px; */
       	}
        
    </style>
</head>

<body>
    <%@include file="header.jsp"%>

    <%
    String sort = request.getParameter("sort");
    String orderBy = "id"; // Default sorting order
    String query = "SELECT id, productName, productCategory, productBrand, productPrice, productImage, stockLeft FROM product ORDER BY ";

    if (sort != null && sort.equalsIgnoreCase("productPrice DESC")) {
        query += "productPrice DESC";
    } else {
        query += "productPrice ASC";
    }
    %>

    <section class="content">
        <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/pixellab" user="root" password=""/>
        <sql:query var="allProduct" dataSource="${dbConnection}">
            <%=query %>
        </sql:query>
        
        <!-- Banner Slider HTML -->
        <div class="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    
                        <img src="<%=request.getContextPath()%>/images/banner-1.jpg" alt="Slide 1">
                    
                </div>
                <div class="carousel-item">
                    
                        <img src="<%=request.getContextPath()%>/images/banner-3.jpg" alt="Slide 2">
                    
                </div>
                <div class="carousel-item">
                    
                        <img src="<%=request.getContextPath()%>/images/banner-4.webp" alt="Slide 3">
                    
                </div>
                <div class="carousel-item">
                    
                        <img src="<%=request.getContextPath()%>/images/banner-2.jpg" alt="Slide 3">
                    
                </div>
            </div>
            <div class="carousel-nav">
                <button class="carousel-prev">&lt;</button>
                <button class="carousel-next">&gt;</button>
            </div>
        </div>
        
        <div class="product-section">
        	<div class="product-head">
        	<div class="product-head1">
            	<img src="<%=request.getContextPath()%>/images/free deliverly.png" width="80px" alt="" >
            	<h2 >Free Delivery</h2>
        	</div>
        	<div class="product-head1">
            	<img src="<%=request.getContextPath()%>/images/7days.png" width="80px" >
            	<h2 >7 Days return</h2>
        	</div>
        	<div class="product-head1">
            	<img src="<%=request.getContextPath()%>/images/premium.png"  width="80px" alt="" >
            	<h2 >Premium Quality</h2>
        	</div>
    	</div>

		<!-- Product grid -->
        <div class="product-grid">
            <c:forEach var="product" items="${allProduct.rows}">
                <form action="<%=request.getContextPath()%>/cart" method="post">
                    <div class="product-card">
                        <div class="product-image">
                            <img src="<c:url value='/images/productfolder/${product.productImage}'/>" alt="${product.productName}">
                        </div>
                        <div class="product-info">
                            <div>
                                <h3 class="product-name">${product.productName}</h3>
                                <p class="product-price">Rs ${product.productPrice}</p>
                            </div>
                            <input type="hidden" name="id" value="${product.id}">
                            <input type="submit" class="add-to-cart" name="add_product" value="Add to Cart">
                        </div>
                    </div>
                </form>
            </c:forEach>
        </div>
    </section>

    <script>
        // JavaScript for Banner Slider
        const carousel = document.querySelector('.carousel');
        const carouselInner = carousel.querySelector('.carousel-inner');
        const carouselItems = carousel.querySelectorAll('.carousel-item');
        const prevButton = carousel.querySelector('.carousel-prev');
        const nextButton = carousel.querySelector('.carousel-next');
        let currentIndex = 0;

        prevButton.addEventListener('click', () => {
            currentIndex = (currentIndex - 1 + carouselItems.length) % carouselItems.length;
            updateCarousel();
        });

        nextButton.addEventListener('click', () => {
            currentIndex = (currentIndex + 1) % carouselItems.length;
            updateCarousel();
        });

        function updateCarousel() {
            carouselItems.forEach((item, index) => {
                if (index === currentIndex) {
                    item.classList.add('active');
                } else {
                    item.classList.remove('active');
                }
            });
        }

        // Auto play functionality (optional)
        setInterval(() => {
            nextButton.click();
        }, 5000); // Change slide every 5 seconds
    </script>
</body>
</html>