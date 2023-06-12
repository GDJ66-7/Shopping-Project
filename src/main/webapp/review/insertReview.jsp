<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");

	/*if(request.getParameter("orderNo") == null  
	|| request.getParameter("orderNo").equals("")
	|| request.getParameter("productNo") == null
	|| request.getParameter("productNo").equals("")){
	response.sendRedirect(request.getContextPath() + "/product/productOne.jsp");
	return;
	}*/
	String id = "customer2";
	int productNo = 21; /*Integer.parseInt(request.getParameter("productNo"));*/
	int orderNo = 2; /*Integer.parseInt(request.getParameter("orderNo"));*/

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리뷰 작성</title>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<body>
<h2 style="text-align: center;">상품 리뷰 작성</h2>
<div class="container mt-3">
<form action="<%=request.getContextPath()%>/review/insertReviewAction.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="orderNo" value="<%=orderNo%>">
<input type="hidden" name="productNo" value="<%=productNo%>">
<input type="hidden" name="id" value="<%=id%>">
<!-- hidden으로 orderNo까지 보낼 것 / 위에서 orderNo도 따로 받아야함 * 마이페이지 리뷰 작성-->
	<table class="table table-bordered">
		<tr>
			<td>제목</td>
			<td><input type="text" name="reviewTitle" required="required"></td>	
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea rows="5" cols="80" name="reviewContent" required="required" placeholder="내용을 입력하세요"></textarea></td>	
		</tr>
		<tr>
			<td>사진 업로드</td>
			<td><input type="file" name="reviewImg" required="required">
		</tr>
	</table>
	<div>
		<button type=submit class="btn btn-light">작성</button>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp" class="btn btn-light">취소</a><!-- 마이페이지 작성이므로 추후 경로수정 -->
	</div>
</form>
</div>
</body>
</html>