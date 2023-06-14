<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");

	//작성자 유효성 검사 추가하기
	
	//요청값 변수 저장
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	//System.out.println(qNo + "<----updateQuestionAction NO");
	
	//문의 사항 요청값 유효성 검사(+수정시에도 공백X)
	if(request.getParameter("qNo") == null
	||request.getParameter("qNo").equals("")
	||request.getParameter("qCategory") == null
	||request.getParameter("qCategory").equals("")
	||request.getParameter("qTitle") == null
	||request.getParameter("qTitle").equals("")
	||request.getParameter("qContent") == null
	||request.getParameter("qContent").equals("")){
		response.sendRedirect(request.getContextPath()+"/question/questionOne.jsp?qNo=" +qNo);
		return;
	}
	
	// 받아온 값 저장
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String qCategory = request.getParameter("qCategory");
	String qTitle = request.getParameter("qTitle");
	String qContent = request.getParameter("qContent");
	//String Id = (String)session.getAttribute("Id"); -- 세션 검사 해야함
	//System.out.println(Id);
	
	System.out.println(qCategory+"<---updateQ category");
	System.out.println(qTitle+"<---updateQ title");
	System.out.println(qContent+"<---updateQ content");
	
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
	
	response.sendRedirect(request.getContextPath()+"/question/questionOne.jsp?qNo="+qNo+"&productNo="+productNo); // 수정 완료시 폼으로
	
%>