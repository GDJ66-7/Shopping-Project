<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//새션 확인 로그인 되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") != null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
//요청값 디버깅
	System.out.println(request.getParameter("id")+"<-- loginLoginAction.jsp id");

	//메세지 출력 변수 선언
		String msg = "";
		//요청값 유효성 검사
		if(request.getParameter("id") == null){
			msg = URLEncoder.encode("카카오톡 로그인을 먼저 해주시길바랍니다","utf-8");
			response.sendRedirect(request.getContextPath()+"/login/kakao_login.jsp?msg="+msg);
			return;
		}
		//요청값 변수에 저장
		String id = request.getParameter("id");
		
		//메서드 DAO선언
		MemberDao kaka = new MemberDao();
		int row = kaka.checkId(id);
		if(row > 0){
			session.setAttribute("loginCstmId", id);
			System.out.print("고객로그인 성공 새션정보 : " + session.getAttribute("loginCstmId"));
			%>
		      <script>
		         // 팝업 창 닫기
		         window.close();
		         
		         // 부모 창으로 이동
		         window.opener.location.href = '<%= request.getContextPath() %>/main/home.jsp';
		      </script>
		<%   
			return;
		} else if(row==0){
			msg = URLEncoder.encode("회원가입이 안된아이디 입니다.","utf-8");
			response.sendRedirect(request.getContextPath()+"/login/kakao_login.jsp?msg="+msg);
			return;
		}
		
%>
