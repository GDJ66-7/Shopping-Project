<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>

<%
	String id = "customer1";

	//dao 객체 생성
	CartDao cartDao = new CartDao();	

	// 장바구니에서 구매할 상품들 조회 selectCartOrder
	ArrayList<HashMap<String, Object>> list = cartDao.selectCartOrder(id);

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 주문/결제 </title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
<h1>주문/결제</h1>
	<form action="<%=request.getContextPath()%>/cart/cartOrderAction.jsp">
	구매자정보
	<table>
		<%
			for(HashMap<String, Object> co : list) {	
		%>
				
				<tr>
					<th>이름</th>
					<td><%=(String)(co.get("이름"))%></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><%=(String)(co.get("이메일"))%></td>
				</tr>
				<tr>
					<th>휴대폰 번호</th>
					<td><%=(String)(co.get("휴대폰번호"))%></td>
				</tr>
			

				<tr>
					<th>이름</th>
					<td><%=(String)(co.get("이름"))%></td>
				</tr>
				<tr>
					<th>배송주소</th>
					<td><%=(String)(co.get("배송주소"))%></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><%=(String)(co.get("휴대폰번호"))%></td>
				</tr>
				
			
				<tr>
					<th></th>
				</tr>
				<tr>
					<td></td>
					<td></td>
				</tr>	
			
				<tr>
					<th>총상품가격</th>
					<td><%=(int)(co.get("총상품가격"))%></td>
				</tr>
				<tr>
					<th>할인금액</th>
					<td><%=(int)(co.get("할인금액"))%></td>
				</tr>
				<tr>
					<th>보유포인트</th>
					<td><%=(int)(co.get("보유포인트"))%></td>
				</tr>
				<tr>
					<th>총결제금액</th>
					<td><%=(int)(co.get("총결제금액"))%></td>
				</tr>
		<%
			}
		%>	
		
	</table>
	
	
	<button type="submit">결제하기</button>	
	
	</form>



</div>
</body>
</html>