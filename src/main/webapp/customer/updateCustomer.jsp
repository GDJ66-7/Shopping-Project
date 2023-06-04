<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
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
<h1>개인정보 수정</h1>
	<h1>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</h1>
	<form action="<%=request.getContextPath()%>/customer/updateCustomerAction.jsp" method="get">
		<table>	
			<tr>
				<td>
					<input type="hidden" name="id" value="<%=id%>"><!-- 세션값아이디 히든으로 넘기기 -->
				</td>
			</tr>
			<tr>
				<td>주소 :</td>
					<td>
						<textarea name ="cstmAddress" cols ="33" rows="5" placeholder="주소입력"></textarea>
					</td>
				</tr>	
				<tr>
					<td>이메일 :</td>
					<td>
						<input type="email" id="email" name="cstmEmail">
					</td>
				</tr>
				<tr>
					<td>전화번호 :</td>
					<td>
						<input type="tel"  name="cstmPhone">
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인:</td>
				<td>
					<input type="password" name="pw" placeholder="비밀번호">
				</td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>
</body>
</html>