<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");



	if(request.getParameter("id")==null
		|| request.getParameter("id").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cart/cartOrder.jsp");
		return;
	}
	String id = request.getParameter("id");
	System.out.println(id + " <-- insertAddress id");
	
	


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
</script>
</head>
<body>
<h1>주소 추가</h1>
	<form action="<%=request.getContextPath()%>/cart/insertAddressAction.jsp">
	 	<input type="hidden" name="id" value="<%=id%>">
	 	<table>
	        <tr>
	            <th>주소 이름</th>
	            <td>    	
	            	<input type="radio" name="addressName" value="자택" required="required">자택
	            	<input type="radio" name="addressName" value="직장" required="required">직장
	            </td>
	        </tr>
	        <tr>
	            <th>주소</th>
	           <td><input type="text" id="address_kakao" name="address" required="required"></td>
	        </tr>      
	        <tr>
	        	<td>
	    			<input type="submit" value="추가하기">
	        	</td>
	        </tr>
	    </table>
	</form>
</body>
</html>