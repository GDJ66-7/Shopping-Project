<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.ProductImg"%>
<%@page import="java.util.HashMap"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/*
	// 관리자 로그인 요청값 검사
	if(session.getAttribute("loginEmpId2") == null) {
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
	*/
	ProductDao pDao = new ProductDao();
	
	HashMap<String, Object> pMap = new HashMap<>();
	
	int productNo = 12;
	int productImgNo = 4;
	
	pMap = pDao.productOne(productNo, productImgNo);
	
	CategoryDao cDao = new CategoryDao();
	ArrayList<HashMap<String, Object>> cList = cDao.categoryNameList();
	System.out.println(pMap.get("productNo"));
	System.out.println(pMap.get("productImgNo"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/product/updateProductAction.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="productNo" value="<%=pMap.get("productNo") %>">
	<input type="hidden" name="productImgNo" value="<%=pMap.get("productImgNo") %>">
		<table>
			<tr>
				<td>카테고리이름</td>
				<td>
					<select name="categoryName">
						<%
							for(HashMap<String, Object> map : cList ) {
						%>
								<option value="<%=map.get("categoryName")%>"> 
									<%=map.get("categoryName") %>
								</option>
						<% 	
							}
						%>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>상품이름</td>
				<td>
					<input type="text" name="productName" placeholder="기존이름 :<%=pMap.get("productName")%>">
				</td>
			</tr>
			<tr>
				<td>상품가격</td>
				<td>
					<input type="text" name="productPrice" placeholder="기존가격 :<%=pMap.get("productPrice")%>">
				</td>
			</tr>
			<tr>
				<td>상품상태 기존상태 : <%=pMap.get("productStatus")%></td>
				<td>
					<select name="productStatus">
						<option value="판매중">판매중</option>
						<option value="품절">품절</option>
						<option value="단종">단종</option>
					</select>
				</td>
			</tr>
				<tr>
				<td>상품재고</td>
				<td>
					<input type="text" name="productStock" placeholder="기존재고량 :<%=pMap.get("productStock")%>">
				</td>
			</tr>
			
			<tr>
				<td>상품정보</td>
				<td>
					<textarea rows="3" cols="50" name="productInfo" placeholder="기존설명 :<%=pMap.get("productInfo") %>"></textarea>				
				</td>
			</tr>
			<tr>
				<td>boardFile(수정전 사진이름 : <%=pMap.get("productOriFilename")%></td>
				<td>
					<input type="file" name="productFile" required="required">
				</td>
			</tr>
		</table>
		<button type="submit">상품수정</button>
	</form>
</body>
</html>