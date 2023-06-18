<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//요청값 변수 저장
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String id = (String)session.getAttribute("loginCstmId");
	
	/*if(request.getParameter("qNo") == null
	|| request.getParameter("qNo").equals("")
	|| request.getParameter("loginCstmId")==null
	|| request.getParameter("loginCstmId").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}*/
	
	//객체 생성
	QuestionDao qDao = new QuestionDao();
	
	//문의 삭제 메서드
	int row = qDao.deleteQuestion(qNo);
	
	if(row ==1 ){
		System.out.println("삭제완료");
	}
	
	response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productNo="+productNo);
%>