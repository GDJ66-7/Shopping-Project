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
	
	// 받아온 값 저장 & 메서드 호출
	String id = (String)session.getAttribute("loginCstmId");
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	QuestionDao question = new QuestionDao();
	
	// Question 객체 변수에 저장(vo) 수정 페이지에 표시할 객체(questionOne과 동일)
	Question one = question.selectQuestionOne(qNo);
	//System.out.println(qNo+"<----");
	
	// 로그인 세션 검사
	if(!id.equals(one.getId())){
		response.sendRedirect(request.getContextPath()+"/question/questionOne.jsp");
		return;
	}
	
	System.out.println(id+"<---loginmember--");
	System.out.println(one.getId()+"<---question writer--");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css 확인하기 쉽게 잠시 적용 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		const MAX_COUNT = 500; //const 상수선언 사용하는 키워드(자바의 final과 유사함:변경될 수 없는 값)
		const $qContent = $('#qContent');
		const $count = $('#count em');
		
		function preContentCheck() { // 현재 입력되어 있는 글자수 확인을 위한 함수 선언
			let len = $qContent.val().length; // 현재 입력되어있는 글자 수 확인
			if(len > MAX_COUNT) {
				let str = $qContent.val().substring(0, MAX_COUNT);
				$qContent.val(str);
				alert(MAX_COUNT + '자까지만 입력 가능합니다');
				len = MAX_COUNT;
			}
			$count.text(len); //현재 입력된 글자수 출력
		}
		$qContent.on('input', preContentCheck); // qContent내에 있는(이벤트종류:input,업데이트 콜백 함수)호출
		preContentCheck(); // 수정 페이지가 로드될 때 원래 입력되어있던 글자 수 체크
	});
</script>
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
<form id="QuestionUpdate" action="<%=request.getContextPath()%>/question/updateQuestionAction.jsp" method="post">
	<input type="hidden" name="productNo" value="<%=one.getProductNo()%>">
	<input type="hidden" name="qNo" value="<%=one.getqNo()%>">
	<input type="hidden" name="id" value="<%=one.getId()%>"><!-- 세션검사 -->
		<table class="table table-bordered">
			<tr>
				<td>제목</td>
				<td>
				<input type="text" name="qTitle" id="qTitle" value="<%=one.getqTitle()%>" size=60; required="required" placeholder="제목을 입력하세요(50자 이내)">
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
			<textarea name="qContent" id="qContent" cols="80" rows="10" style="resize: none;" required="required" placeholder="내용을 입력하세요(최대500자)"><%=one.getqContent()%></textarea>
			<span id="count"><em>0</em></span><em>/500</em>
			</td>
			</tr>
		</table>
		<div>
			<button type=submit class="btn btn-light" onclick="QuestionUpdate()">수정</button>
			<a href="<%=request.getContextPath()%>/question/questionOne.jsp?qNo=<%=one.getqNo()%>&productNo=<%=one.getProductNo()%>" class="btn btn-light">취소</a>
		</div>
</form>
</div>
<script>
function QuestionUpdate() {
	  let result = confirm("내용을 수정하시겠습니까?");
	  if (result) {
		  document.getElementById("QuestionUpdate").submit();
		  alert("게시글 수정이 완료되었습니다.");
	  }else{
		  event.preventDefault();
		    return;
	}
}
</script>
</body>
</html>