<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!-- 작성된 문의 사항 게시글 안에 답변까지 같이 있음(댓글) -->
<%
	//일반관리자 세션이름 loginEmpId1  , 최고관리자 세션이름 loginEmpId2, 고객 세션이름 loginCstmId 입니다
	// 유효성 검사
	if(request.getParameter("qNo") == null
	||request.getParameter("qNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}

	// 로그인 세션 검사 -- 조회/수정/삭제 test

	// 문의사항(QUESTION) 받아온 값 저장 & 메서드 호출 & 객체 생성
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	QuestionDao question = new QuestionDao();
	Question one = question.selectQuestionOne(qNo);
	//System.out.println(qNo+"<----");
	
	AnswerDao answer = new AnswerDao(); //선언
	Answer aone = answer.answerOne(qNo); //dao에서 answerOne메서드 사용 -> 반환값 aone에 담김

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
		<td><%=one.getCreatedate().substring(0,10)%></td>
	</tr>
</table>
<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=one.getProductNo()%>" class="btn btn-light">목록</a>
<a href="<%=request.getContextPath()%>/question/updateQuestion.jsp?qNo=<%=one.getqNo()%>" class="btn btn-light">수정</a>
<a href="<%=request.getContextPath()%>/question/deleteQuestionAction.jsp?qNo=<%=one.getqNo()%>" class="btn btn-outline-light text-dark" style="float: right;">삭제</a>
</div>
<!------------------------------ 문의 사항 답변 (관리자 로그인 세션 추가해야함)----------------------------------->
	<br>
	<hr>
	<div class="container mt-3">
	<h4>답변내역</h4>
		<form action="<%=request.getContextPath()%>/answer/insertAnswerAction.jsp?qNo=<%=one.getqNo()%>" method="post">
			<input type="hidden" name="id" value="admin"> <!-- 로그인 세션 추가해야함 admin 임시 test-->
			<table class="table2">
				<tr>
					<td style="padding-right: 5pt;">comment</td>
					<td>
						<textarea rows="2" cols="100" name="aContent" placeholder="내용을 입력하세요" required="required"></textarea>
					</td>
					<th>
					<button type="submit" class="btn btn-light">답변입력</button>
					</th>
				</tr>
			</table>
		</form>
	<!---------------------------- 답변 결과셋 ----------------------------------------------------------->
<% 
	if (aone != null)	{ 
%>
	<table class="table table-borderless">
		<tr style="background-color: #F6F6F6;">
			<th>작성자</th>
			<th>내용</th>
			<th>작성일</th>
			<th></th>
			<th></th>
		</tr>
		<tr>
			<td><%=aone.getId()%></td>
			<td style="width : 50%;"><%=aone.getaContent()%></td>
			<td><%=aone.getCreatedate().substring(0,10)%></td>
			<td>
				<a href="<%=request.getContextPath()%>/answer/updateAnswer.jsp?qNo=<%=one.getqNo()%>&aNo=<%=aone.getaNo()%>&id=<%=aone.getId()%>&aContent=<%=aone.getaContent()%>" class="btn btn-success" style="font-size: 12px;">수정</a>
			</td>
			<td>
				<a href="<%=request.getContextPath()%>/answer/deleteAnswerAction.jsp?aNo=<%=aone.getaNo()%>&qNo=<%=one.getqNo()%>" class="btn btn-success" style="font-size: 12px;">삭제</a>
			</td>
		</tr>
	</table>
	</div>
<%
	}
%>
</body>
</html>