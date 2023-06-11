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
	
	// 로그인 세션 검사 -- 조회/수정/삭제 test
	
	// 리스트에서 받아온 값 저장 & 메서드 호출 & 객체 생성
	int orderNo = 2;/*Integer.parseInt(request.getParameter("orderNo"));*/
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	//System.out.println(orderNo+"<----");
	
	// 리뷰 이미지와 글 출력 메서드
	ReviewDao review = new ReviewDao(); // DAO (동일)
	Review reviewText = review.selectReviewOne(orderNo); //vo
	ReviewImg reviewImg = review.selectReviewImg(orderNo); //vo
%>
<!DOCTYPE html>
<html>
<head>
<!-- css 확인하기 쉽게 잠시 적용 / 리뷰 이미지 폴더 * 리뷰 one.jsp 생성& insertAnswer.jsp 파일 삭제 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>리뷰 상세</title>
<style>
a{text-decoration: none;}
#bar {background-color: #FAECC5;}
</style>
</head>
<body>
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">상품 리뷰</h2>
<br>
<table class="table table-bordered">
	<tr>
		<td id="bar">제목</td>
		<td><%=reviewText.getReviewTitle()%>
	</tr>
	<tr>
		<td id="bar">ID</td>
		<td><%=reviewText.getId()%></td>
	</tr>
<%
	if(reviewImg != null){
%>
	<tr>
		<td id="bar">사진</td>
		<td> <!-- 파일이 없을땐 출력 되지 않게 해야함 일단 리뷰폼은 required로 설정해둠-->
		<img src="${pageContext.request.contextPath}/review/reviewImg/<%=reviewImg.getReviewSaveFilename()%>">
		</td>
	</tr>
<%
	}
%>
	<tr>
		<td id="bar">내용</td>
		<td><%=reviewText.getReviewContent()%></td>
	</tr>
	<tr>
		<td id="bar">작성일자</td>
		<td><%=reviewText.getCreatedate().substring(0,10)%></td>
	</tr>
</table>
<a href="<%=request.getContextPath()%>/review/updateReview.jsp?orderNo=<%=reviewText.getOrderNo()%>&productNo=<%=reviewText.getProductNo()%>" class="btn btn-light">수정</a>
<a href="<%=request.getContextPath()%>/review/deleteReviewAction.jsp?orderNo=<%=reviewText.getOrderNo()%>&productNo=<%=reviewText.getProductNo()%>" class="btn btn-outline-light text-dark" style="float: right;">삭제</a>
</div>
</body>
</html>
