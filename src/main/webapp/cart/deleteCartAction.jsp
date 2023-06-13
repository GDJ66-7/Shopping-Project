<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<%
	// 받아온 값 유효성 검사
	if(request.getParameter("cartNo")== null
		|| request.getParameter("id")== null
		|| request.getParameter("cartNo").equals("")
		|| request.getParameter("id").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}
	// 받아온 값 변수에 저장
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	String id = request.getParameter("id");
	System.out.println(cartNo + " <--deleteCartAction cartNo");
	System.out.println(id + " <--deleteCartAction id");
	
	// Cart 객체를 사용
	Cart cart = new Cart();
	cart.setCartNo(cartNo);
	cart.setId(id);
	
	// 3. 장바구니 단일 상품 삭제 메서드
	CartDao cartDao = new CartDao();
	int row = cartDao.deleteSingleCart(cart);
	
	if(row==1){
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}else{
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}
	

%>