<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 상품추가시 카테고리를 분류해야하는데 카테고리는 외래키로 지정되어 있어 기존 값에서 선택해야한다
	// 그러므로 카테고리 name리스트를 출력해 선택할 수 있도록 했다.
	CategoryDao cDao = new CategoryDao();
	ArrayList<HashMap<String, Object>> cList = cDao.categoryNameList();
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>상품추가</h1>
	<form action="<%=request.getContextPath()%>/product/insertProductAction.jsp" method = "post" enctype="multipart/form-data">
		<table>
			<!-- 상품 추가 폼 -->
			<tr>
				<!-- 카테고리 선택 -->
				<th>카테고리 분류</th>
				<td>
					<select name = "categoryName" required="required">
						<%
							for(HashMap<String, Object> cMap : cList) {
								
						%>
							<option value="<%=cMap.get("categoryName")%>">
									<%=cMap.get("categoryName")%>
							</option>
						<% 
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>상품 이름</th>
				<td>
					<input type="text" name="productName" required="required">
				</td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td>
					<input type="text" name="productPrice" required="required" placeholder="숫자만 입력해주세요">
				</td>
			</tr>
			<tr>
				<!--  ENUM으로 값이 설정되어 있어 세가지중 하나를 선택하여 보냄 -->
				<th>상품 상태</th>
				<td>
					<select name="productStatus">
						<option value="판매중">판매중</option>
						<option value="품절">품절</option>
						<option value="단종">단종</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>상품 재고량</th>
				<td>
					<input type="text" name="productStock" required="required" placeholder="숫자로 입력해주세요">
				</td>
			</tr>
			<tr>
				<th>상품 설명</th>
				<td>
					<textarea rows="3" cols="50" name="productInfo" required="required"></textarea>
				</td>
			</tr>
			<tr>
				<th>상품 사진</th>
				<td>
					<!-- 사진 파일 전송 -->
					<input type="file" name="productFile" required="required">
				</td>
			</tr>
		</table>
		<button type="submit">상품추가</button>
	</form>
</body>
</html>