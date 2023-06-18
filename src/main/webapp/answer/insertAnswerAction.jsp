<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");

	//세션 로그인 유효성 검사(관리자)
	if(session.getAttribute("loginEmpId1") == null && session.getAttribute("loginEmpId2") == null){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}
	
	//문의사항 게시글 유효성 확인
	if(request.getParameter("qNo") == null
	|| request.getParameter("qNo").equals("")){	
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}
	
	// 객체 저장 & 생성
	AnswerDao answerDao = new AnswerDao();
	
	// 받은 값 저장 test admin
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	String id = request.getParameter("id");
	String aContent = request.getParameter("aContent");
	
	System.out.println(qNo+"<----insertAnswer Action qNo");
	System.out.println(id+"<----insertAnswer Action id(empid)");
	System.out.println(aContent+"<----inswerAnswer Action a content");
	
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