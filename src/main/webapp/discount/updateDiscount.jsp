<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// discountNo를 통하여 할인정보 수정
	if(request.getParameter("discountNo") == null){
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
		return;
	}

	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String productName = request.getParameter("productName");
	String discountStart = request.getParameter("discountStart");
	
	System.out.println(discountNo + "insertDiscount discountNo");
	System.out.println(productNo + "insertDiscount productNo");
	System.out.println(productName + "insertDiscount productName");
	System.out.println(discountStart + "insertDiscount discountStart");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/discount/updateDiscountAction.jsp">
		<table>
			<tr>
				<th>할인번호</th>
				<td>
					<input type="text" name="discountNo" value="<%=discountNo%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>상품번호</th>
				<td>
					<input type="text" value="<%=productNo%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>상품이름</th>
				<td>
					<input type="text" value="<%=productName%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>할인시작일</th>
				<td>
					<input type="datetime-local" name="discountStart">기존 할인 시작일: <%=discountStart%>
				</td>
			</tr>	
			<tr>
				<th>할인종료일</th>
				<td>
					<input type="datetime-local" name="discountEnd">
				</td>
			</tr>	
			<tr>
				<th>할인율</th>
				<td>
					<input type="text" name="discountRate">
				</td>
			</tr>		
		</table>
		<button type="submit">할인수정</button>
	</form>
</body>
</html>