<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>


<%
	// 받아온 값 유효성 검사
	if(request.getParameter("cartCnt") == null
		|| request.getParameter("cartNo")== null
		|| request.getParameter("id")== null
		|| request.getParameter("cartCnt").equals("")
		|| request.getParameter("cartNo").equals("")
		|| request.getParameter("id").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}
	// 받아온 값 변수에 저장
	int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	String id = request.getParameter("id");
	System.out.println(cartCnt + " <--updateCartCntAction cartCnt");
	System.out.println(cartNo + " <--updateCartCntAction productNo");
	System.out.println(id + " <--updateCartCntAction id");
	
	// Cart 객체를 사용
	Cart cart = new Cart();
	cart.setCartCnt(cartCnt);
	cart.setCartNo(cartNo);
	cart.setId(id);
	
	// 4. 장바구니 단일 상품 수량 수정 메서드
	CartDao cartDao = new CartDao();
	int row = cartDao.updateSingleCart(cart);
	
	if(row==1){
		System.out.println("수정 완료");
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}else{
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}	
	
%>