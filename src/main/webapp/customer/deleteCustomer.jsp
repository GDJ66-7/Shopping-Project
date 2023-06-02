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
	<h1>회원 탈퇴</h1>
	<h2>회원탈퇴시 복구 불가능합니다. 신중하게 선택해주시길 바랍니다</h2>
	<h1>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</h1>
	<form>
		<table>
			<tr>
				<td>
					<input type="hidden" name="id" value="<%=id%>"><!-- 세션값아이디 히든으로 넘기기 -->
				</td>
			</tr>
			<tr>
				<td>비밀번호 :</td>
				<td>
					<input type="password" name="pw" placeholder="비밀번호">
				</td>
			</tr>
			<tr>
				<td>비밀번호 확인 :</td>
				<td>
					<input type="password" name="checkPw" placeholder="비밀번호 재확인">
				</td>
			</tr>
		</table>
		<button type="submit">탈퇴</button>
	</form>
</body>
</html>