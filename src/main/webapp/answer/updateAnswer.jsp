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
	
	// 받아온 값 저장 - 수정할 aNo & 해당 qNo
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(productNo+"<---u.a productNo---");
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	String aContent = request.getParameter("aContent");
	String empid = (String)session.getAttribute("loginEmpId1");
	if (empid == null) { // 답변을 단 관리자
	    empid = (String) session.getAttribute("loginEmpId2");
	}
	//System.out.println(aNo+"<----");
	
	// Dao 선언 & 저장 (view에서는 수정 전 내용 가져와야 하니까 answerOne)
	AnswerDao answer = new AnswerDao();
	Answer one = answer.answerOne(qNo);
	
	//로그인 세션 검사
	if(!empid.equals(one.getId())){
		response.sendRedirect(request.getContextPath()+"/question/questionOne.jsp?qNo="+qNo);
		return;
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="updateAnswer" action="<%=request.getContextPath()%>/answer/updateAnswerAction.jsp" method="post"> 
	<input type="hidden" name="aNo" value="<%=one.getaNo()%>">
	<input type="hidden" name="qNo" value="<%=one.getqNo()%>">
	<input type="hidden" name="id" value="<%=one.getId()%>">
	<input type="hidden" name="productNo" value="<%=productNo%>">
		<table class="table">
		<tr>
			<td>문의 답변 수정</td>
			<td>
			<textarea name="aContent" cols="80" rows="10" style="resize: none;"><%=one.getaContent()%></textarea>
			</td>
			</tr>
		</table>
		<div>
			<button type=submit class="btn btn-light" onclick="updateAnswer()">수정</button>
			<a href="<%=request.getContextPath()%>/question/questionOne.jsp?qNo=<%=one.getqNo()%>&productNo=<%=productNo%>" class="btn btn-light">취소</a>
		</div>
	</form>
<script>
function updateAnswer() {
	let form = document.getElementById("updateAnswer");
	if (form.aContent.value.trim() === '') { // 공백 제거 후 비교
		alert('내용을 입력해주세요');
		form.aContent.focus();
		event.preventDefault();
		return;
	}
	
	let result = confirm("내용을 수정하시겠습니까?");
	  if (result) {
		  document.getElementById("updateAnswer").submit();
		  alert("답변 수정이 완료되었습니다.");
	  }else{
		  event.preventDefault();
		    return;
	}
}
</script>
</body>
</html>