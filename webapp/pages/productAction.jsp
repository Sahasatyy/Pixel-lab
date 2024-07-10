<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<style>

	.main_content {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
    .product_list_box {
         max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .product_list {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        background-color: #fff;
    }

    .product_list th,
    .product_list td {
        padding: 12px 15px;
        text-align: left;
    }

    .product_list th {
        background-color: #6c63ff;
        color: #fff;
        font-weight: bold;
    }

    .product_list tr:nth-child(even) {
        background-color: #f8f8f8;
    }

    .product_list tr:hover {
        background-color: #f0f0f0;
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

    .btn {
        background-color: #6c63ff;
        color: #fff;
        border: none;
    }

    .btn:hover {
        background-color: #5a4fec;
    }

    .btn2 {
        background-color: #dc3545;
        color: #fff;
        border: none;
    }

    .btn2:hover {
        background-color: #c82333;
    }
    
    /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 208px; /* Adjust the width as needed */
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
        
</style>
    <%@include file="header.jsp"%>
    
    

<section class="content">
<div class="sidebar">
 <div class="sidebar-content">
        <a href="admin.jsp" class="btn">Manage Products</a>
        <a href="orderList.jsp" class="btn">View Orders</a>
        <div class="active"><a href="productAction.jsp" class="btn">Update/Delete</a></div>
    </div>
</div>    
<div class="product_list_box">
    <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/pixellab" user="root" password=""/>
    <sql:query var="allProduct" dataSource="${dbConnection}">
        SELECT id, productName, productCategory, productBrand, productPrice, productImage, stockLeft FROM product;
    </sql:query>

    <table class="product_list">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Product Category</th>
                <th>Product Brand</th>
                <th>Product Price</th>
                <th>Stock Left</th>
                <th>Action</th>
            </tr>
        </thead>
        <c:forEach var="product" items="${allProduct.rows}">
            <tr>
                <td>${product.productName}</td>
                <td>${product.productCategory}</td>
                <td>${product.productBrand}</td>
                <td>${product.productPrice}</td>
                <td>${product.stockLeft}</td>
                <td>
                    <form action="<%=request.getContextPath()%>/pages/UpdateProduct.jsp" method="Get" style="display: inline-block;">
                        <input type="hidden" name="id" value="${product.id}" />
                        <button type="submit" class="btn">Edit</button>
                    </form>
                    <form action="<%=request.getContextPath()%>/DeleteProds" method="post" style="display: inline-block;">
                        <input type="hidden" name="id" value="${product.id}" />
                        <button type="submit" class="btn2">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</section>