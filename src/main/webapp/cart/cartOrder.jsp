<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>

<%
	// 한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	String id = "customer1";

	// updatePoint.jsp에서 받아 온 값이 있으면 inputPoint 변수에 값을 저장한다.
	int inputPoint = 0;
	if(request.getParameter("inputPoint")!= null) {
		inputPoint = Integer.parseInt(request.getParameter("inputPoint"));
	}
	
	// 받아 온 값이 있으면 selectAddress 변수에 값을 저장한다.
	String selectAddress = null;
	if(request.getParameter("selectAddress")!= null) {
		selectAddress = request.getParameter("selectAddress");
	}
	
	// 사용 할 포인트 초기값(사용자가 포인트를 입력하지않으면 기본값은 0이다.)
	int usePoint = 0;
	usePoint = usePoint + inputPoint; // // 사용 할 포인트(사용자가 포인트 입력한 값)

	// dao 객체 생성
	CartDao cartDao = new CartDao();	
	
	// 8. 보유 포인트 조회 메서드
	int point = cartDao.selectPoint(id);
	
	// 9. 총결제금액
	int totalPay = cartDao.totalPayment(usePoint, id);
	
	// 6. 장바구니에서 체크한 상품 조회 메서드
	ArrayList<HashMap<String, Object>> list6 = cartDao.checkedList(id);
	
	// 7. 구매자정보, 받는사람정보, 결제정보 조회 메서드
	ArrayList<HashMap<String, Object>> list7 = cartDao.cartOrderList(id);
	
	// 총 상품 개수
	int totalCartCnt = 0;
	for(HashMap<String, Object> c : list7) {
		totalCartCnt = (Integer)(c.get("총상품개수"));
	}
	
	// 10. 주소 내역 리스트 불러오기
	ArrayList<String> list10 = cartDao.addressList(id);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 주문/결제 </title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function addressOpenPopup(url) {
	    window.open(url, 'addressPopupWindow', 'width=600, height=400');
	}
	
</script>
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
		<%
			}
		%>
	</table>
	
	<h4> 받는사람정보 </h4>
	<form action="<%=request.getContextPath()%>/cart/cartOrder.jsp" method="post">
		<input type="hidden" name="id" value="<%=id%>">
		<input type="hidden" name="inputPoint" value="<%=inputPoint%>">
		<table class="table">
				<tr>
					<th>최근 배송 주소</th>
				</tr>	
					<%
						for (String address : list10) {
					%>
							<tr>	
								<td>
									<input type="radio" name="selectAddress" value="<%=address%>" <%if (address.equals(selectAddress)) { %>checked<% } %>>
									<%=address%>
								</td>
							</tr>
					<%
						}
					%>	
				<tr>
					<td>
						<input type="submit" value="주소 선택">
					</td>
					<td>		
						<a href="#" onclick="addressOpenPopup('<%=request.getContextPath()%>/cart/insertAddress.jsp?id=<%=id%>')">주소추가</a>
					</td>
				</tr>	
		</table>
	</form>

	<h4>배송 상품</h4>
	<!-- 배송 상품 목록 -->
	<table class="table">			
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
		<input type="hidden" name="selectAddress" value="<%=selectAddress%>">
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
				int discountAmount = (Integer)(c.get("할인금액"));
				int totalDiscntAmount = discountAmount + inputPoint;
		%>
				<tr>
					<th>총 상품가격</th>
					<td><%=(Integer)(c.get("총상품가격"))%></td>
				</tr>
				<tr>
					<th>총 할인금액</th>
					<td><%=totalDiscntAmount%></td>
				</tr>
		<%	
			}
		%>		
			<tr>
				<th>총 결제금액</th>
				<td><%=totalPay%></td>
			</tr>		
			<tr>
				<td>
					<form action="<%=request.getContextPath()%>/cart/cartOrderAction.jsp">		
						<input type="hidden" name="id" value="<%=id%>">	
						<input type="hidden" name="totalCartCnt" value="<%=totalCartCnt%>">	
						<input type="hidden" name="totalPay" value="<%=totalPay%>">	
						<input type="hidden" name="selectAddress" value="<%=selectAddress%>">	
						<input type="hidden" name="inputPoint" value="<%=inputPoint%>">						
						<input type="submit" value="결제">	
					</form>
				</td>	
			</tr>	
	</table>					
</div>	
</body>
</html>