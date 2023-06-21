<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("id") == null
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address_kakao").value = data.address; // 주소 넣기
            }
        }).open();
    });
}
</script>
</head>
<body>
<!-- breadcrumb part start-->
    <section class="breadcrumb_part" style="height: 100px;">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>주소 추가</h2>
                    </div>
                </div>
            </div>
        </div>
	</section>
    <!-- breadcrumb part end-->
<br>
<br>
    <div style="text-align: center;">
	<form action="<%=request.getContextPath()%>/cart/insertAddressAction.jsp" method="post">
	 	<input type="hidden" name="id" value="<%=id%>">
	 	<table class="table table-borderless">
	        <tr>
	            <th>주소 이름</th>
	            <td style="accent-color:#B08EAD;">    	
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
	    			<input class="btn_1" type="submit" value="추가하기" style="width:100px; height:40px;  padding: 0; line-height: 20px;">
	        	</td>
	        </tr>
	    </table>
	</form>
    </div>
</body>
</html>