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
	String id = request.getParameter("id");
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
	if(request.getParameter("row") == null){
%>
	<form action="<%=request.getContextPath()%>/customer/findPwAction.jsp" method="post">
		아이디<input type="text" name="id" placeholder="아이디" required="required" class="single-input"><br>
	
		이름<input type="text" name="cstmName" required="required" class="single-input"><br>
		
		생년월일 : <br><input type="date" name="cstmBirth" ><br>

		전화번호<input type="tel"  name="cstmPhone" required="required" class="single-input"><br>
						
		태어난 동네<input type="text" name="cstmQuestion" required="required" class="single-input"><br>
		
		<button type="submit" class="genric-btn primary-border circle">비밀번호 찾기</button>
	</form>
<%
	} else if(request.getParameter("row") != null){
%>	
	<form action="<%=request.getContextPath()%>/customer/setPasswordAction.jsp" method="post">
	<input type="hidden" name = "id" value="<%=id%>">
	새로운 비밀번호 입력 <input type="password" name="pw" placeholder="비밀번호" required="required" class="single-input"><br>

	비밀번호 재확인<input type="password" name="checkPw" placeholder="비밀번호 재확인" required="required" class="single-input"><br>
	<button type="submit" class="genric-btn primary-border circle">비밀번호 변경하기</button>
	</form>
<%
	}
%>
</body>
</html>