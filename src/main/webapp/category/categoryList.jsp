<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 카테고리를 수정및 추가 할 수 있는 카테고리 관리창.
	
	CategoryDao cDao = new CategoryDao();
	ArrayList<HashMap<String,Object>> cList = cDao.categoryNameList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th>카테고리 이름</th>
		</tr>
		<tr>
			
			<%
				for(HashMap<String, Object> cMap : cList) {
			%>
					<td>
						<%=cMap.get("categoryName") %>
						<a href=" <%=request.getContextPath() %>/category/updateCategory.jsp?categoryNo=<%=cMap.get("categoryNo")%>&categoryName=<%=cMap.get("categoryName")%>">수정하기</a>
					</td>
			<% 
				}
			%>			
		</tr>
	</table>
</body>
</html>