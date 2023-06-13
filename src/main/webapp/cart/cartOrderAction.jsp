<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*"%>

<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	// 받아온 값 유효성 검사
	if(request.getParameter("id")==null
		|| request.getParameter("totalCartCnt")==null
		|| request.getParameter("totalPay")==null
		|| request.getParameter("selectAddress")==null
		|| request.getParameter("inputPoint")==null
		|| request.getParameter("id").equals("")
		|| request.getParameter("totalCartCnt").equals("")
		|| request.getParameter("totalPay").equals("")
		|| request.getParameter("selectAddress").equals("")
		|| request.getParameter("inputPoint").equals("")){
		response.sendRedirect(request.getContextPath()+"/cart/cartOrder.jsp");
		return;
	}
	String id = request.getParameter("id");
	int totalCartCnt = Integer.parseInt(request.getParameter("totalCartCnt"));
	int totalPay = Integer.parseInt(request.getParameter("totalPay"));
	String selectAddress = request.getParameter("selectAddress");
	int inputPoint = Integer.parseInt(request.getParameter("inputPoint"));
				
	
	// Dao 객체 선언
	CartDao cartDao = new CartDao();
	

 
	// 12. 장바구니 정보를 오더테이블에 저장
	int row1 = cartDao.insertOrder(id, totalCartCnt, totalPay, selectAddress);
	if(row1 == 0) {
		System.out.println("오더 테이블 추가 실패");
	}
	


	response.sendRedirect(request.getContextPath()+"/main/home.jsp");


%>