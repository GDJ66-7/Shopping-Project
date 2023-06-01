<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//새션 확인 로그인 되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") != null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shopping login</title>
</head>
<body>
	<h1>로그인</h1>
	<form action="<%=request.getContextPath()%>/login/loginAction.jsp" method="get">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type=text name=id value="아이디를 입력해주세요"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type=password name=pw value="비밀번호를 입력해주세요"></td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
</body>
</html>