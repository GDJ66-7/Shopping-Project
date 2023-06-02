<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 회원만 가능 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 문의하기</title>
</head>
<body>
<h2>상품 문의</h2>
<table>
	<tr>
		<td>문의유형</td>
		<td>
		<select name="qCategory">
		<option value="bagic">===</option>
		<option value=""></option>
		</select>
		</td>	
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="qTitle"></td>	
	</tr>
	<tr>
		<td>내용</td>
		<td>
		<textarea rows="5" cols="80" name="qContent">
		</textarea>
		</td>
	</tr>
</table>
	<div>
		<button type=submit>추가</button>
		<a href="<%=request.getContextPath()%>">취소</a>
	</div>
</body>
</html>