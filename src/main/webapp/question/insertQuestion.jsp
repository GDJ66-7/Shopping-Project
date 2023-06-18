<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%

	if(request.getParameter("productNo") == null  
	|| request.getParameter("productNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp");
		return;
	}
	
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	//로그인 세션(로그인 한 고객만(loginCstmId 작성 가능)
	if(session.getAttribute("loginCstmId") == null) {
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}
	String id= (String)session.getAttribute("loginCstmId");
	System.out.println(id+"<---insertQuestion id");

%>
<!-- 문의 : 회원만 작성 가능 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- script 선언 head 안으로 -->
<script>
	$(document).ready(function(){
		const MAX_COUNT = 500;
		$('#qContent').keyup(function(){ 
			let len = $('#qContent').val().length;
			if(len > MAX_COUNT) {
				let str = $('#qContent').val().substring(0,MAX_COUNT);
			$('#qContent').val(str);
			alert(MAX_COUNT+'자까지만 입력 가능합니다')
			} else {
				$('#count').text(len); // 현재 입력된 글자수 출력
			}
		});
	});
</script>
<title>상품 문의하기</title>
</head>
<body>
<h2 style="text-align: center;">상품 문의</h2>
<div class="container mt-3">
<form id="insertQuestion" action="<%=request.getContextPath()%>/question/insertQuestionAction.jsp" method="post">
<input type="hidden" name="productNo" value="<%=productNo%>">
<input type="hidden" name="id" value="<%=id%>">
<table class="table table-bordered">
	<tr>
		<td>
			<label for="qCategory">카테고리</label>
		</td>
		<td>
			<select name="qCategory">
			<option value="배송">배송</option>
			<option value="상품">상품</option>
			<option value="기타">기타</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="qTitle" size=60; placeholder="제목을 입력하세요(50자 이내)"></td>	
	</tr>
	<tr>
		<td>내용</td>
		<td>
		<textarea rows="5" cols="80" name="qContent" id="qContent" placeholder="내용을 입력하세요(최대500자)" style="resize: none;"></textarea>
		<span id="count"><em>0</em></span><em>/500</em>
		</td>
	</tr>
</table>
	<div>
		<button type=submit onclick="insertQuestion()">추가</button>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>">취소</a>
	</div>
</form>
</div>
<script>
function insertQuestion() {
	let form = document.getElementById("insertQuestion");
	if (form.qTitle.value.trim() === '') { // 공백 제거 후 비교
		alert('제목을 입력해주세요');
		form.qTitle.focus();
		event.preventDefault();
		return;
	}
	if (form.qContent.value.trim() === '') {
		alert('내용을 입력해주세요');
		form.qContent.focus();
		event.preventDefault();
		return;
	}
	
	let result = confirm("등록하시겠습니까?");
	  if (result) {
		  document.getElementById("insertQuestion").submit();
		  alert("게시글 등록이 완료되었습니다.");
	  }else{
		  event.preventDefault();
		    return;
	}
}
</script>
</body>
</html>