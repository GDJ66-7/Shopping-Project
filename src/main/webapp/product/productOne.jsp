<!-- view 상품 상세정보 페이지 카테고리/상품이름/가격/상태/재고/정보 -->
<!-- 상세정보/리뷰/문의 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 유효성 검사
	if(request.getParameter("productNo") == null
	||request.getParameter("productNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
		return;
	}

	// 받아온 값 & 메서드 호출
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	OneDao one = new OneDao();
	
	// 객체 저장
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>