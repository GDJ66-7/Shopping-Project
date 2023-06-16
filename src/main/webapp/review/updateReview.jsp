<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	if(request.getParameter("historyNo") == null
	||request.getParameter("historyNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}

	// 로그인 세션 검사 -- 조회/수정/삭제
	
	// 리뷰one에서 받은 값 저장 & 메서드 호출 --- 수정 전 데이터 불러오기라 reviewOne과 동일
	//int productNo = Integer.parseInt(request.getParameter("productNo"));
	int historyNo = Integer.parseInt(request.getParameter("historyNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(historyNo+"<-----updateReview historyNo");
	System.out.println(productNo+"<-----updateReview productNo");
	
	// 리뷰 이미지와 글 출력 메서드
	ReviewDao review = new ReviewDao(); // DAO (동일)
	Review reviewText = review.selectReviewOne(historyNo); //vo
	ReviewImg reviewImg = review.selectReviewImg(historyNo); //vo
	System.out.println(reviewImg+"<---- review updateImg");

%>
<!DOCTYPE html>
<html>
<head>
<!-- css 확인하기 쉽게 잠시 적용 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		const MAX_COUNT = 500; //const 상수선언 사용하는 키워드(자바의 final과 유사함:변경될 수 없는 값)
		const $reviewContent = $('#reviewContent'); //내용 id
		const $count = $('#count em'); //글자수 id
		
		function preContentCheck() { // 현재 입력되어 있는 글자수 확인을 위한 함수 선언(변수와 달리 함수명은 사용자가 정한다)
			let len = $reviewContent.val().length; // 현재 입력되어있는 글자 수 확인
			if(len > MAX_COUNT) {
				let str = $reviewContent.val().substring(0, MAX_COUNT);
				$reviewContent.val(str);
				alert(MAX_COUNT + '자까지만 입력 가능합니다');
				len = MAX_COUNT;
			}
			$count.text(len); //현재 입력된 글자수 출력
		}
		$reviewContent.on('input', preContentCheck); // reviewContent내에 있는(이벤트종류:input,업데이트 콜백 함수)호출
		preContentCheck(); // 수정 페이지가 로드될 때 원래 입력되어있던 글자 수 체크
	});
</script>
<title>리뷰 수정</title>
<style>
a{text-decoration: none;}
#bar {background-color: #FAECC5;}
</style>
</head>
<body>
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">상품 리뷰 수정하기</h2>
<form action="<%=request.getContextPath()%>/review/updateReviewAction.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="productNo" value="<%=productNo%>">
<input type="hidden" name="historyNo" value="<%=historyNo%>">	
	<%
		if(request.getParameter("msg") != null){
	%>
	<div style="font-size: 10pt;"><%=request.getParameter("msg")%></div>
	<%
		}
	%>
		<table class="table table-bhistoryed">
			<tr>
				<td>제목</td>
				<td>
				<input type="text" name="reviewTitle" value="<%=reviewText.getReviewTitle()%>" required="required" size=60;>
				</td>
			</tr>
			<tr>
				<td>사진</td>
				<td>
				수정전 파일 :<%=(String)reviewImg.getReviewOriFilename()%>
				<input type="file" name="reviewImg">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
				<textarea name="reviewContent" id="reviewContent" cols="80" rows="10" style="resize: none;" required="required"><%=reviewText.getReviewContent()%></textarea>
				<span id="count"><em>0</em></span><em>/500</em>
				</td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><%=reviewText.getCreatedate().substring(0,10)%></td>
			</tr>
			<tr>
				<td>수정일</td>
				<td><%=reviewText.getUpdatedate().substring(0,10)%></td>
			</tr>
			</table>
			<div>
				<button type=submit id="button" class="btn btn-light">수정</button>
				<a href="<%=request.getContextPath()%>/review/reviewOne.jsp?historyNo=<%=reviewText.getHistoryNo()%>&productNo=<%=reviewText.getProductNo()%>" class="btn btn-light">취소</a>
			</div>
		</form>
	</div>
</body>
</html>