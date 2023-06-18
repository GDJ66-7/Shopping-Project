<%@page import="vo.Discount"%>
<%@page import="dao.DiscountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 유효성 검사
	if(request.getParameter("productNo") == null 
		||request.getParameter("discountStart") == null
		||request.getParameter("discountEnd") == null
		||request.getParameter("discountRate") == null) {
		response.sendRedirect(request.getContextPath()+"/product/empProductList.jsp");
		return;
	}

	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String discountStart = request.getParameter("discountStart");
	String discountEnd = request.getParameter("discountEnd");
	Double discountRate = Double.parseDouble(request.getParameter("discountRate"));
	
	System.out.println(productNo + "<-- insertDiscountAction productNo");
	System.out.println(discountStart + "<-- insertDiscountAction discountStart");
	System.out.println(discountEnd + "<-- insertDiscountAction discountEnd");
	System.out.println(discountRate + "<-- insertDiscountAction discountRate");
	
	// DiscountDao 클래스 객체 생성
	DiscountDao dDao = new DiscountDao();
	// insert를 위해 변수값 vo에 입력
	Discount d = new Discount();
	d.setProductNo(productNo);
	d.setDiscountStart(discountStart);
	d.setDiscountEnd(discountEnd);
	d.setDiscountRate(discountRate);
	
	
	// insertDiscountDao실행
	int row = dDao.insertDiscount(d);
	
	if(row > 0){
		System.out.println("할인적용완료");
		response.sendRedirect(request.getContextPath()+"/product/empProductList.jsp");
		return;
	}
	System.out.println("할인적용실패");
	response.sendRedirect(request.getContextPath()+"/product/empProductList.jsp");
	
%>