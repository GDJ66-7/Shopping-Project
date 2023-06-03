<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//세션 확인 관리자만 들어올 수 있도록
if(session.getAttribute("loginCstmId") != null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
String id = (String)(session.getAttribute("loginEmpId2"));
if(session.getAttribute("loginEmpId1") != null)
id = (String)(session.getAttribute("loginEmpId1"));
	//관리자 마이 페이지 메소드
	AdminDao my = new AdminDao();
	ArrayList<HashMap<String, Object>> list = my.selectEmpList(id);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>관리자 마이페이지</h1>
<%
	for(HashMap<String,Object> s : list){
%>
	<table>
		<tr>
			<td>사원이름</td>
			<td><%=(String)(s.get("사원이름"))%></td>
		</tr>
		<tr>
			<td>사원등급</td>
			<td><%=(String)(s.get("사원등급"))%></td>
		</tr>
		<tr>
			<td>가입일</td>
			<td><%=(String)(s.get("가입일"))%></td>
		</tr>
		<tr>
			<td>수정일</td>
			<td><%=(String)(s.get("수정일"))%></td>
		</tr>
	</table>
<%
	}
%>
</body>
</html>