<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");

	//작성자 유효성 검사 추가하기
	
	//
	if(request.getParameter("qNo") == null
	|| request.getParameter("qNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}
	
	//요청값 변수 저장
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	
	//객체 생성
	QuestionDao qDao = new QuestionDao();
	
	//문의 삭제 메서드
	int row = qDao.deleteQuestion(qNo);
	
	if(row ==1 ){
		System.out.println("삭제완료");
	}
	
	response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
%>