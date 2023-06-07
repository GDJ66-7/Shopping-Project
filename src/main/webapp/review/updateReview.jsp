<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	if(request.getParameter("orderNo") == null
	||request.getParameter("orderNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}

	// 로그인 세션 검사 -- 조회/수정/삭제
	
	//리뷰one에서 받은 값 저장 & 메서드 호출
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	ReviewDao review = new ReviewDao();
	
	// review 객체 변수에 저장(vo) 수정 페이지에 표시할 객체(reviewOne과 동일)
	// 텍스트 수정
	Review reviewText = new Review();
	
	/*이미지 수정
	ReviewImg reviewImg = new ReviewImg(); // ReviewDao(동일) vo
	reviewImg = review.reviewImg(updateReviewImg);*/

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