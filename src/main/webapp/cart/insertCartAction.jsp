<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<%
	
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 받아온 값 유효성 검사
	if(request.getParameter("productNo")== null
		|| request.getParameter("id") == null
		|| request.getParameter("cartCnt")==null
		|| request.getParameter("productNo").equals("")
		|| request.getParameter("id").equals("")
		|| request.getParameter("cartCnt").equals("")) {
		response.sendRedirect(request.getContextPath()+"/");
		return;
	}
	
	// 받아온 값 변수에 저장
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String id = request.getParameter("id");
	int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
	System.out.println(productNo +" <-- insertCartAction productNo");
	System.out.println(id +" <-- insertCartAction id");
	System.out.println(cartCnt +" <-- insertCartAction cartCnt");
	
	// Cart 객체 생성
	Cart cart = new Cart();
	cart.setProductNo(productNo);
	cart.setId(id);
	cart.setCartCnt(cartCnt);
	
	// 0. 장바구니 상품 조회, 추가,  수정
	CartDao cartDao = new CartDao();
	int row = cartDao.totalInsertCart(cart);
	
	if(row>0){
		System.out.println("성공");
		response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
		return;
	}else{
		System.out.println("실패");
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}	
	
	
	
	
	
	
	
	

%>