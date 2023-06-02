<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<%


	int productNo = 0;
	String id = null;
	int cartCnt = 0;

	//vo 객체 생성
	Cart cart = new Cart();
	
	cart.setProductNo(productNo);
	cart.setId(id);
	cart.setCartCnt(cartCnt);


	//dao 객체 생성
	CartDao cartDao = new CartDao();

	//장바구니 상품 추가
	int add = cartDao.insertCart(cart);
	
	// 현재 장바구니에 있는 상품인지 확인
	int check = cartDao.selectCartCheck(cart);
	// 현재 장바구니에 있는 상품이면 추가한 수량만큼 +
	int sum = cartDao.updateCartCntSum(cart);

	


%>