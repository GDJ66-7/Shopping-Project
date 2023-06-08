<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("id")==null
		|| request.getParameter("point")==null
		|| request.getParameter("usePoint")==null
		|| request.getParameter("id").equals("")
		|| request.getParameter("point").equals("")
		|| request.getParameter("usePoint").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cart/cartOrder.jsp");
		return;	
	}
	
	String id = request.getParameter("id");
	int point = Integer.parseInt(request.getParameter("point"));
	int usePoint = Integer.parseInt(request.getParameter("usePoint"));
	System.out.println(id + " <-- updatePoint id");
	System.out.println(point + " <-- updatePoint point");
	System.out.println(usePoint + " <-- updatePoint usePoint");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<h1>포인트 사용</h1>
	<form action="<%=request.getContextPath()%>/cart/cartOrder.jsp">
		<table>
		<tr>
			<th>사용할 포인트</th>
			<td>
				<input type="number" name="inputPoint" min="1" max="<%=point%>">
			</td>	
		</tr>
		<tr>
			<td>
				<input type="submit" value="포인트 사용하기">
			</td>
		</tr>
	
	
	
	
	
		</table>
	</form>

</html>