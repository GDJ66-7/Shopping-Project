<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
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
		System.out.println(request.getParameter("id")+"<-- updatePasswordAction.jsp id");
		System.out.println(request.getParameter("onePw")+"<-- updatePasswordAction.jsp onePw");
		System.out.println(request.getParameter("pw")+"<-- updatePasswordAction.jsp pw");
		System.out.println(request.getParameter("checkPw")+"<-- updatePasswordAction.jsp checkPw");
	//메세지 출력 변수 선언
		String msg = "";
	//요청값 유효성 검사
		if(request.getParameter("id") == null 
		|| request.getParameter("onePw") == null
		|| request.getParameter("pw") == null
		|| request.getParameter("checkPw") == null
		|| request.getParameter("id").equals("")
		|| request.getParameter("onePw").equals("")
		|| request.getParameter("pw").equals("")
		|| request.getParameter("checkPw").equals("")){
			msg = URLEncoder.encode("모두입력해주시길 바랍니다.","utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
			return;
		}
	//비밀번호 확인 같은지 체크
			if(!request.getParameter("pw").equals(request.getParameter("checkPw"))){
				msg = URLEncoder.encode("비밀번호가 서로 다릅니다.","utf-8");
				response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
				return;
			}
	//요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String modiPw = request.getParameter("onePw");
	//비밀번호 확인에 필요한 클래스 선언
	IdList onePw = new IdList();
	onePw.setId(id);
	onePw.setPw(modiPw);
	
	// 비밀번호가 맞는 확인하는 메소드 선언하고 실행
			MemberDao checkPw = new MemberDao();
			int checkRow = checkPw.checkPw(onePw);
			// 실행값에 따라 분기 0이상이면 비밀번호 맞고 0이면 비밀번호가 틀립니다.
			if(checkRow == 0){
				msg = URLEncoder.encode("비밀번호가 맞지 않으므로 다시 입력 바랍니다.","utf-8");
				response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
				return;
			}
	//클래스 선언하고 변수 저장
	IdList idList = new IdList();
	idList.setId(id);
	idList.setPw(pw);
	
	//회원 비밀번호 변경시 이전에 사용한 비밀번호인지 체크 하는 메소드 사용
	MemberDao ckPw = new MemberDao();
	int ckRow = ckPw.checkPwList(idList);
	//chRow 가 0이상이면 이전 비밀번호이므로 if문으로 멈춘다
	if(ckRow > 0){
		msg = URLEncoder.encode("이전에 사용한 비밀번호이므로 다른 비밀번호를 사용하시길 바랍니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
		return;
	}
	//회원 비밀번호 를 변경하기 위해 메소드 사용
	MemberDao chPw = new MemberDao();
	int chRow = chPw.modifyIdList(idList);
	if(chRow > 0){
		msg = URLEncoder.encode("비밀번호가 변경이 완료되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
		return;
	} else if(chRow == 0){
		msg = URLEncoder.encode("문제가 생겨 변경할 수 없습니다. 고객센터에 문의 바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
		return;
	}
%>