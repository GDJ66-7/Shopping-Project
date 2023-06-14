<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
	
	/* 어느 게시글의 댓글& 어떤 댓글을 삭제 했는 지 알기 위함(유효성검사)
	if(request.getParameter("qNo") == null
	|| request.getParameter("qNo").equals("")
	|| request.getParameter("aNo") == null
	|| request.getParameter("aNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}*/
	// 요청값 변수 저장
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	// 객체 생성
	AnswerDao answerDao = new AnswerDao();
	
	// 답변 삭제 메서드
	int row = answerDao.deleteAnswer(aNo); 
	if(row ==1 ){
		System.out.println("삭제완료");
	}
	response.sendRedirect(request.getContextPath() + "/question/questionOne.jsp?qNo="+qNo+"&productNo="+productNo);

%>