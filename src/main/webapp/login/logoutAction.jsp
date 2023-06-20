<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 기존 갖고있던 모든 세션을 지우고 갱신!
	out.println("<script>alert('로그아웃되었습니다.'); location.href='"+request.getContextPath() + "/main/home.jsp';</script>");
%>