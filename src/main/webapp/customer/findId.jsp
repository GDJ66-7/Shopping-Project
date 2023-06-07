<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//입력값 한글 깨지지 않기 위해 인코딩
	request.setCharacterEncoding("utf-8");
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
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
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
	if(request.getParameter("fId") == null){
%>
	<form action="<%=request.getContextPath()%>/customer/findIdAction.jsp" method="post">
		이름<input type="text" name="cstmName" required="required" class="single-input"><br>
		
		생년월일 : <br><input type="date" name="cstmBirth" ><br>

		전화번호<input type="tel"  name="cstmPhone" required="required" class="single-input"><br>
						
		태어난 동네<input type="text" name="cstmQuestion" required="required" class="single-input"><br>
		
		<button type="submit" class="genric-btn primary-border circle">아이디 찾기</button>
	</form>
<%
	} else if(request.getParameter("fId") != null){
%>	
	아이디 <input type="text" value="<%=request.getParameter("fId")%>" class="single-input"><br>
<%
	}
%>
</body>
</html>