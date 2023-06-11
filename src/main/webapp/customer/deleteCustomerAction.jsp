<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") == null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
//요청값 디버깅
	System.out.println(request.getParameter("id")+"<-- deleteCustomerAction.jsp id");
	System.out.println(request.getParameter("id")+"<-- deleteCustomerAction.jsp id");
	System.out.println(request.getParameter("id")+"<-- deleteCustomerAction.jsp id");
	//메세지 출력 변수 선언
	String msg = "";
	//요청값 유효성 검사
	if(request.getParameter("id") == null 
		|| request.getParameter("pw") == null
		|| request.getParameter("checkPw") == null
		|| request.getParameter("id").equals("")
		|| request.getParameter("pw").equals("")
		|| request.getParameter("checkPw").equals("")){
		msg = URLEncoder.encode("모두입력해주시길 바랍니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/deleteCustomer.jsp?msg="+msg);
		return;
	}
	if(!request.getParameter("pw").equals(request.getParameter("checkPw"))){
		msg = URLEncoder.encode("두개의 비밀번호 서로 맞지 않으므로 다시 입력 바랍니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/deleteCustomer.jsp?msg="+msg);
		return;
	}
	//요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	//변수클래스에 저장
	IdList onePw = new IdList();
	onePw.setId(id);
	onePw.setPw(pw);
	// 비밀번호가 맞는 확인하는 메소드 선언하고 실행
	MemberDao ckPw = new MemberDao();
	int ckRow = ckPw.checkPw(onePw);
	// 실행값에 따라 분기 0이상이면 비밀번호 맞고 0이면 비밀번호가 틀립니다.
	if(ckRow == 0){
		msg = URLEncoder.encode("비밀번호가 맞지 않으므로 다시 입력 바랍니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/deleteCustomer.jsp?msg="+msg);
		return;
	}
	// 삭제 메소드 선언
	MemberDao deleteCstm = new MemberDao();
	int row = deleteCstm.deleteCustomer(id);
	
	if(row > 0){
		
		session.invalidate(); // 기존 갖고있던 모든 세션을 지우고 갱신!
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}else if(row == 0){
		msg = URLEncoder.encode("회원탈퇴에 문제가 생겼으므로 고객센터에 문의 바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
		return;
	}
%>