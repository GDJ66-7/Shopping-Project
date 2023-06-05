<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<%
	//받아온 값 유효성 검사
	if(request.getParameter("checked")== null
		|| request.getParameter("id")== null
		|| request.getParameter("cartNo").equals("")
		|| request.getParameter("id").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}

	


%>