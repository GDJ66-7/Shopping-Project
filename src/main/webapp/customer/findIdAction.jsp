<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//입력값 한글 깨지지 않기 위해 인코딩
	request.setCharacterEncoding("utf-8");
String msg = "";
//새션 확인 로그인 되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") != null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
//요청값 디버깅
	System.out.println(request.getParameter("cstmName")+"<-- findIdAction.jsp cstmName");
	System.out.println(request.getParameter("cstmBirth")+"<-- findIdAction.jsp cstmBirth");
	System.out.println(request.getParameter("cstmPhone")+"<-- findIdAction.jsp cstmPhone");
	System.out.println(request.getParameter("cstmQuestion")+"<-- findIdAction.jsp cstmQuestion");
	//요청값 변수 선언
	String cstmName = request.getParameter("cstmName");
	String cstmBirth = request.getParameter("cstmBirth");
	String cstmPhone = request.getParameter("cstmPhone");
	String cstmQuestion = request.getParameter("cstmQuestion");
	//클래스안에 사용할 변수 세팅
	Customer customer = new Customer();
	customer.setCstmName(cstmName);
	customer.setCstmBirth(cstmBirth);
	customer.setCstmPhone(cstmPhone);
	customer.setCstmQuestion(cstmQuestion);
	//메서드 선언 
	MemberDao find = new MemberDao();
	String fId = find.fineId(customer);
	if(fId != null){
		msg = URLEncoder.encode("회원가입 되어있는 아이디가 있습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/findId.jsp?fId="+fId+"&msg="+msg);
		return;
	} else if(fId == null){
		msg = URLEncoder.encode("회원가입 되어있는 아이디가 없습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/findId.jsp?msg="+msg);
		return;
	}
%>