<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%

	/*if(request.getParameter("productNo") == null  
	|| request.getParameter("productNo").equals("")) {
	response.sendRedirect(request.getContextPath() + "/product/productOne.jsp");
	return;
	}*/
	
	//test 12
	int productNo = 12; /*Integer.parseInt(request.getParameter("productNo"))*/
	String id = "customer1";

%>
<!-- 회원만 가능 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 문의하기</title>
</head>
<body>
<h2>상품 문의</h2>
<form action="<%=request.getContextPath()%>/question/insertQuestionAction.jsp" method="post">
<table>
	<tr>
		<td><input type="hidden" name="productNo" value="<%=productNo%>"></td>
		<td><input type="hidden" name="id" value="<%=id%>"></td><!-- 세션값 넣어둬야 함 -->
	</tr>
	<tr>
		<td>
			<label for="qCategory">카테고리</label>
		</td>
		<td>
			<select name="qCategory" id="qCategory">
			<option value="배송">배송</option>
			<option value="상품">상품</option>
			<option value="기타">기타</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="qTitle" required="required"></td>	
	</tr>
	<tr>
		<td>내용</td>
		<td>
		<textarea rows="5" cols="80" name="qContent" required="required">
		</textarea>
		</td>
	</tr>
</table>
	<div>
		<button type=submit>추가</button>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp">취소</a>
	</div>
</form>
</body>
</html>