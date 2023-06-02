<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");

	//작성자 유효성 검사 추가하기
	
	//요청값 변수 저장
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	
	//문의 사항 요청값 유효성 검사(+수정시에도 공백X)
	if(request.getParameter("qNo") == null
	||request.getParameter("qNo").equals("")
	||request.getParameter("qCategory") == null
	||request.getParameter("qCategory").equals("")
	||request.getParameter("qTitle") == null
	||request.getParameter("qTitle").equals("")
	||request.getParameter("qContent") == null
	||request.getParameter("qContent").equals("")){
		response.sendRedirect(request.getContextPath()+"/");
		return;
	}
	
	String qCategory = request.getParameter("qCategory");
	String qTitle = request.getParameter("qTitle");
	String qContent = request.getParameter("qContent");
	
	// 객체 생성
	QuestionDao qDao = new QuestionDao();
	
	// 객체 생성 요청값 저장
	Question question = new Question();
	question.setqNo(qNo);
	question.setqCategory(qCategory);
	question.setqTitle(qTitle);
	question.setqContent(qContent);
	
	// 문의 수정 메서드
	int row = qDao.updateQuestion(question);
	
	if(row == 1 ){
		System.out.println("문의 수정 성공");
	}
	
	response.sendRedirect(request.getContextPath()+"/");
	
%>