<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/category/insertCategoryAction.jsp">
		<table>
			<tr>
				<td>카테고리 이름</td>
				<td><input type="text" name="categoryName"></td>
			</tr>
		</table>
		<button type="submit">카테고리 추가</button>
	</form>
</body>
</html>