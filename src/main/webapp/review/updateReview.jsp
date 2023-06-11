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
	System.out.println(orderNo+"<---- review orderNo");
	
	// 리뷰 이미지와 글 출력 메서드
	ReviewDao review = new ReviewDao(); // DAO (동일)
	Review reviewText = review.selectReviewOne(orderNo); //vo
	ReviewImg reviewImg = review.selectReviewImg(orderNo); //vo

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
<input type = "hidden" name="preSaveFilename" value="<%=reviewImg.getReviewSaveFilename()%>">
		<table class="table table-bordered">
			<tr>
				<td>제목</td>
				<td>
				<input type="text" name="reviewTitle" value="<%=reviewText.getReviewTitle()%>" required="required">
				</td>
			</tr>
			<tr>
				<td>사진</td>
				<td>
				수정전 파일 : <%=reviewImg.getReviewSaveFilename()%>
				<input type="file" name="reviewImg">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
				<textarea name="reviewContent" cols="80" rows="10" style="resize: none;" required="required"><%=reviewText.getReviewContent()%></textarea>
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
				<button type=submit class="btn btn-light">수정</button>
				<a href="<%=request.getContextPath()%>/review/reviewOne.jsp?orderNo=<%=reviewText.getOrderNo()%>&productNo=<%=reviewText.getProductNo()%>" class="btn btn-light">취소</a>
			</div>
		</form>
	</div>
</body>
</html>