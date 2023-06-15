<%@page import="dao.DiscountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	if(request.getParameter("discountNo") == null) {
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
		return;
	}

	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	
	DiscountDao dDao = new DiscountDao();
	
	int row = dDao.deleteDiscount(discountNo);
	
	if(row > 0){
		System.out.println("할인삭제완료");
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
		return;
	}
	System.out.println("할인삭제실패");
	response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
%>
