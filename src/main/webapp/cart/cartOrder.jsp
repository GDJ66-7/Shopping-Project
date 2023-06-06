<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>

<%
	// 한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	String id = "customer1";

	// dao 객체 생성
	CartDao cartDao = new CartDao();	

	// 6. 장바구니에서 체크한 상품 조회 메서드
	ArrayList<HashMap<String, Object>> list = cartDao.checkedList(id);
	
	// 7. 구매자정보, 받는사람정보, 결제정보 조회
	ArrayList<HashMap<String, Object>> list1 = cartDao.cartOrderList(id);
	
	// 8. 결제시 주문 정보를 orders 테이블에 추가
	
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
	<h4>구매자정보</h4>
	<table class="table">
		<%
			for(HashMap<String, Object> c : list1) { 				
		%>
				<tr>
					<th>이름</th>
					<td><%=(String)(c.get("이름"))%></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><%=(String)(c.get("이메일"))%></td>
				</tr>
				<tr>
					<th>휴대폰 번호</th>
					<td><%=(String)(c.get("휴대폰번호"))%></td>
				</tr>	
	</table>
	
	<h4>받는사람정보</h4>
	<table class="table">
				<tr>
					<th>이름</th>
					<td><%=(String)(c.get("이름"))%></td>
				</tr>
				<tr>
					<th>배송주소</th>
					<td><%=(String)(c.get("배송주소"))%></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><%=(String)(c.get("휴대폰번호"))%></td>
				</tr>
		<%
			}
		%>
	
	</table>
	
	<h4>배송 상품</h4>
	<table class="table">			
				<!-- 배송 상품 목록 -->
		<%
			for(HashMap<String, Object> c : list) {
				
		%>		
				<tr>
					<th>상품이름</th>
					<th>수량</th>
				</tr>
				<tr>
					<td><%=(String)(c.get("상품이름"))%></td>
					<td><%=(Integer)(c.get("수량"))%></td>
				</tr>	
		<%
			}
		%>	
	</table>
	
	<h4>결제정보</h4>
	<table class="table">
		<%
			for(HashMap<String, Object> c : list1) { 				
		%>
				<tr>
					<th>총상품가격</th>
					<td><%=(Integer)(c.get("총상품가격"))%></td>
				</tr>
				<tr>
					<th>할인금액</th>
					<td><%=(Integer)(c.get("할인금액"))%></td>
				</tr>
				<tr>
					<th>보유포인트</th>
					<td><%=(Integer)(c.get("보유포인트"))%></td>
				</tr>
				<tr>
					<th>결제금액</th>
					<td><%=(Integer)(c.get("결제금액"))%></td>
				</tr>
				<tr>
					<th>총결제금액</th>
					<td><%=(Integer)(c.get("총결제금액"))%></td>
				</tr>
		<%	
			}
		%>		
	</table>
</div>	
</body>
</html>