<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%
	// 회원 장바구니
	

	// 비회원 장바구니
	
	String id = "customer1";
	
	// 1. 장바구니 상품 목록 메서드
	CartDao cartDao = new CartDao();	
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
	
	<table class="table">
		<tr>
			<th>선택</th>
			<th>상품이미지</th>
			<th>상품정보</th>
			<th>상품가격</th>
			<th>할인적용가격</th>
			<th>수량</th>
			<th>전체가격</th>
			<th>삭제</th>
		</tr>	
		<%
			for(HashMap<String, Object> c : list) {		
				// 1. 변수에 조회한 값을 저장
				int productNo = (int)(c.get("상품번호"));
				int cartCnt = (int)(c.get("수량"));
				String checked = (String)(c.get("체크"));
	
				// 2. 상품의 최대로 선택 가능한 개수(상품의 재고량만큼)
				int totalCnt = cartDao.maxCartCnt(productNo);
				
				
				// 수량이 0이거나 재고가 없는 경우 해당 상품을 리스트에 표시하지 않는다
				if(cartCnt ==0 || totalCnt==0) {
					continue;	// 건너뛴다.
				}
		%>
			<tr>			
				<td>
					<!-- 체크 상태를 수정 하기 위한 폼 -->
					<form action="<%=request.getContextPath()%>/cart/updateCheckedAction.jsp" method="post">
					<input type="hidden" name=id value="<%=(String)(c.get("아이디"))%>">
					<input type="hidden" name=cartNo value="<%=(int)(c.get("장바구니번호"))%>">
					<label>	
						<input type="radio" name="checked" value="y" <%=(checked.equals("y")) ? "checked" : ""%>> Y
					</label>
					<label>	
						<input type="radio" name="checked" value="n" <%=(checked.equals("n")) ? "checked" : ""%>> N
					</label>
					<input type="submit" value="변경">
					</form>
				</td>
				<td>
					<img src="${pageContext.request.contextPath}/product/productImg/<%=c.get("상품이미지")%>" width="100" height="100">
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
					<%=(int)(c.get("할인상품가격"))%>원
				</td>
				<td>
					<!-- 단일 상품 개수를 수정 하기 위한 폼 -->
					<form action="<%=request.getContextPath()%>/cart/updateCartCntAction.jsp" method="post">
						<input type="hidden" name=cartNo value="<%=(int)(c.get("장바구니번호"))%>">
						<input type="hidden" name="id" value="<%=(String)(c.get("아이디"))%>">	
						<select name = "cartCnt">
							<%			
								for(int i =1; i<=totalCnt; i++) {
									%>
										<option <%=(i == cartCnt) ? "selected" : "" %> value="<%=i%>">
											<%=i%>
										</option>					
									<%
								}
							%>
						</select>	
						<input type="submit" value="변경">		
					</form>
				</td>
				<td>
					<%=(int)(c.get("전체가격"))%>원
				</td>
				
				<td>
					<!-- 단일행 삭제를 위한 폼 -->
					<form action="<%=request.getContextPath()%>/cart/deleteCartAction.jsp" method="post">
						<input type="hidden" name="productNo" value="<%=(int)(c.get("상품번호"))%>">
						<input type="hidden" name="id" value="<%=(String)(c.get("아이디"))%>">				
						<input type="submit" value="X">
					</form>
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
</div>
</body>
</html>