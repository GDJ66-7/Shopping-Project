<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%

	if(request.getParameter("productNo") == null  
	|| request.getParameter("productNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp");
		return;
	}
	
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String productName = request.getParameter("productName");
	
	//로그인 세션(로그인 한 고객만(loginCstmId 작성 가능)
	if(session.getAttribute("loginCstmId") == null) {
		response.sendRedirect(request.getContextPath()+"/login/login.jsp");
		return;
	}
	String id= (String)session.getAttribute("loginCstmId");
	System.out.println(id+"<---insertQuestion id");

%>
<!-- 문의 : 회원만 작성 가능 -->
<!DOCTYPE html>
<html lang="zxx">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>문의사항 추가하기</title>
    <link rel="icon" href="<%=request.getContextPath()%>/css/img/favicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/owl.carousel.min.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/all.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/flaticon.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/themify-icons.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/magnific-popup.css">
    <!-- swiper CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/slick.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/style.css">
   	<!-- nice select CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/nice-select.css">
<!-- script 선언 head 안으로 -->
<script>
	$(document).ready(function(){
		const MAX_COUNT = 500;
		$('#qContent').keyup(function(){ 
			let len = $('#qContent').val().length;
			if(len > MAX_COUNT) {
				let str = $('#qContent').val().substring(0,MAX_COUNT);
			$('#qContent').val(str);
			alert('내용은'+MAX_COUNT+'자까지만 입력 가능합니다')
			} else {
				$('#count').text(len); // 현재 입력된 글자수 출력
			}
		});
		
		const TMAX_COUNT = 50;
		$('#qTitle').keyup(function(){ 
			let len2 = $('#qTitle').val().length;
			if(len2 > TMAX_COUNT) {
				let str2 = $('#qTitle').val().substring(0,TMAX_COUNT);
			$('#qTitle').val(str2);
			alert('제목은'+TMAX_COUNT+'자까지만 입력 가능합니다')
			} 
		});
	});
</script>
</head>
<body>
	<!--::header part start::-->
	<header>
	<jsp:include page="/main/menuBar.jsp"></jsp:include>
	</header>
	<!-- Header part end-->
<br>
<h2 style="text-align: center;">상품 문의</h2>
<div class="container mt-3">
<form id="insertQuestion" action="<%=request.getContextPath()%>/question/insertQuestionAction.jsp" method="post">
<input type="hidden" name="productNo" value="<%=productNo%>">
<input type="hidden" name="id" value="<%=id%>">
<table class="table table-bordered">
	<tr>
		<td>상품이름</td>
		<td><%=productName%></td>
	</tr>
	<tr>
		<td>
			<label for="qCategory">카테고리</label>
		</td>
		<td>
			<select name="qCategory">
			<option value="배송">배송</option>
			<option value="상품">상품</option>
			<option value="기타">기타</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="qTitle" id="qTitle" size=60; placeholder="제목을 입력하세요(50자 이내)"></td>	
	</tr>
	<tr>
		<td>내용</td>
		<td>
		<textarea rows="5" cols="80" name="qContent" id="qContent" placeholder="내용을 입력하세요(최대500자)" style="resize: none;"></textarea>
		<br><span id="count"><em>0</em></span><em>/500</em>
		</td>
	</tr>
</table>
	<div>
		<button type="submit" class="genric-btn primary radius" style="font-size: 13px;" onclick="insertQuestion()">추가</button>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>" class="genric-btn primary-border radius" style="font-size: 13px;">취소</a>
	</div>
	<br><br>
</form>
</div>
<script>
function insertQuestion() {
	let form = document.getElementById("insertQuestion");
	if (form.qTitle.value.trim() === '') { // 공백 제거 후 비교
		alert('제목을 입력해주세요');
		form.qTitle.focus();
		event.preventDefault();
		return;
	}
	if (form.qContent.value.trim() === '') {
		alert('내용을 입력해주세요');
		form.qContent.focus();
		event.preventDefault();
		return;
	}
	
	let result = confirm("등록하시겠습니까?");
	  if (result) {
		  document.getElementById("insertQuestion").submit();
		  alert("게시글 등록이 완료되었습니다.");
	  }else{
		  event.preventDefault();
		    return;
	}
}
</script>

  <!--::footer_part start::-->
  <footer class="footer_part">
        <div class="footer_iner section_bg">
            <div class="container">
                <div class="row justify-content-between align-items-center">
                    <div class="col-lg-8">
                        <div class="footer_menu">
                            <div class="footer_logo">
                                <a href="index.html"><img src="/Shopping/css/img/logo.png" alt="#"></a>
                            </div>
                            <div class="footer_menu_item">
                                <a href="<%=request.getContextPath()%>/main/home.jsp">Home</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="social_icon">
                            <a href="#"><i class="fab fa-facebook-f"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-google-plus-g"></i></a>
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="copyright_part">
            <div class="container">
                <div class="row ">
                    <div class="col-lg-12">
                        <div class="copyright_text">
                            <P><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
shopping &copy;<script>document.write(new Date().getFullYear());</script> 저희 ** 쇼핑몰은 고객과 소통하면서 만들어갑니다.<i class="ti-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">GDJ66</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></P>
                            <div class="copyright_link">
                                <a href="#">Turms & Conditions</a>
                                <a href="#">FAQ</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!--::footer_part end::-->

    <!-- jquery plugins here-->
    <script src="<%=request.getContextPath()%>/css/js/jquery-1.12.1.min.js"></script>
    <!-- popper js -->
    <script src="<%=request.getContextPath()%>/css/js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="<%=request.getContextPath()%>/css/js/bootstrap.min.js"></script>
    <!-- easing js -->
    <script src="<%=request.getContextPath()%>/css/js/jquery.magnific-popup.js"></script>
    <!-- swiper js -->
    <script src="<%=request.getContextPath()%>/css/js/swiper.min.js"></script>
    <!-- swiper js -->
    <script src="<%=request.getContextPath()%>/css/js/mixitup.min.js"></script>
    <!-- particles js -->
    <script src="<%=request.getContextPath()%>/css/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath()%>/css/js/jquery.nice-select.min.js"></script>
    <!-- slick js -->
    <script src="<%=request.getContextPath()%>/css/js/slick.min.js"></script>
    <script src="<%=request.getContextPath()%>/css/js/jquery.counterup.min.js"></script>
    <script src="<%=request.getContextPath()%>/css/js/waypoints.min.js"></script>
    <script src="<%=request.getContextPath()%>/css/js/contact.js"></script>
    <script src="<%=request.getContextPath()%>/css/js/jquery.ajaxchimp.min.js"></script>
    <script src="<%=request.getContextPath()%>/css/js/jquery.form.js"></script>
    <script src="<%=request.getContextPath()%>/css/js/jquery.validate.min.js"></script>
    <script src="<%=request.getContextPath()%>/css/js/mail-script.js"></script>
    <!-- custom js -->
    <script src="<%=request.getContextPath()%>/css/js/custom.js"></script>
</body>
</html>