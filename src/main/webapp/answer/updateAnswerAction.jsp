<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");

	// 작성자 유효성 검사 추가하기
	
	// 요청값 변수 저장
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	//System.out.println(aNo + "<----updateanswer aNo");

	// 받아온 값 저장
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	String id = "admin";/*request.getParameter("id");*/
	String aContent = request.getParameter("aContent");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	System.out.println(aNo+"<---update answer aNo");
	System.out.println(qNo+"<---update answer qNo");
	System.out.println(id+"<---update answer id");
	System.out.println(aContent+"<---update answer con");

	// 객체 생성
	AnswerDao answerDao = new AnswerDao();
	
	// 객체 생성 요청값 저장
	Answer answer = new Answer();
	answer.setaNo(aNo);
	answer.setqNo(qNo);
	answer.setId(id);
	answer.setaContent(aContent);
	
	// 문의 수정 메서드
	int row = answerDao.updateAnswer(aNo,aContent);
	
	if(row == 1 ){
		System.out.println("답변 수정 성공");
	}
	response.sendRedirect(request.getContextPath()+"/question/questionOne.jsp?qNo="+qNo+"&productNo="+productNo);
	
%>