<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%
	// 회원 장바구니
	

	// 비회원 장바구니
	

	String id = "customer1";
	

	// dao 객체 생성
	CartDao cartDao = new CartDao();	
	// 장바구니 상품 리스트 selectCartList
	ArrayList<HashMap<String, Object>> list = cartDao.cartList(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
<h1>장바구니</h1>
	<form>
	<table class="table">
		<tr>
			<th>선택</th>
			<th>상품이미지</th>
			<th>상품정보</th>
			<th>상품가격</th>
			<th>수량</th>
			<th>할인된가격</th>
			<th>삭제</th>
		</tr>	
		<%
			for(HashMap<String, Object> c : list) {		
				//String checked = (String)(c.get("체크"));
		%>
			<tr>
				<td>
					<input type="hidden" name="cartNo" value="<%=(int)(c.get("장바구니번호"))%>">				
					<input name="checked" value="Y" type="checkbox">
				</td>
				<td>
					<%=(String)(c.get("상품이미지"))%>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/product/productOne.jsp">
						<%=(String)(c.get("상품이름"))%>
					</a>
				</td>
				<td>
					<%=(int)(c.get("상품가격"))%>원
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/cart/updateCartAction.jsp">
						<select name=product>
							<option>
								<%=(int)(c.get("수량"))%>
							</option>
						</select>
					</a>
				</td>
				<td>
					<%=(int)(c.get("할인상품가격"))%>원
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/cart/deleteCartAction.jsp">
						<button type="submit">X</button>
					</a>
				</td>
			</tr>
		<%
			}
		%>	
	</table>	
	<table class="table">	
		<tr>
			<td>
				<a href="<%=request.getContextPath()%>/main/home.jsp">
					<button type="button">계속쇼핑하기</button>
				</a>
			</td>
			<td>
				<a href="<%=request.getContextPath()%>/cart/cartOrder.jsp">
					<button type="button">구매하기</button>
				</a>
			</td>
		</tr>
	</table>	
	</form>
</div>

</body>
</html>