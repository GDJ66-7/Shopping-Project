<%@page import="javax.print.attribute.HashPrintRequestAttributeSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8"); //post - action - request.encoding
	
	//로그인 세션 검사 추가
	
	// 객체 저장 & 생성
	QuestionDao qDao = new QuestionDao();
	
	// 받은 값 저장
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String id = request.getParameter("id");
	String qCategory = request.getParameter("qCategory");
	String qTitle = request.getParameter("qTitle");
	String qContent = request.getParameter("qContent");
	
	System.out.println(productNo+"<----pn");
	System.out.println(id+"<----id");
	System.out.println(qCategory+"<----ca");
	System.out.println(qTitle+"<----title");
	System.out.println(qContent+"<----cont");
	
	// vo 저장 생성
	Question question = new Question();
	
	question.setProductNo(productNo);
	question.setId(id);
	question.setqCategory(qCategory);
	question.setqTitle(qTitle);
	question.setqContent(qContent);
	
	int row = qDao.insertQuestion(question);
	if(row ==1 ){
		System.out.println("문의 추가 성공");
	}
	response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productNo="+productNo);
	
	
%>