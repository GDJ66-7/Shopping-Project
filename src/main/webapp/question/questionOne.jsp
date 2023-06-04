<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 유효성 검사
	if(request.getParameter("qNo") == null
	||request.getParameter("qNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;	
	}

	// 로그인 세션 검사 -- 조회/수정/삭제

	// 받아온 값 저장 & 메서드 호출
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	QuestionDao question = new QuestionDao();
	
	// Question 객체 변수에 저장(vo)
	Question one = question.selectQuestionOne(qNo);
	// System.out.println(qNo+"<----");
	
%>
<!DOCTYPE html>
<html>
<head>
<!-- css 확인하기 쉽게 잠시 적용 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>문의 상세정보창</title>
<style>
a{text-decoration: none;}
#bar {background-color: #FAECC5;}
</style>
</head>
<body>
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">상품문의</h2>
<br>
<table class="table table-bordered">
	<tr>
		<td id="bar">번호</td>
		<td><%=one.getqNo()%></td>
	</tr>
	<tr>
		<td id="bar">제목</td>
		<td><%=one.getqTitle()%>
	</tr>
	<tr>
		<td id="bar">카테고리</td>
		<td><%=one.getqCategory()%>
	</tr>
	<tr>
		<td id="bar">ID</td>
		<td><%=one.getId()%></td>
	</tr>
	<tr>
		<td id="bar">내용</td>
		<td><%=one.getqContent()%></td>
	</tr>
	<tr>
		<td id="bar">작성일자</td>
		<td><%=one.getCreatedate().substring(0, 10)%></td>
	</tr>
</table>
<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=one.getProductNo()%>" class="btn btn-light">목록</a>
<a href="<%=request.getContextPath()%>/question/updateQuestion.jsp?qNo=<%=one.getqNo()%>" class="btn btn-light">수정</a>
<a href="<%=request.getContextPath()%>/question/deleteQuestionAction.jsp?qNo=<%=one.getqNo()%>" class="btn btn-outline-light text-dark" style="float: right;">삭제</a>
</div>
</body>
</html>