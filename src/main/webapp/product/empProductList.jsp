<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ProductDao pDao = new ProductDao();

	// 관리자 상품리스트는 전체상품을 보여주므로 매개변수 공백값처리.
	String productName =  request.getParameter("productName");
	if(productName == null) {
		productName = "";
	}
	
	String discountProduct = "";
	String categoryName = "";
	String ascDesc = "";
	
	// ----------------- 페이징 처리---------------------------
	//현재페이지 변수
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 페이지당 출력할 행의 수
	int rowPerPage = 10;
	
	// 페이지당 시작 행번호
	int beginRow = (currentPage-1) * rowPerPage;
	
	int totalRow = pDao.productListCnt1(categoryName, productName, ascDesc, discountProduct);
	System.out.println(totalRow + "<-- productList totalRow");
	
	int lastPage = totalRow / rowPerPage;
	//rowPerPage가 딱 나뉘어 떨어지지 않으면 그 여분을 보여주기 위해 +1
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	// 페이지 네비게이션 페이징
	int pagePerPage = 10;

	// 마지막 페이지 구하기
	// 최소페이지,최대페이지 구하기
	int minPage = ((currentPage-1) / pagePerPage) * pagePerPage + 1;
	int maxPage = minPage + (pagePerPage -1);
	
	// maxPage가 마지막 페이지를 넘어가지 않도록 함
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}
	
	ArrayList<HashMap<String,Object>> pList = pDao.productList1(productName, categoryName, ascDesc, discountProduct, beginRow, rowPerPage);
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  table {
    border-collapse: collapse;
    width: 100%;
  }
  
  th, td {
    border: 1px solid black;
    padding: 8px;
  }
</style>
</head>
<body>
	<form action="<%=request.getContextPath()%>/product/empProductList.jsp" method="get">
	
       	<!-- value값이 초기엔 null이라 value값을 보여주지 않는다 ex) 침대를 검색시 침대값이 유지된 상태로 검색된다. -->
       	<input type="text" name="productName" <%if(request.getParameter("productName") != null) {%> value="<%=request.getParameter("productName")%>" <%}%> placeholder="상품이름검색">
       	<button type="submit">검색</button>
	</form>
       	
	<table>
		<tr>
			<th>번호</th>
			<th>카테고리</th>
			<th>이름</th>
			<th>가격</th>
			<th>상태</th>
			<th>재고</th>
			<th>등록일</th>
			<th>수정일</th>
		</tr>
			<%
				for(HashMap<String, Object> productMap : pList) {
			%>
					<tr>
						<td><%=productMap.get("productNo") %></td>
						<td><%=productMap.get("categoryName") %></td>
			<% 			
					// 할인이 들어간 상품은 빨간글씨로 이름표시하며 할인가도 같이 나옴
					if ((int)productMap.get("productDiscountPrice") != ((int)productMap.get("productPrice"))) {
			%>
						<td><img src="${pageContext.request.contextPath}/product/productImg/<%=productMap.get("productSaveFilename") %>" width="50" height="50">
							 <span style="color: red;"><%=productMap.get("productName") %></span>
						</td>
						<td>원가:<%=productMap.get("productPrice") %>
							<br>
							할인가:<%=productMap.get("productDiscountPrice") %>
						</td>
			<% 
					} else {
			%>
						<td><img src="${pageContext.request.contextPath}/product/productImg/<%=productMap.get("productSaveFilename") %>" width="50" height="50">
							 <%=productMap.get("productName") %>
						</td>
						<td><%=productMap.get("productPrice") %></td>
			<% 
					}
			%>
						<td><%=productMap.get("productStatus") %></td>
						<td><%=productMap.get("productStock") %></td>
						<td><%=productMap.get("createdate") %></td>
						<td><%=productMap.get("updatedate") %></td>
			<% 		
					// 상품수정은 관리자로그인시에만 볼 수 있음 관리자2만가능
					if(session.getAttribute("loginEmpId2") != null) {
			%>
						<td>
							<a href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=productMap.get("productNo")%>&productImgNo=<%=productMap.get("productImgNo")%>">수정</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/discount/inserttDiscount.jsp?productNo=<%=productMap.get("productNo")%>">할인</a>
						</td>
					</tr>
			<% 
					}
				}
			%>
	</table>
	<!--  페이징부분 -->
   	<ul class="pagination justify-content-center list-group list-group-horizontal">
		<% 
			// 최소페이지가 1보다크면 이전페이지(이전페이지는 만약 내가 11페이지면 1페이지로 21페이지면 11페이지로)버튼
			if(minPage>1) {
		%>
				<li class="list-group-item">
					<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=minPage-pagePerPage%>&productName=<%=productName%>">이전</a>
				</li>
		<%			
			}
			// 최소 페이지부터 최대 페이지까지 표시
			for(int i = minPage; i<=maxPage; i=i+1) {
				if(i == currentPage) {	// 현재페이지는 링크 비활성화
		%>	
					<!-- i와 현재페이지가 같은곳이라면 현재위치한 페이지 빨간색표시 -->
					<li class="list-group-item">
						<span style="color: red;"><%=i %></span>
					</li>
		<%			
				// i가 현재페이지와 다르다면 출력
				}else {					
		%>		
					<li class="list-group-item">
						<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=i%>&productName=<%=productName%>"><%=i%></a>
					</li>
		<%				
				}
			}
			
			// maxPage가 마지막페이지와 다르다면 다음버튼 마지막페이지에서는 둘이 같으니 다음버튼이 안나오겠죠
			// 다음페이지(만약 내가 1페이지에서 누르면 11페이지로 11페이지에서 누르면 21페이지로)버튼
			if(maxPage != lastPage) {
		%>
				<li class="list-group-item">
					<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=minPage+pagePerPage%>&productName=<%=productName%>">다음</a>
				</li>
		<%	
			}
		%>
	</ul>
</body>
</html>