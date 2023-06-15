<%@page import="vo.Discount"%>
<%@page import="dao.DiscountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(request.getParameter("discountNo") == null) {
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
	}
	
	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	String discountStart = request.getParameter("discountStart");
	String discountEnd = request.getParameter("discountEnd");
	Double discountRate = Double.parseDouble(request.getParameter("discountRate"));

	System.out.println(discountNo + "<-- insertDiscountAction discountNo");
	System.out.println(discountStart + "<-- insertDiscountAction discountStart");
	System.out.println(discountEnd + "<-- insertDiscountAction discountEnd");
	System.out.println(discountRate + "<-- insertDiscountAction discountRate");
	
	
	DiscountDao dDao = new DiscountDao();
	Discount d = new Discount();
	d.setDiscountNo(discountNo);
	d.setDiscountStart(discountStart);
	d.setDiscountEnd(discountEnd);
	d.setDiscountRate(discountRate);
	
	int row = dDao.updateDiscount(d);
	
	if(row > 0){
		System.out.println("할인수정완료");
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
		return;
	}
	System.out.println("할인수정실패");
	response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
%>
