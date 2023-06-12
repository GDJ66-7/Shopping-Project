<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("id")==null
		|| request.getParameter("selectAddress")==null
		|| request.getParameter("point")==null
		|| request.getParameter("id").equals("")
		|| request.getParameter("selectAddress").equals("")		
		|| request.getParameter("point").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cart/cartOrder.jsp");
		return;	
	}
	
	String id = request.getParameter("id");
	int point = Integer.parseInt(request.getParameter("point"));
	String selectAddress = request.getParameter("selectAddress");
	
	System.out.println(id + " <-- updatePoint id");
	System.out.println(selectAddress + " <-- updatePoint selectAddress");
	System.out.println(point + " <-- updatePoint point");
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function submitForm() {
    	// Form 데이터를 가져와서 새 창에 전송
		var form = document.getElementById('pointForm');
    	form.target = 'newWindow'; // 새 창의 이름
    	form.submit();
    
		// 원래 창으로 돌아가고 새로고침
		window.opener.location.reload();
		window.close();
	}

</script>
</head>
<body>
	<h1>포인트 사용</h1>
	<form id="pointForm" action="<%=request.getContextPath()%>/cart/cartOrder.jsp">
		<input type="hidden" name="id" value="<%=id%>">
		<input type="hidden" name="selectAddress" value="<%=selectAddress%>">
		
		<table>
			<tr>
				<th>사용할 포인트</th>
				<td>
					<input type="number" name="inputPoint" min="0" max="<%=point%>" value="0" step="10" required="required">
				</td>	
			</tr>
			<tr>
				<td>
					<input type="submit" value="포인트 사용하기" onclick="submitForm()">
				</td>
			</tr>
		</table>		
	</form>
</body>
</html>