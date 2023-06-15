<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

<%
	if(request.getParameter("productNo") == null) {
		response.sendRedirect(request.getContextPath()+"/main/empMain.jsp");
	}

	String productName = request.getParameter("productName");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	System.out.println(productNo + "insertDiscount productNo");
	System.out.println(productName + "insertDiscount productName");
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
		<input type="hidden" name="productNo" value="<%=productNo%>">;
		<table>
			<tr>
				<th>productName</th>
				<td>
					<input type="text" value="<%=productName %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>discount_start</th>
				<td>
					<input type="datetime-local" name="discountStart">
				</td>
			</tr>	
			<tr>
				<th>discount_end</th>
				<td>
					<input type="datetime-local" name="discountEnd">
				</td>
			</tr>	
			<tr>
				<th>discount_rate</th>
				<td>
					<input type="text" name="discountRate">
				</td>
			</tr>		
		</table>
		<button type="submit">할인추가</button>
	</form>
</body>
</html>