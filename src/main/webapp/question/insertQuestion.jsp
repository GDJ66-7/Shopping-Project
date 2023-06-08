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
	
	//test 21
	int productNo = 21; /*Integer.parseInt(request.getParameter("productNo"))*/
	String id = "customer1";
	//로그인 세션(로그인 한 고객만(loginCstmId 작성 가능)
	//일반관리자 세션이름 loginEmpId1  , 최고관리자 세션이름 loginEmpId2, 고객 세션이름 loginCstmId
	/*String loginMemberId = (String)session.getAttribute("loginMemberId"); //test
	if(session.getAttribute("loginMemberId") == null) {
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}*/

%>
<!-- 회원만 가능 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>상품 문의하기</title>
</head>
<body>
<h2 style="text-align: center;">상품 문의</h2>
<div class="container mt-3">
<form action="<%=request.getContextPath()%>/question/insertQuestionAction.jsp" method="post">
<input type="hidden" name="productNo" value="<%=productNo%>">
<input type="hidden" name="id" value="<%=id%>">
<table class="table table-bordered">
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
</div>
</body>
</html>