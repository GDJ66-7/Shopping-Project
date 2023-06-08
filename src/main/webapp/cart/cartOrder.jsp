<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>

<%
	// 한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");


	// updatePoint.jsp에서 받아온값을 사용포인트에 추가
	int inputPoint = 0;
	if(request.getParameter("inputPoint")!= null) {
		inputPoint = Integer.parseInt(request.getParameter("inputPoint"));
	}
	int usePoint = 0;
	usePoint = usePoint + inputPoint;

	// dao 객체 생성
	CartDao cartDao = new CartDao();	
	String id = "customer1";
	
	
	// 8. 보유 포인트 조회 메서드
	int point = cartDao.selectPoint(id);
	
	// 9. 총결제금액
	int totalPay = cartDao.totalPayment(usePoint, id);
	
	// 6. 장바구니에서 체크한 상품 조회 메서드
	ArrayList<HashMap<String, Object>> list6 = cartDao.checkedList(id);
	
	// 7. 구매자정보, 받는사람정보, 결제정보 조회 메서드
	ArrayList<HashMap<String, Object>> list7 = cartDao.cartOrderList(id);


	
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
			for(HashMap<String, Object> c : list7) { 				
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
			for(HashMap<String, Object> c : list6) {
				
		%>		
				<tr>
					<td><%=(String)(c.get("상품이름"))%></td>
					<td><%=(Integer)(c.get("수량"))%></td>
				</tr>	
		<%
			}
		%>	
	</table>
	
	<h4>결제정보</h4>
	<form action="<%=request.getContextPath()%>/cart/updatePoint.jsp" method="post">
		<input type="hidden" name="id" value="<%=id%>">
		<table class="table">
			<tr>
				<th>보유포인트</th>
				<th>사용포인트</th>
			</tr>
			
			<tr>
				<td>
					<input type="text" readonly="readonly" name="point" value="<%=point%>">
				</td>
				<td>
					<input type="text" readonly="readonly" name="usePoint" value="<%=usePoint%>">
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="포인트 사용하기">
				</td>				
			</tr>
		</table>
	</form>
		
	<table class="table">	
		<%
			for(HashMap<String, Object> c : list7) { 				
		%>
				<tr>
					<th>총상품가격</th>
					<td><%=(Integer)(c.get("총상품가격"))%></td>
				</tr>
				<tr>
					<th>할인금액</th>
					<td><%=((Integer)(c.get("할인금액")))+inputPoint%></td>
				</tr>
		<%	
			}
		%>		
				<tr>
					<th>총결제금액</th>
					<td><%=totalPay%></td>
				</tr>			
	</table>
</div>	
</body>
</html>