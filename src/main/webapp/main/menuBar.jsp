<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="collapse navbar-collapse main-menu-item" id="navbarSupportedContent">
		<ul class="navbar-nav">
			<li class="nav-item">
	            <a class="nav-link" href=""></a>
	        </li>
	    	<li class="nav-item">
	            <a class="nav-link" href="<%=request.getContextPath()%>/main/home.jsp">Home</a>
	        </li>
	        <li class="nav-item">
	            <a class="nav-link" href="about.html">about</a>
	        </li>
	        <li class="nav-item dropdown">
	            <a class="nav-link dropdown-toggle" href="blog.html" id="navbarDropdown_1"
	                role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                product
	            </a>
	            <div class="dropdown-menu" aria-labelledby="navbarDropdown_1">
	                <a class="dropdown-item" href="<%=request.getContextPath()%>/product/productList.jsp"> 상품 목록</a>
	                <a class="dropdown-item" href="single-product.html">product details</a>
	                
	            </div>
	        </li>
	        
	        <li class="nav-item dropdown">
	            <a class="nav-link dropdown-toggle" href="blog.html" id="navbarDropdown_3"
	                role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                pages
	            </a>
	            <div class="dropdown-menu" aria-labelledby="navbarDropdown_2">
			        <a class="dropdown-item" href="<%=request.getContextPath()%>/login/login.jsp">login</a>
	                <a class="dropdown-item" href="checkout.html">product checkout</a>
	                <a class="dropdown-item" href="cart.html">shopping cart</a>
	                <a class="dropdown-item" href="confirmation.html">confirmation</a>
	                <a class="dropdown-item" href="elements.html">elements</a>
	            </div>
	        </li>
	        
	        <li class="nav-item dropdown">
	            <a class="nav-link dropdown-toggle" href="blog.html" id="navbarDropdown_2"
	                role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                blog
	            </a>
	            <div class="dropdown-menu" aria-labelledby="navbarDropdown_2">
	                <a class="dropdown-item" href="blog.html"> blog</a>
	                <a class="dropdown-item" href="single-blog.html">Single blog</a>
	            </div>
	        </li>
	        
	        <li class="nav-item">
	            <a class="nav-link" href="contact.html">Contact</a>
	        </li>
	        <%
	        	if(session.getAttribute("loginEmpId1") != null || session.getAttribute("loginEmpId2") != null) {
	        %>
		         <li class="nav-item">
		            <a class="nav-link" href="<%=request.getContextPath()%>/employee/employeeInfo.jsp">관리자페이지</a>
		        </li>
	        <%
	        	}
	        %>
	        <%
	        	if(session.getAttribute("loginEmpId1") != null || session.getAttribute("loginEmpId2") != null || session.getAttribute("loginCstmId") != null) {
		    %>
			         <li class="nav-item">
			            <a class="nav-link" href="<%=request.getContextPath()%>/login/logoutAction.jsp">logout</a>
			        </li>
	        <%
	        	}
	        %>
		</ul>
	</div>
</body>
</html>