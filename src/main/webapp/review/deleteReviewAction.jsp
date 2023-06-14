<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//작성자 유효성 검사 추가하기
	
	//
	if(request.getParameter("orderNo") == null
	|| request.getParameter("orderNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}
	
	//요청값 변수 저장
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	//객체 생성
	ReviewDao review = new ReviewDao();
	
	//리뷰 삭제 메서드
	int row = review.deleteReview(orderNo);
	
	if(row == 1 ){
		System.out.println("리뷰 삭제 완료되었습니다.");
	}
	//리뷰 삭제 완료시 해당 상품 상세페이지로
	response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productNo="+productNo);
%>