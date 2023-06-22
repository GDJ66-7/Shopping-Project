<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*" %>

<%
	// 한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	String id = null; // 아이디 변수 초기화
	
	// 관리자 계정으로 접속했을때
	if(session.getAttribute("loginEmpId1") != null || session.getAttribute("loginEmpId2") != null) {
		out.println("<script>alert('관리자 계정으로 로그인 중'); location.href='"+request.getContextPath()+"/product/productList.jsp';</script>");
		return;
	}
	
	// 고객 계정으로 접속했을때
	if(session.getAttribute("loginCstmId") != null) {
		id = (String)(session.getAttribute("loginCstmId"));
		System.out.println(id+ " <-- cartList 고객아이디");
	}
	
	// 비회원으로 접속했을때
	if(session.getAttribute("loginCstmId") == null) {
		System.out.println(id+ " <-- cartList 비회원");
	}
	
	// 받아온 값 유효성 검사
	if(request.getParameter("productNo")== null
		|| request.getParameter("cartCnt")==null
		|| request.getParameter("productNo").equals("")
		|| request.getParameter("cartCnt").equals("")) {
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
	
	// 받아온 값 변수에 저장
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
	System.out.println(productNo +" <-- insertCartAction productNo");
	System.out.println(cartCnt +" <-- insertCartAction cartCnt");
	
	// Cart 객체 생성
	Cart cart = new Cart();
	cart.setProductNo(productNo);
	cart.setId(id);
	cart.setCartCnt(cartCnt);
	
	// 고객 계정으로 접속했을때
	if(id != null) { 
		
		// 0. 장바구니 상품 조회, 추가, 수정
		CartDao cartDao = new CartDao();
		int row = cartDao.totalInsertCart(cart);
		
		if(row>0){
			System.out.println("성공");
			response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productNo="+productNo);
			return;
		}else{
			System.out.println("실패");
			response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
			return;
		}	
	} 
	
	// 비회원으로 접속했을때 장바구니 세션 생성
	if(id == null) {
		HashMap<String, Cart> newCartList = null; // HashMap 변수 초기화
		if(session.getAttribute("newCartList") == null){ // 장바구니 세션이 없으면
			newCartList = new HashMap<>(); // 새로운 HashMap을 생성
			session.setAttribute("newCartList", newCartList);
		} else { // 장바구니 세션이 있으면
			newCartList = (HashMap<String, Cart>) session.getAttribute("newCartList"); // 기존 장바구니세션 사용
		}
		
		boolean ckProduct = false;
	    for (Cart ckCart : newCartList.values()) {
	        if (ckCart.getProductNo()==(productNo)) { // 원래있던 카트에 상품번호(productNo)가 추가된 상품번호(productNo)가 같으면 진행
	            ckCart.setCartCnt(ckCart.getCartCnt() + cartCnt); // 동일한 상품번호(productNo)가 있으면 해당 수량(cartCnt)을 증가
	            // true로 변환시켜서 제품추가 다시 안되도록 설정
	            ckProduct = true;
	        }
	    }
	    
	 	// 동일 제품 추가안된 제품의 경우에는 새롭게 추가
	    if (!ckProduct) {
		
		// 제품을 추가할때마다 새로운 ID값을 추가
		cart.setId(UUID.randomUUID().toString());
		newCartList.put(cart.getId(), cart);
	    }
	 	
		// 디버깅
		for (Cart c : newCartList.values()) {
			System.out.println(c.getId()+" <-- insertCartAction getId()");
			System.out.println(c.getProductNo()+" <-- insertCartAction getProductNo()");
			System.out.println(c.getCartCnt()+" <-- insertCartAction getCartCnt()");
		}
		// 제품 상세 페이지로 이동합니다.
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productNo="+productNo);
		return;    
	}
	

%>