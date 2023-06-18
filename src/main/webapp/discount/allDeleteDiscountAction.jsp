<%@page import="dao.DiscountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 유효성검사 null이아니면 개별값이 들어온것이므로 전체삭제가실행될 수 없음
	if(request.getParameter("discountNo") != null) {
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
		return;
	}
	
	//DiscountDao를 사용하기위한 객체
	DiscountDao dDao = new DiscountDao();
	
	int allRow = dDao.allDeleteDiscount();
	if(allRow > 0){
		System.out.println("할인기간지난 상품전체삭제완료");
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
		return;
	}
	System.out.println("할인기간지난 상품삭제실패");
	response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
%>	
