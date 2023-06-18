<%@page import="vo.Discount"%>
<%@page import="dao.DiscountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 유효성검사
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
	
	
	// DisocuntDao클래스 사용위한 객체 생성
	DiscountDao dDao = new DiscountDao();
	// update정보 vo에 입력
	Discount d = new Discount();
	d.setDiscountNo(discountNo);
	d.setDiscountStart(discountStart);
	d.setDiscountEnd(discountEnd);
	d.setDiscountRate(discountRate);
	
	int row = dDao.updateDiscount(d);
	
	String msg = "";
	if(row > 0){
		System.out.println("할인수정완료");
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp?updateDiscountMsg="+msg);
		return;
	}
	System.out.println("할인수정실패");
	response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp?updateDiscountMsg2="+msg);
%>
