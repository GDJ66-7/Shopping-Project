<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("historyNo") == null
	|| request.getParameter("historyNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/review/reviewOne.jsp");
		return;
	}

	//요청값 변수 저장
	int historyNo = Integer.parseInt(request.getParameter("historyNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String id = (String)session.getAttribute("loginCstmId"); //현재 로그인한 아이디
	String writerId = request.getParameter("writerId"); // 삭제버튼에서 받아온 값 작성자 아이디
	
	//로그인 유효성 검사
	if(!id.equals(writerId)){
		System.out.println("리뷰 삭제에 실패하였습니다. 작성자와 로그인 아이디가 일치하지 않습니다.");
		response.sendRedirect(request.getContextPath()+"/review/reviewOne.jsp");
	}
	
	System.out.println(id+"<---deleteReview id");
	
	//객체 생성
	ReviewDao review = new ReviewDao();
	
	//리뷰 삭제 메서드
	int row = review.deleteReview(historyNo);
	
	if(row == 1 ){
		System.out.println("리뷰 삭제 완료되었습니다.");
	}
	//리뷰 삭제 완료시 해당 상품 상세페이지로
	response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productNo="+productNo);
%>