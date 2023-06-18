<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!-- 작성된 문의 사항 게시글 안에 답변까지 같이 있음(댓글) -->
<!-- 관리자와 작성자만 접근가능한 페이지, 게시글에 대한 수정과 삭제는 작성자만 가능 관리자에게는 노출하지 않음 -->
<!-- 답변은 댓글 형식(1개만 작성가능), 작성자에게는 댓글 입력창과, 댓글 수정 삭제 노출하지 않음 -->
<%
	//일반관리자 세션이름 loginEmpId1  , 최고관리자 세션이름 loginEmpId2, 고객 세션이름 loginCstmId 입니다
	// 유효성 검사
	if(request.getParameter("qNo") == null
	||request.getParameter("qNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}
	
	// 받아온 값 저장 & 메서드 호출 & 객체 생성
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(productNo+"<---questionOne productNo");
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	QuestionDao question = new QuestionDao();
	Question one = question.selectQuestionOne(qNo);
	//System.out.println(qNo+"<----");
	
	String writerId = one.getId(); // 작성자 아이디 대조를 위해 불러오기
	String id = (String)session.getAttribute("loginCstmId"); //로그인 한 사용자 || or 
	String empid = (String)session.getAttribute("loginEmpId1"); //로그인 한 관리자
	if (empid == null) {
	    empid = (String) session.getAttribute("loginEmpId2");
	}
	if (empid == null && !writerId.equals(id)) {
	    out.println("<script>alert('작성자 또는 관리자만 접근할 수 있습니다.'); location.href='" + request.getContextPath() + "/product/productOne.jsp?productNo=" + one.getProductNo() + "';</script>");
	    return;
	}
	System.out.println(id+"<---QA cstmid");
	System.out.println(empid+"<---QA empid");
	
	/*if(session.getAttribute("loginCstmId") == null && session.getAttribute("loginEmpId1")
			== null && session.getAttribute("loginEmpId2") == null){
			response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
			return;
	}*/
	
	AnswerDao answer = new AnswerDao(); //선언
	Answer aone = answer.answerOne(qNo); //dao에서 answerOne메서드 사용 -> 반환값 aone에 담김

	boolean completeAnswer = (aone != null); // 답변이 있는 상태면 true , 없으면 false
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
<%
	if(session.getAttribute("loginCstmId")!=null) { //처음부터 작성자와 관리자가 아니면 접근을 막아놨으므로 null값이 아닌 거로만 체크
%>
<a href="<%=request.getContextPath()%>/question/updateQuestion.jsp?qNo=<%=one.getqNo()%>" class="btn btn-light">수정</a>
<a href="<%=request.getContextPath()%>/question/deleteQuestionAction.jsp?qNo=<%=one.getqNo()%>&productNo=<%=productNo%>" onclick="QuestionDelete()" class="btn btn-outline-light text-dark" style="float: right;">삭제</a>
<%
	}
%>
</div>
<script>
function QuestionDelete(){ //게시글 삭제 confirm 추가
	let result = confirm("게시글을 삭제하시겠습니까?");
	if(result){
		alert("삭제되었습니다");
	}else{
		event.preventDefault();
	    return;
	}
}
</script>
<!------------------------------ 문의 사항 답변 --------------------------------------------------->
	<br>
	<hr>
	<div class="container mt-3">
	<h4>답변내역</h4>
<% 
	if((empid!=null)&&!completeAnswer){ //답변이 하나라도 있는 상태면 폼 숨김
%>
		<form id="insertAnswer" action="<%=request.getContextPath()%>/answer/insertAnswerAction.jsp" method="post">
			<input type="hidden" name="productNo" value="<%=one.getProductNo()%>"> <!-- 로그인 세션 추가해야함 admin 임시 test-->
			<input type="hidden" name="qNo" value="<%=one.getqNo()%>">
			<input type="hidden" name="id" value="<%=empid%>"> <!-- 아이디 체크 -->
			<table class="table2">
				<tr>
					<td style="padding-right: 5pt;">comment</td>
					<td>
						<textarea rows="2" cols="100" name="aContent" id="aContent" placeholder="내용을 입력하세요"></textarea>
					</td>
					<th>
					<button type="submit" class="btn btn-light" onclick="insertAnswer()">답변입력</button>
					</th>
				</tr>
			</table>
		</form>
<%
	}
%>
<script>
function insertAnswer() {
	let form = document.getElementById("insertAnswer");
	if (form.aContent.value.trim() === '') { // 공백 제거 후 비교
		alert('내용을 입력해주세요');
		form.aContent.focus();
		event.preventDefault();
		return;
	}

	let result = confirm("문의사항에 대한 답변을 입력하시겠습니까?");
	if (result) {
		form.submit();
		alert("답변이 등록되었습니다.");
	} else {
		event.preventDefault();
		return;
	}
}
</script>
<!---------------------------- 답변 결과셋 ----------------------------------------------------------->
<% 
	if (aone != null){ // 답변이 있을 시
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
<%
	if(empid!=null) {
%>
			<td>
				<a href="<%=request.getContextPath()%>/answer/updateAnswer.jsp?qNo=<%=one.getqNo()%>&aNo=<%=aone.getaNo()%>&productNo=<%=one.getProductNo()%>" class="btn btn-success" style="font-size: 12px;">수정</a>
			</td>
			<td>
				<a href="<%=request.getContextPath()%>/answer/deleteAnswerAction.jsp?aNo=<%=aone.getaNo()%>&qNo=<%=one.getqNo()%>&productNo=<%=one.getProductNo()%>" onclick="AnswerDelete()" class="btn btn-success" style="font-size: 12px;">삭제</a>
			</td>
		</tr>
<%
	}
%>
	</table>
	</div>
<%
	}else{
%>
	<div>문의하신 내용에 대한 답변을 준비중입니다.</div>
<%
	}
%>
<script>
function AnswerDelete(){ //답변 삭제 confirm 추가
	let result = confirm("답변을 삭제하시겠습니까?");
	if(result){
		alert("삭제되었습니다");
	}else{
		event.preventDefault();
	    return false;
	}
}
</script>
</body>
</html>