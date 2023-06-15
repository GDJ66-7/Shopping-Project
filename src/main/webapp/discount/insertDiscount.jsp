<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

<%
	// 2. 상품 번호와 상품 이름 조회하기
	DiscountDao discountDao = new DiscountDao();
	
	ArrayList<Product> list = new ArrayList<>();
	list = discountDao.selectCart();
	
	int productNo = 0;
	String productName = "";
	for(Product p : list){
		productNo = p.getProductNo();
		productName = p.getProductName();
	}
	System.out.println(productNo);
	System.out.println(productName);

	

%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인 상품 추가</title>
</head>
<body>
	<h1>할인 상품 추가하기</h1>
	<form action="<%=request.getContextPath()%>/discount/insertDiscountAction.jsp">
	<table>
		<tr>
			<th>product_no</th>
			<td>
				<select name="productNo">
					<option value="ㅎㅎ">ㅎㅎ</option>
				</select>
			</td>
		</tr>	
		<tr>
			<th>discount_start</th>
			<td>
				<input type="date" name="discountStart">
			</td>
		</tr>	
		<tr>
			<th>discount_end</th>
			<td>
				<input type="date" name="">
			</td>
		</tr>	
		<tr>
			<th>discount_rate</th>
			<td>
				<input>
			</td>
		</tr>		
	</table>
	<input type="submit" value="추가">
	</form>
</body>
</html>