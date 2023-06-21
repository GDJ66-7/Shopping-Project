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
	<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>pillloMart</title>
    <link rel="icon" href="<%=request.getContextPath()%>/css/img/favicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/owl.carousel.min.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/all.css">
    <!-- icon CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/flaticon.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/themify-icons.css">
    <!-- magnific popup CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/nice-select.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/style.css">
</head>
<body>
	<!-- breadcrumb part start-->
    <section class="breadcrumb_part">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>포인트 사용</h2>
                    </div>
                </div>
            </div>
        </div>
	</section>
    <!-- breadcrumb part end-->
    <br>
<div class="container">
	<form action="<%=request.getContextPath()%>/cart/cartOrder.jsp" method="post">
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
					<input type="submit" value="포인트 사용하기">
				</td>
			</tr>
		</table>		
	</form>
</div>
</body>
</html>