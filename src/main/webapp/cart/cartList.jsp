<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@page import="java.util.*"%>

<%
	String id = "customer1";


	// dao 클래스 객체 생성
	CartDao cartDao = new CartDao();
	
	// 장바구니 상품 리스트 selectCartList
	ArrayList<HashMap<String, Object>> list = cartDao.selectCartList(id);










%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<h1>장바구니</h1>
	<table class="table">
		<tr>
		
			<th>&nbsp;</th>
			<th>상품정보</th>
			<th>상품기격</th>
			<th>할인된가격</th>
			<th>배송비</th>
		</tr>	
		
		
		<%
			for(HashMap<String, Object> c : list) {
				
		%>
			<tr>
				<td rowspan="2">
					<%=(String)(c.get("상품이미지"))%>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/product/productOne.jsp">
						<%=(String)(c.get("상품이름"))%>
					</a>
				</td>
				<td>
					<%=(int)(c.get("상품가격"))%>원
				</td>
				<td>
					<%=(int)(c.get("할인상품가격"))%>원
				</td>
				<td>
					무료
				</td>
				
			</tr>
			
			
		<%
			}
		%>	











	
	</table>

</body>
</html>