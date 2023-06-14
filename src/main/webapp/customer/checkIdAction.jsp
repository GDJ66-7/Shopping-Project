<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	System.out.println(request.getParameter("id")+"<--- 아이디중복확인");
	String id = request.getParameter("id");
	String msg = "";
	MemberDao ii = new MemberDao();
	int row = ii.checkId(id);
	if(row > 0){
		msg = URLEncoder.encode("이미 있는 아이디입니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/insertCustomer.jsp?msg="+msg);
		return;
	} else if(row == 0){
		msg = URLEncoder.encode("사용가능한 아이디입니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/insertCustomer.jsp?useId="+id+"&msg="+msg);
		return;
	}
	
%>
