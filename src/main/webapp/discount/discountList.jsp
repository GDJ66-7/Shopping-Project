<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>


<%
	// dao 객체 생성
	DiscountDao discountDao = new DiscountDao();

	// 1. 상품 할인 리스트 조회하기
	ArrayList<HashMap<String, Object>> list1 = new ArrayList<>();
	list1 = discountDao.discountList();




%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품할인 리스트</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class = "container">
	<h1>상품 할인 리스트</h1>
	<table class="table">
		<tr>
			<th>discount_no</th>
			<th>product_no</th>
			<th>discount_start</th>
			<th>discount_end</th>
			<th>discount_rate</th>
			<th>createdate</th>
			<th>updatedate</th>
			<th>할인수정</th>
		</tr>
			<%
				for(HashMap<String, Object> d : list1) {		
			%>
					<tr>
						<td><%=(int)(d.get("할인번호"))%></td>
						<td><%=(int)(d.get("상품번호"))%></td>
						<td><%=(String)(d.get("시작날짜"))%></td>
						<td><%=(String)(d.get("종료날짜"))%></td>
						<td><%=(double)(d.get("할인율"))%></td>
						<td><%=(String)(d.get("생성날짜"))%></td>
						<td><%=(String)(d.get("수정날짜"))%></td>
						<td>
							<a href="<%=request.getContextPath()%>/discount/updateDiscount.jsp?discountNo=<%=(int)(d.get("할인번호"))%>">수정</a>
						</td>
						
			<%
				}
			%>
	</table>
			<a href="<%=request.getContextPath()%>/discount/insertDiscount.jsp">상품추가</a>
	</div>
</body>
</html>