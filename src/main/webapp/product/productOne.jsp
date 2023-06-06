<!-- view 상품 상세정보 페이지 카테고리/상품이름/가격/상태/(재고)/정보 -->
<!-- 상세정보/리뷰/상품문의 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//출력 테스트중*********************************** 12 product
	/* 상품 상세페이지 productNo 유효성 검사 -------------------------------------------------------------
	if(request.getParameter("productNo") == null
	||request.getParameter("productNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
		return;
	}*/

	// 받아온 값 & 메서드 호출 test product:12 & id:customer1
	int productNo = 12;/*Integer.parseInt(request.getParameter("productNo"));*/
	OneDao one = new OneDao();
	
	HashMap<String,Object> p = one.selectProductOne(productNo);
	
	// 해당 상품 - 리뷰 페이징 --------------------------------------------------------------------------
	ReviewDao reviewDao = new ReviewDao();
	
	
	// 해당 상품 - 문의 페이징 --------------------------------------------------------------------------
	// 페이징 1) 현재 페이지
	int currentPage = 1; // 페이지 시작은 1
	if(request.getParameter("currentPage")!=null){ // 유효한 값이면 정상 출력
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	// 페이징 2) 전체 페이지
	QuestionDao questionDao = new QuestionDao();
	int totalRow = questionDao.selectQuestionCnt(); //dao 전체 row
	int rowPerPage = 5;  // 페이지 당 행의 수 5개씩 출력할 것
	int beginRow = (currentPage-1) * rowPerPage; //시작 행
	
	// 페이징 3) 페이지 네비게이션 (하단 페이징)
	int pagePerPage = 5; // 하단 페이징 숫자
	
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
	
	ArrayList<HashMap<String,Object>> list = questionDao.selectQuestionListByPage(productNo, beginRow, rowPerPage);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품페이지</title>
</head>
<body><!-- test  view 제품 12 카테고리/사진/이름/상품content출력 -->
	<h3>상품상세</h3>
	<table>
		<tr>
			<td>카테고리</td>
			<td><%=p.get("categoryName")%></td><!-- 상품 카테고리 -->
		</tr>
		<tr>
			<td><img src="${pageContext.request.contextPath}/product/productImg/<%=p.get("productSaveFilename")%>" width="100" height="100"></td>
		</tr>
		<tr>
			<td><%=p.get("productName")%></td><!-- 상품이름 -->
		</tr>
		<tr>
			<td><%=p.get("productPrice")%>원</td><!-- 상품가격 -->
		</tr>
		<tr>
			<td><%=p.get("productInfo")%></td><!-- 상품정보 -->
		</tr>
	</table>
	
<!-- 2) 리뷰 페이지(상세페이지 내에서 전체출력 되는 형태)-->

<!-- 3) 상품 문의사항 ----------------------------------------------------------------------->
<hr>
	<h3>문의사항</h3>
	<a href="<%=request.getContextPath()%>/question/insertQuestion.jsp">추가</a>
	<table>
		<tr>
			<th>번호</th>
			<th>문의유형</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
<%
	for(HashMap<String,Object> q : list){
%>
		<tr>
			<td><%=q.get("qNo")%></td>
			<td><%=q.get("category")%></td>
			<td>
			<a href="<%=request.getContextPath()%>/question/questionOne.jsp?qNo=<%=q.get("qNo")%>">
			<%=q.get("title")%>
			</a>
			</td>
			<td><%=q.get("id")%></td>
			<td><%=q.get("createdate")%></td>
		</tr>
<%
	}
%>
	</table>
	
<!-------------- 문의 사항 페이징 버튼 -------------------------------------------------------->
	<div id="page">
	<%
		if(minPage > 1) { //minpage가 1보다 클때 이전 페이지 출력
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>
	<%
			}
		for(int i = minPage; i<=maxPage; i=i+1) {
			if(i == currentPage){
	%>
			<span><%=i%></span>		
	<%			
			}else{	
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?currentPage=<%=i%>">
		<%=i%>
		</a>
	<%
			}
		}	
		if(maxPage != lastPage) { // maxpage와 lastpage가 같지 않을 때 다음 출력
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?currentPage=<%=minPage+pagePerPage%>">다음</a>
	<%
		}
	%>
	</div>
</body>
</html>