<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>고객 회원가입</h1>
		<form action="<%=request.getContextPath()%>/customer/insertCustomerAction.jsp" method="get">
			<table>	
				<tr>
					<td>아이디 :</td>
					<td>
						<input type="text" name="id" placeholder="아이디">
					</td>
				</tr>
				<tr>
					<td>비밀번호 :</td>
					<td>
						<input type="password" name="pw" placeholder="비밀번호">
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인 :</td>
					<td>
						<input type="password" name="checkPw" placeholder="비밀번호 재확인">
					</td>
				</tr>
				<tr>
					<td>이름 :</td>
					<td>
						<input type="text" name="cstmName">
					</td>
				</tr>
				<tr>
					<td>주소 :</td>
					<td>
						<textarea name ="cstmAddress" cols ="33" rows="5" placeholder="주소입력"></textarea>
					</td>
				</tr>		
				<tr>
					<td>이메일 :</td>
					<td>
						<input type="email" id="email" name="cstmEmail">
					</td>
				</tr>
				<tr>
					<td>생년월일 :</td>
					<td>
						<input type="date" name="cstmBirth">
					</td>
				</tr>										
				<tr>
					<td>전화번호 :</td>
					<td>
						<input type="tel"  name="cstmPhone">
					</td>
				</tr>								
				<tr>
					<td>성별 :</td>
					<td>
						<input type="radio" name="cstmGender" value="남">
						<label for="남">남자</label><br>
						<input type="radio" name="cstmGender" value="여">
						<label for="여">여자</label>
					</td>
				</tr>	
				<tr>
					<td>개인정보 약관동의 :</td>
					<td>
						<input type="radio" name="cstmAgree" value="y">
						<label for="동의">동의</label><br>
						<input type="radio" name="cstmAgree" value="n">
						<label for="비동의">비동의</label>
					</td>
				</tr>	
			</table>
			<button type="submit">가입하기</button>
		</form>
</body>
</html>