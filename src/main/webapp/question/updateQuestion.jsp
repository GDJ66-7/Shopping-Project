<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 유효성 검사
	if(request.getParameter("qNo") == null
	||request.getParameter("qNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}
	
	// 로그인 세션 검사 -- 조회/수정/삭제
	
	// 받아온 값 저장 & 메서드 호출
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	QuestionDao question = new QuestionDao();
	
	// Question 객체 변수에 저장(vo) 수정 페이지에 표시할 객체(questionOne과 동일)
	Question one = question.selectQuestionOne(qNo);
	//System.out.println(qNo+"<----");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css 확인하기 쉽게 잠시 적용 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>문의사항 수정</title>
<style>
a{text-decoration: none;}
#bar {background-color: #FAECC5;}
</style>
</head>
<body>
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">상품문의</h2>
<form action="<%=request.getContextPath()%>/question/updateQuestionAction.jsp" method="post">
	<input type="hidden" name="productNo" value="<%=one.getProductNo()%>">
	<input type="hidden" name="qNo" value="<%=one.getqNo()%>">
	<input type="hidden" name="id" value="<%=one.getId()%>"><!-- 세션검사 -->
		<table class="table table-bordered">
			<tr>
				<td>제목</td>
				<td>
				<input type="text" name="qTitle" value="<%=one.getqTitle()%>" required="required">
			</td>
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
			<td>내용</td>
			<td>
			<textarea name="qContent" cols="80" rows="10" style="resize: none;" required="required"><%=one.getqContent()%></textarea>
			</td>
			</tr>
		</table>
		<div>
			<button type=submit class="btn btn-light">수정</button>
			<a href="<%=request.getContextPath()%>/question/questionOne.jsp?qNo=<%=one.getqNo()%>&productNo=<%=one.getProductNo()%>" class="btn btn-light">취소</a>
		</div>
</form>
</div>
</body>
</html>