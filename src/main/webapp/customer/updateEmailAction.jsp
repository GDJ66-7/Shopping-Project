<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//입력값 한글 깨지지 않기 위해 인코딩
	request.setCharacterEncoding("utf-8");
//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") == null){
		out.println("<script>alert('로그인 후 이용가능합니다'); location.href='"+request.getContextPath() + "/main/home.jsp';</script>");
		return;
	}
	//요청값 디버깅
	System.out.println(request.getParameter("id")+"<-- updateEmailAction.jsp id");
	System.out.println(request.getParameter("pw")+"<-- updateEmailAction.jsp pw");
	System.out.println(request.getParameter("cstmEmail")+"<-- updateEmailAction.jsp cstmEmail");
	//메세지 출력 변수 선언
	String msg = "";
	//요청값 유효성 검사
	if(request.getParameter("id") == null
			|| request.getParameter("pw") == null
			|| request.getParameter("cstmEmail") == null
			|| request.getParameter("id").equals("")
			|| request.getParameter("pw").equals("")
			|| request.getParameter("cstmEmail").equals("")){
		msg = URLEncoder.encode("모두입력해주시길 바랍니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
		return;
	}
	//요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String email = request.getParameter("cstmEmail");
	
	//비밀번호 확인에 필요한 클래스 선언
	IdList onePw = new IdList();
	onePw.setId(id);
	onePw.setPw(pw);
	
	// 비밀번호가 맞는 확인하는 메소드 선언하고 실행
	MemberDao checkPw = new MemberDao();
		int checkRow = checkPw.checkPw(onePw);
		// 실행값에 따라 분기 0이상이면 비밀번호 맞고 0이면 비밀번호가 틀립니다.
		if(checkRow == 0){
			msg = URLEncoder.encode("비밀번호가 맞지 않으므로 다시 입력 바랍니다.","utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
			return;
		}
	//수정 메서드 실행 선언
	MemberDao updateEmail = new MemberDao();
	int row = updateEmail.modifyEmail(email, id);
	
	if(row > 0){
		msg = URLEncoder.encode("수정이 완료되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
		return;
	} else if(row == 0){
		msg = URLEncoder.encode("수정 불가능합니다. 고객센터에 문의 바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
		return;
	}
%>

