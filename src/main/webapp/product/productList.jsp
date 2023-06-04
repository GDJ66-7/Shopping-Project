<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// dao를 사용하기 위한 productDao클래스 객체 생성
	ProductDao pDao = new ProductDao();
	int beginRow = 0;
	int rowPerPage = 10;
	
	// 상품 리스트를 뽑기 위해 productList메서드 호출
	ArrayList<HashMap<String, Object>> productList = pDao.productList(beginRow, rowPerPage);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th>상품이름</th>
			<th>상품 가격</th>
			<th>상품 상태 </th>
			<th>상품 사진 </th>
		</tr>
		<%
			for(HashMap<String, Object> proMap : productList) {
				
		%>
				<tr>
					<td><%=proMap.get("productName") %></td>
					<td><%=proMap.get("productPrice") %></td>
					<td><%=proMap.get("productStatus") %></td>
					<!-- ${pageContext.request.contextPath}는 현재 웹 애플리케이션의 루트 경로를 나타내는 변수이다   -->
					<td><img src="${pageContext.request.contextPath}/product/productImg/<%=proMap.get("productSaveFilename") %>" width="100" height="100"></td>
				</tr>
		<% 
			}
		%>
		
	</table>
</body>
</html>