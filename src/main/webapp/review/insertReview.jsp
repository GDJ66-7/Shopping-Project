<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");

	//로그인 유효성 검사
	if(session.getAttribute("loginCstmId") == null) {
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}
	
	//요청값 유효성 검사
	if(request.getParameter("productNo") == null  
	|| request.getParameter("productNo").equals("")
	|| request.getParameter("historyNo") == null
	|| request.getParameter("historyNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
		return;
	}
	
	String id = (String)session.getAttribute("loginCstmId");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int historyNo = Integer.parseInt(request.getParameter("historyNo"));
	
	System.out.println(productNo+"<---productNo review");
	System.out.println(historyNo+"<---historyNo review");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		var $reviewContent = $('textarea[name="reviewContent"]');
		const MAX_COUNT = 500; // const 상수선언 사용하는 키워드(자바의 final과 유사함:변경될 수 없는 값)
		$('#reviewContent').keyup(function(){ // 키보드를 눌렀다 떼면
			let len = $('#reviewContent').val().length; // textarea === val 값으로 불러옴
			if(len > MAX_COUNT) { // 길이가 500보다 커지면 0부터 500까지 잘라 보여줌(0부터니까 501자에서 멈추고 자름)
				let str = $('#reviewContent').val().substring(0,MAX_COUNT);
			$('#reviewContent').val(str);
			alert(MAX_COUNT+'자까지만 입력 가능합니다')
			} else {
				$('#count').text(len); // 현재 입력된 글자수 출력
			}
		  });
	});
</script>
<title>상품 리뷰 작성</title>
</head>
<body>
<h2 style="text-align: center;">상품 리뷰 작성</h2>
<div class="container mt-3">
<form id="insertReview" action="<%=request.getContextPath()%>/review/insertReviewAction.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="historyNo" value="<%=historyNo%>">
<input type="hidden" name="productNo" value="<%=productNo%>">
<input type="hidden" name="id" value="<%=id%>">
<!--* 마이페이지 리뷰 작성-->
	<%
		if(request.getParameter("msg") != null){
	%>
		<div style="font-size: 10pt;"><%=request.getParameter("msg")%></div>
	<%
		}
	%>
	<table class="table table-bordered">
		<tr>
			<td>제목</td>
			<td><input type="text" name="reviewTitle" size=60; placeholder="제목을 입력해주세요(50자 이내)"></td>	
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea rows="5" cols="80" name="reviewContent" id="reviewContent" placeholder="내용을 입력하세요(최대500자)" style="resize: none;"></textarea>
			<span id="count"><em>0</em></span><em>/500</em>
			</td>	
		</tr>
		<tr>
			<td>사진 업로드</td>
			<td><input type="file" name="reviewImg" accept="image/jpeg, image/jpg"></td>
		</tr>
	</table>
	<div>
		<button type=submit class="btn btn-light" onclick="insertReview()">작성</button>
		<a href="<%=request.getContextPath()%>/order/customerOrderHistory.jsp" class="btn btn-light">취소</a>
	</div>
</form>
</div>
<script>
function insertReview() {
	let form = document.getElementById("insertReview");
	if (form.reviewTitle.value.trim() === '') { // 공백 제거 후 비교
		alert('제목을 입력해주세요');
		form.reviewTitle.focus();
		event.preventDefault();
		return;
	}
	if (form.reviewContent.value.trim() === '') {
		alert('내용을 입력해주세요');
		form.reviewContent.focus();
		event.preventDefault();
		return;
	}
	if (form.reviewImg.value.trim() === '') {
		alert('사진을 등록해주세요');
		form.reviewImg.focus();
		event.preventDefault();
		return;
	} // input file 유효성 검사 자바스크립트 방법도 시도해보기
	
	let result = confirm("리뷰를 등록하시겠습니까?");
	  if (result) {
		  document.getElementById("insertReview").submit();
		  alert("게시글 등록이 완료되었습니다.");
	  }else{
		  event.preventDefault();
		    return;
	}
}
</script>
</body>
</html>