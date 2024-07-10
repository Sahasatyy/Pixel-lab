<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<!--Including the core tag library-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--Including the formatting tag library-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!--Including the SQL tag library-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="Model.User.User"%>
<%
User admin = (User)session.getAttribute("User");
if (admin == null || !admin.getEmailAddress().equals("admin@gmail.com")) {
    response.sendRedirect("../login.jsp");
}
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Order Summary</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
    /* General Styles */
    body {
        font-family: 'Montserrat', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
    }

    .content {
        padding: 40px;
    }

    /* Button Styles */
    .btn {
        background-color: #6c63ff;
        color: #fff;
        border: none;
    }
    .btn,
    .btn2 {
        display: inline-block;
        padding: 8px 16px;
        font-size: 14px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s ease;
        margin-right: 5px;
    }

    .btn:hover {
        background-color: #5a4fec;
    }
    
    /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 205px; /* Adjust the width as needed */
            background-color: #FAFAFA; /* Change the background color as desired */
            padding-top: 150px;
            padding-right: 20px;
            box-sizing: border-box;
        }

        .sidebar .btn {
            display: block; /* Change display to block for vertical alignment */
            margin-bottom: 10px; /* Add some spacing between buttons */
            width: 100%; /* Make the buttons take full width */
            text-align: left; /* Align text to the left */
            padding: 10px; /* Add some padding */
        }
        
        .active{
        	background-color: #5a4fec;	
        
        }

    /* Table Styles */
    .order_list {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        background-color: #fff;
    }

    .order_list th,
    .order_list td {
        padding: 12px 15px;
        text-align: left;
    }

    .order_list th {
        background-color: #6c63ff;
        color: #fff;
        font-weight: bold;
    }

    .order_list tr:nth-child(even) {
        background-color: #f8f8f8;
    }

    .order_list tr:hover {
        background-color: #f0f0f0;
    }

    .order_list td img {
        max-width: 80px;
        height: auto;
        border-radius: 4px;
    }

    /* Container Styles */
    .main_content2 {
        max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
</style>
</head>
<body>
<%@include file="header.jsp"%>
<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/pixellab" user="root" password="" />
<sql:query var="allProduct" dataSource="${dbConnection}">
    SELECT u.FirstName, o.UserEmail, p.ProductName, p.productImage, COUNT(*) AS ProductsOrdered
    FROM `Order` o
    INNER JOIN users u ON u.Email COLLATE utf8mb4_general_ci = o.UserEmail
    INNER JOIN product p ON p.id = o.id
    GROUP BY o.UserEmail, u.FirstName, p.ProductName, p.productImage;
</sql:query>

<!--This is the section of the webpage that contains all of the main content-->
<section class="content">
        <div class="sidebar">
        <a href="admin.jsp" class="btn">Manage Products</a>
        <div class ="active"><a href="orderList.jsp" class="btn">View Orders</a></div>
        <a href="productAction.jsp" class="btn">Update/Delete</a>
    </div>
    
    <div class="main_content2">
        <div class="order_list_box">
            <table class="order_list">
                <thead>
                    <tr>
                        <th>Customer Name</th>
                        <th>Customer Email</th>
                        <th>Product Name</th>
                        <th>Product Image</th>
                        <th>Products Ordered</th>
                    </tr>
                </thead>
                <c:forEach var="product" items="${allProduct.rows}">
                    <tr>
                        <td>${product.FirstName}</td>
                        <td>${product.UserEmail}</td>
                        <td>${product.ProductName}</td>
                        <td><img src="<%=request.getContextPath()%>/images/product-images/${product.productImage}" alt="Product Image"></td>
                        <td>${product.ProductsOrdered}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</section>
</body>
</html>