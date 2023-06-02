<!-- view 상품 상세정보 페이지 카테고리/상품이름/가격/상태/재고/정보 -->
<!-- 상세정보/리뷰/상품문의 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	/*유효성 검사
	if(request.getParameter("productNo") == null
	||request.getParameter("productNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
		return;
	}

	// 받아온 값 & 메서드 호출
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	OneDao one = new OneDao();
	
	//객체 저장
	HashMap<String,Object> list = one.selectProductOne(productNo);*/
	
	
	/* 페이징 1) 현재페이지
	int currentPage = 1; // 페이지 시작은 1
	if(request.getParameter("currentPage")!=null){ // 유효한 값이면 정상 출력
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	// 페이징 2) 전체 페이지
	QuestionDao questionDao = new QuestionDao();
	int totalRow = QuestionDao.selectQuestionCnt(); //dao 안 전체row //dao 안 전체row
	int rowPerPage = 5;  // 페이지 당 행의 수
	int beginRow = (currentPage-1) * rowPerPage; //시작 행
	
	// 페이징 3) 페이지 네비게이션 (하단 페이징)
	int pagePerPage = 2; // 하단 페이징 숫자
	
	int lastPage = totalRow / rowPerPage; //마지막 페이지
	if(totalRow % rowPerPage != 0){ // 나누어 떨어지지 않으면 페이지 +1 하여 넘어감
		lastPage = lastPage + 1;
	}
	
	// minpage : 하단 페이징 가장 작은 수
	int minPage = ((currentPage -1) / pagePerPage) * pagePerPage + 1;
	
	// maxpage : 하단 페이징 가장 큰 수
	int maxPage = minPage + pagePerPage -1;
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}
	
	ArrayList<HashMap<String,Object>> list = QuestionDao.selectQuestionListByPage(beginRow, rowPerPage); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품페이지</title>
</head>
<body><!-- test -->
	<table>
		<tr>
			<td>제품번호</td>
			<td>카테고리</td>
			<td>제품이름</td>
		</tr>
		<tr>
		</tr>
	</table>
<!-- 2) 리뷰 페이지(상세페이지 내에서 전체출력 되는 형태)-->

<!-- 3) 문의사항 (게시글 형식/제목만) -->
	<table>
		<tr>
			<th>번호</th>
			<th>문의유형</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>
</body>
</html>