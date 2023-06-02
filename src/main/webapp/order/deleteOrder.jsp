<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") == null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") != null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
	System.out.println(request.getParameter("orderNo")+"<-- deleteOrder.jsp orderNo");
	//메세지 출력 변수 선언
	String msg = "";
	if(request.getParameter("orderNo") == null || request.getParameter("orderNo").equals("")){
		msg = URLEncoder.encode("취소할 주문을 선택해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/order/customerOrderHistory.jsp?msg="+msg);
		return;
	}
	//요청값 변수에 저장
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	//보여줄 주문상세 보여주는 메서드
	OrderDao order = new OrderDao();
	ArrayList<HashMap<String, Object>> list = order.selectOrder(orderNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>취소할 주문상세</h1>
	<h1>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</h1>
	<form action="<%=request.getContextPath()%>/order/deleteOrder.jsp" method="post">
	<%
		for(HashMap<String, Object> s : list){
	%>
		<table>
			<tr>
				<td>주문번호</td>
				<td>상품이름</td>
				<td>결제상태</td>
				<td>배송상태</td>
				<td>수량</td>
				<td>주문가격</td>
				<td>주문배송지</td>
				<td>구매일</td>
			</tr>
			<tr>
				<td><%=(Integer)(s.get("주문번호"))%></td>
				<td><%=(String)(s.get("상품이름"))%></td>
				<td><%=(String)(s.get("결제상태"))%></td>
				<td><%=(String)(s.get("배송상태"))%></td>
				<td><%=(Integer)(s.get("수량"))%></td>
				<td><%=(Integer)(s.get("주문가격"))%></td>
				<td><%=(String)(s.get("주문배송지"))%></td>
				<td><%=(String)(s.get("구매일"))%></td>
			</tr>
		</table>
		<input type="hidden" name="orderNo" value="<%=(Integer)(s.get("주문번호"))%>">
	<%
		}
	%>
	<button type="submit"></button>
	</form>
</body>
</html>