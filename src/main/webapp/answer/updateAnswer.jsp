<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
 	// 유효성 검사
	if(request.getParameter("aNo") == null
	||request.getParameter("aNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}

	//로그인 세션 검사 추가해야함
	
	// 받아온 값 저장 - 수정할 aNo & 해당 qNo
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	String aContent = request.getParameter("aContent");
	String id = request.getParameter("id");
	//System.out.println(aNo+"<----");
	
	// Dao 선언 & 저장 (view에서는 수정 전 내용 가져와야 하니까 answerOne)
	AnswerDao answer = new AnswerDao();
	Answer one = answer.answerOne(qNo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/answer/updateAnswerAction.jsp?qNo=<%=one.getqNo()%>&aNo=<%=one.getaNo()%>&id=<%=one.getId()%>" method="post">
		<table class="table">
		<tr>
			<td>문의 답변 수정</td>
			<td>
			<textarea name="aContent" cols="80" rows="10" style="resize: none;" required="required"><%=one.getaContent()%></textarea>
			</td>
			</tr>
		</table>
		<div>
			<button type=submit class="btn btn-light">수정</button>
			<a href="<%=request.getContextPath()%>/question/questionOne.jsp?qNo=<%=one.getqNo()%>" class="btn btn-light">취소</a>
		</div>
	</form>
</body>
</html>