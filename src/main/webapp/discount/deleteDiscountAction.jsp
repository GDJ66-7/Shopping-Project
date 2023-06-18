<%@page import="dao.DiscountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 유효성검사
	if(request.getParameter("discountNo") == null) {
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
		return;
	}
	
	int	discountNo = Integer.parseInt(request.getParameter("discountNo"));
	System.out.println(discountNo + "<-- deleteDiscountAction discountNo");
	
	// DiscountDao를 사용하기위한 객체
	DiscountDao dDao = new DiscountDao();
	
	// discountNo의 값이 0이아니면 선택적삭제이므로 실행
	
	int row = dDao.deleteDiscount(discountNo);
	
	String msg ="";
	if(row > 0){
		System.out.println("할인삭제완료");
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp?deleteDiscountMsg="+msg);
		return;
	}
	System.out.println("할인삭제실패");
	response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp?deleteDiscountMsg2="+msg);
	
%>
