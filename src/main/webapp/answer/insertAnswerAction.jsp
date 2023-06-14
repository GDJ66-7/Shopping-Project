<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");

	//로그인 세션 검사 추가

	// 객체 저장 & 생성
	AnswerDao answerDao = new AnswerDao();
	
	// 받은 값 저장 test admin
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	String id = "admin"; /*request.getParameter("id");*/
	String aContent = request.getParameter("aContent");
	
	System.out.println(qNo+"<----qn");
	System.out.println(id+"<----id");
	System.out.println(aContent+"<----a content");
	
	// vo 입력 받은 값으로 객체 생성
	Answer answer = new Answer();
	
	answer.setqNo(qNo);
	answer.setId(id);
	answer.setaContent(aContent);
	
	int row = answerDao.insertAnswer(answer);
	if(row == 1 ){
		System.out.println("답변 추가 성공");
		//답변 추가 성공시 해당 문의 게시글로 이동
		response.sendRedirect(request.getContextPath()+"/question/questionOne.jsp?qNo="+qNo+"&productNo="+productNo);
	}
	
	
	
%>