<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String useId = request.getParameter("useId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>중복체크</h1>
<p>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
</p>
<%
	if(useId == null){
%>
<form  action="<%=request.getContextPath()%>/customer/checkIdAction.jsp" method="get">
	<input type="text" name="id">
	<button type="submit">중복체크</button>
</form>
<%
	}
%>
<%
if(useId != null){
%>
<form id ="idCheck" action="<%=request.getContextPath()%>/customer/insertCustomer.jsp" method="get">
	<input type="text" name="useId" value="<%=useId%>" readonly="readonly">
	<button style="margin:10px;" class="btn btn-outline-secondary btn-block" type="submit" onclick="submitForm()">사용하기</button>
</form>
<%
	}
%>
<script>
   function submitForm() {
      // Form 데이터를 가져와서 새 창에 전송
      var form = document.getElementById('idCheck');
      form.target = 'newWindow'; // 새 창의 이름
      form.submit();
      
      // 원래 창으로 돌아가고 새로고침
       window.opener.location.reload();
      window.close();
   }
</script>
</body>
</html>