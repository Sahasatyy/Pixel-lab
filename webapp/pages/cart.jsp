<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="Model.User.User" %>
<%@page import="Model.User.UserMessage" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cart</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/header.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #F7F7F7;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .content {
            display: flex;
            justify-content: space-between;
            padding: 40px;
        }

        .cart-items {
            flex: 1;
            margin-right: 40px;
        }

        .cart-header {
            font-size: 36px;
            font-weight: 700;
            color: #333;
            margin-bottom: 40px;
        }

        .select-all {
            margin-bottom: 20px;
        }

        .select-all input[type="checkbox"] {
            margin-right: 10px;
        }

        .select-all label {
            font-size: 16px;
            font-weight: 500;
            color: #333;
        }

        .delete-btn {
            background-color: #FF6347;
            color: #FFF;
            border: none;
            border-radius: 4px;
            padding: 8px 16px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-left: 20px;
        }

        .delete-btn:hover {
            background-color: #FF4500;
        }

        .product {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            background-color: #FFF;
            padding: 20px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .product input[type="checkbox"] {
            margin-right: 10px;
        }

        .product img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
        }

        .product-details h4 {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }

        .brand {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }

        .price {
            font-size: 16px;
            font-weight: 600;
            color: #FF8C00;
            margin-bottom: 10px;
        }

        .quantity {
            display: flex;
            align-items: center;
        }

        .quantity button {
            background-color: transparent;
            border: none;
            font-size: 18px;
            color: #333;
            cursor: pointer;
            padding: 0;
            margin: 0 5px;
        }

        .quantity input[type="text"] {
            width: 40px;
            padding: 4px;
            text-align: center;
            border: 1px solid #CCC;
            border-radius: 4px;
            font-size: 14px;
        }

        .delete-icon {
            color: #FF6347;
            font-size: 18px;
            cursor: pointer;
            margin-left: 20px;
        }

        .order-summary {
            background-color: #FFF;
            padding: 20px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        .order-summary h3 {
            font-size: 24px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }

        .order-summary p {
            font-size: 16px;
            color: #666;
            margin-bottom: 10px;
        }

        .voucher-code {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .voucher-code input[type="text"] {
            width: 200px;
            padding: 8px;
            border: 1px solid #CCC;
            border-radius: 4px;
            font-size: 14px;
            margin-right: 10px;
        }

        .voucher-code button {
            background-color: #FF8C00;
            color: #FFF;
            border: none;
            border-radius: 4px;
            padding: 8px 16px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .voucher-code button:hover {
            background-color: #FF7F00;
        }

        .total {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }

        .total span {
            color: #FF8C00;
        }

        .checkout-btn {
            background-color: #FF8C00;
            color: #FFF;
            border: none;
            border-radius: 4px;
            padding: 12px 24px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        .checkout-btn:hover {
            background-color: #FF7F00;
        }
    </style>
</head>

<body>
    <%@include file="header.jsp"%>

    <section class="content">
        <div class="cart-items">
            <div class="cart-header">Your Shopping Cart</div>
            
            <%
            UserMessage msg = (UserMessage)session.getAttribute("Message");
            if (msg != null) {
            %>
            <div class="alert"><%=msg.getMessageContent() %></div>
            <%
                session.removeAttribute("Message");
            }
            %>
            
            <div class="select-all">
                <input type="checkbox" id="select-all">
                <label for="select-all">Select All Items</label>
                <button class="delete-btn">Delete</button>
            </div>

            <c:set var="totalPrice" value="0" />
            <c:forEach var="product" items="${cart}">
                <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/pixellab" user="root" password=""/>
                <sql:query var="productInfo" dataSource="${dbConnection}">
                    SELECT productName, productCategory, productBrand, productPrice, stockLeft, productImage FROM product WHERE id = ${product};
                </sql:query>
                <c:forEach var="info" items="${productInfo.rows}">
                    <div class="product">
                        <input type="checkbox">
                        <img src="<c:url value='/images/productfolder/${info.productImage}'/>" alt="${info.productName}">
                        <div class="product-details">
                            <h4>${info.productName}</h4>
                            <p class="brand">${info.productBrand}</p>
                            <p class="price">NPR ${info.productPrice}</p>
                            <div class="quantity">
                                <button class="minus">-</button>
                                <input type="text" value="1">
                                <button class="plus">+</button>
                                <form action="<%=request.getContextPath()%>/RemoveCart" method="post">
                                    <input type="hidden" name="id" value="${product}">
                                    <button type="submit" class="delete-icon">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <c:set var="totalPrice" value="${totalPrice + info.productPrice}" />
                </c:forEach>
            </c:forEach>
        </div>

        <div class="order-summary">
            <h3>Order Summary</h3>
            <p>Subtotal (<c:out value="${fn:length(cart)}" /> items): Rs <c:out value="${totalPrice}" /></p>
            <div class="voucher-code">
                <input type="text" placeholder="Enter Voucher Code">
                <button>Apply</button>
            </div>
            <p class="total">Total: <span>Rs <c:out value="${totalPrice}" /></span></p>
            <form action="<%=request.getContextPath()%>/Order" method="post">
                <input type="hidden" name="id" value="${product}" class="price">
                <input type="submit" name="Order" value="Proceed to Checkout" class="checkout-btn">
            </form>
        </div>
    </section>
</body>
</html>