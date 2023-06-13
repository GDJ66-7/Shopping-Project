<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
    window.Kakao.init("a320da1aa352f85bd85f13b3b4e82212");

    function kakaoLogin() {
        window.Kakao.Auth.login({
            scope: 'account_email, gender, age_range, birthday',
            success: function(authObj) {
                console.log(authObj)
                window.Kakao.API.request({
                    url: '/v2/user/me',
                    success: function(res) {
                        const kakao_account = res.kakao_account;
                        console.log(kakao_account);
                        let id = kakao_account.email;
                        console.log(id);
                        $('#userId').val(kakao_account.email)
                    }
                });
            }
        });
    }
</script>
</head>
<body>
<p>
	<%
       	if(request.getParameter("msg") != null){
    %>
       		<%=request.getParameter("msg") %>
    <% 
       	}
	%>		
</p>
<button onclick="kakaoLogin()">카카오톡 로그인</button>
<p>카카오톡 로그인 한 후 로그인을 눌러주시길 바랍니다.</p>
<form action="<%=request.getContextPath()%>/login/kakao_LoginAction.jsp" method="post">
	<input type="text" id="userId" readonly name="id">
	<button type="submit">로그인</button>
</form>
<h1 id="userId"></h1>
</body>
</html>
