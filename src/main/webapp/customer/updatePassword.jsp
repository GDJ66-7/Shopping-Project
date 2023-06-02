<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") == null 
		|| session.getAttribute("loginEmpId2") == null
		|| session.getAttribute("loginCstmId") == null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
String id = (String)(session.getAttribute("loginCstmId"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>비밀번호 변경</h1>
	<h1>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</h1>
	<form action="<%=request.getContextPath()%>/customer/updatePasswordAction.jsp" method="get">
		<table>
			<tr>
				<td>
					<input type="hidden" name="id" value="<%=id%>"><!-- 세션값아이디 히든으로 넘기기 -->
				</td>
			</tr>
			<tr>
				<td>원래 비밀번호 :</td>
				<td>
					<input type="password" name="onePw" placeholder="비밀번호">
				</td>
			</tr>
			<tr>
				<td>변경할 비밀번호 :</td>
				<td>
					<input type="password" name="pw" placeholder="비밀번호">
				</td>
			</tr>
			<tr>
				<td>변경할 비밀번호 재확인 :</td>
				<td>
					<input type="password" name="checkPw" placeholder="비밀번호 재확인">
				</td>
			</tr>
		</table>
		<button type="submit">변경</button>
	</form>
</body>
</html>