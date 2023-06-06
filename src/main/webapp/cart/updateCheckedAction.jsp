<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	//받아온 값 유효성 검사
	if(request.getParameter("checked")== null
		|| request.getParameter("id")== null
		|| request.getParameter("cartNo")== null	
		|| request.getParameter("checked").equals("")
		|| request.getParameter("id").equals("")
		|| request.getParameter("cartNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}
	// 받아온 값 변수에 저장
	String checked = request.getParameter("checked");
	String id = request.getParameter("id");
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	System.out.println(checked + " <-- updateCheckedAction checked");
	System.out.println(id + " <-- updateCheckedAction id");
	System.out.println(cartNo + " <-- updateCheckedAction cartNo");

	// Cart 객체를 사용
	Cart cart = new Cart();
	cart.setChecked(checked);
	cart.setId(id);
	cart.setCartNo(cartNo);
	
	// 5. 장바구니 체크 상태 수정 메서드
	CartDao cartDao = new CartDao();
	int row = cartDao.updateChecked(cart);
	
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