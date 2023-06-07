<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	if(request.getParameter("orderNo") == null
	||request.getParameter("orderNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}

	// 로그인 세션 검사 -- 조회/수정/삭제
	
	// 리뷰one에서 받은 값 저장 & 메서드 호출 --- 수정 전 데이터 불러오기라 reviewOne과 동일
	//int productNo = Integer.parseInt(request.getParameter("productNo"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(productNo+"<---- review productNo");
	ReviewDao review = new ReviewDao(); // dao
	
	// 텍스트
	Review reviewText = new Review(); // vo
	reviewText = review.selectReviewOne(orderNo);
	
	// 이미지
	ReviewImg reviewImg = new ReviewImg();
	reviewImg = review.reviewImg(orderNo);

%>
<!DOCTYPE html>
<html>
<head>
<!-- css 확인하기 쉽게 잠시 적용 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
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
<form action="<%=request.getContextPath()%>/review/updateReviewAction.jsp?orderNo=<%=orderNo%>&productNo=<%=productNo%>" method="post" enctype="multipart/form-data">
<input type="hidden" name="Id" value="<%=reviewText.getId()%>"><!-- 세션검사 -->
		<table class="table table-bordered">
			<tr>
				<td>제목</td>
				<td>
				<input type="text" name="reviewTitle" value="<%=reviewText.getReviewTitle()%>" required="required">
				</td>
			</tr>
			<tr>
				<td>사진</td><!-- null값 출력 수정해야함-->
				<td>
				<%=reviewImg.getReviewSaveFilename()%>
				<input type="file" name="reviewImg">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
				<textarea name="reviewContent" cols="80" rows="10" style="resize: none;" required="required"><%=reviewText.getReviewContent()%></textarea>
				</td>
				</tr>
			</table>
			<div>
				<button type=submit class="btn btn-light">수정</button>
				<a href="<%=request.getContextPath()%>/review/reviewOne.jsp?orderNo=<%=reviewText.getOrderNo()%>" class="btn btn-light">취소</a>
			</div>
		</form>
	</div>
</body>
</html>