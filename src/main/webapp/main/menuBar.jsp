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
	        <!--  회사개요페이지 아직 미완성 -->
	        <li class="nav-item">
	            <a class="nav-link" href="about.html">회사개요</a>
	        </li>
	        <li class="nav-item">
	            <a class="nav-link" href="<%=request.getContextPath()%>/product/productList.jsp" id="navbarDropdown_1">
	                상품
	            </a>
	            <!--  우선 사용안하니 주석처리
	            <div class="dropdown-menu" aria-labelledby="navbarDropdown_1">
	                <a class="dropdown-item" href="<%=request.getContextPath()%>/product/productList.jsp"> 상품 목록</a>
	            </div>
	             -->
	        </li>
	        <!-- 공지사항 관리자는 공지사항추가 목록 나옴 -->
	        <%
	        	if(session.getAttribute("loginEmpId1") != null || session.getAttribute("loginEmpId2") != null) {
	        %>
	        		<li class="nav-item dropdown">
			            <a class="nav-link dropdown-toggle" href="<%=request.getContextPath()%>/notice/noticeList.jsp">
			            	공지사항
			            </a>
			            <div class="dropdown-menu" aria-labelledby="navbarDropdown_2">
			            	<a class="dropdown-item" href="<%=request.getContextPath()%>/notice/insertNotice.jsp">공지사항 추가</a>
			            </div>
		       		</li>
            <%
            	// 일반고객은 공지사항만 표시
        		} else {
        	%>
        			<li class="nav-item">
	    	            <a class="nav-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp">
	    	            	공지사항
	    	            </a>
    	        	</li>
        	<% 	
        		}
       		%>
	        <%
	        	if(session.getAttribute("loginEmpId1") != null || session.getAttribute("loginEmpId2") != null) {
	        %>
			    <li class="nav-item dropdown">
		            <a class="nav-link dropdown-toggle" href="blog.html" id="navbarDropdown_2"
		                role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                관리자페이지
		            </a>
		            <div class="dropdown-menu" aria-labelledby="navbarDropdown_2">
		                <a class="dropdown-item" href="<%=request.getContextPath()%>/employee/employeeInfo.jsp"> 관리자정보</a>
		                <a class="dropdown-item" href="<%=request.getContextPath()%>/category/categoryList.jsp">카테고리 관리</a>
		    <%	// 관리자2만 상품관리가 가능
		        	if(session.getAttribute("loginEmpId2") != null || session.getAttribute("loginEmpId1") != null) {
		    %>	
           				<a class="dropdown-item" href="<%=request.getContextPath()%>/product/empProductList.jsp">상품관리(리스트로)</a>
		            </div>
	        	</li>
		    <%
		            } 
		        } else { 
		    %>
		    		<li class="nav-item">
			    		<a class="nav-link" href="<%=request.getContextPath()%>/customer/customerInfo.jsp" id="navbarDropdown_1">
							마이페이지
						</a>
					</li>
	        <%
	        	}
	        %>
	        
	        <!-- 이 리스트 사용안함 현재 
	        <li class="nav-item dropdown">
	            <a class="nav-link dropdown-toggle" href="blog.html" id="navbarDropdown_3"
	                role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                login
	            </a>
	            <div class="dropdown-menu" aria-labelledby="navbarDropdown_2">
			        <a class="dropdown-item" href="<%=request.getContextPath()%>/login/login.jsp">login</a>
	                <a class="dropdown-item" href="checkout.html">product checkout</a>
	                <a class="dropdown-item" href="cart.html">shopping cart</a>
	                <a class="dropdown-item" href="confirmation.html">confirmation</a>
	                <a class="dropdown-item" href="elements.html">elements</a>
	                
	            </div>
	        </li>
	        -->
	        <%
	        	if(session.getAttribute("loginEmpId1") == null && session.getAttribute("loginEmpId2") == null && session.getAttribute("loginCstmId") == null) {
		    %>
			        <li class="nav-item">
			        	<a class="nav-link" href="<%=request.getContextPath()%>/login/login.jsp">
			            	login
			            </a>
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