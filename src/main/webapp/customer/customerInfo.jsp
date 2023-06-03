<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//새션 확인 관리자아이디러 로그인 되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null){
		response.sendRedirect(request.getContextPath()+"/employee/employeeInfo.jsp");
		return;
	}
	//세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginCstmId"));
	//세션아이디 디버깅
	System.out.println(id+"<-- id");	
	//고객 정도 리스트 메소드 선언
	MemberDao li = new MemberDao();
	ArrayList<HashMap<String, Object>> list = li.selectCstmList(id);
	System.out.println(list+"<-- list");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>마이페이지</h1>
	<h1>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</h1>
	<%
		if(id == null){
	%>
		<h1>로그인 해주시길 바랍니다.</h1>
	<%
		}
	%>
	<%
		if(id != null){
			for(HashMap<String, Object> s : list){
	%>
		<table>
			<tr>
				<td>이름</td>
				<td><%=(String)(s.get("고객이름"))%></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><%=(String)(s.get("고객주소"))%></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><%=(String)(s.get("고객이메일"))%></td>
			</tr>
			<tr>
				<td>생일</td>
				<td><%=(String)(s.get("고객생일"))%></td>
			</tr>
			<tr>
				<td>등급</td>
				<td><%=(String)(s.get("고객등급"))%></td>
			</tr>
			<tr>
				<td>포인트</td>
				<td><%=(Integer)(s.get("고객포인트"))%></td>
			</tr>
			<tr>
				<td>가입일</td>
				<td><%=(String)(s.get("가입일"))%></td>
			</tr>
		</table>
	<% 			
			}
		}
	%>
</body>
</html>