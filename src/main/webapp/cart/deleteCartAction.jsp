<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<%
	// 받아온 값 유효성 검사
	if(request.getParameter("productNo")== null
		|| request.getParameter("productNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	String id = "customer1";
	int productNo = Integer.parseInt(request.getParameter("productNo"));

	// vo 객체 생성
	Cart cart = new Cart();
	cart.setProductNo(productNo);
	cart.setId(id);

	// dao 객체 생성
	CartDao cartDao = new CartDao();
	int row = cartDao.deleteCart(cart);

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