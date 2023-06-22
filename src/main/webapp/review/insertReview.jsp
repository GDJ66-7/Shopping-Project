<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");

	//로그인 유효성 검사
	if(session.getAttribute("loginCstmId") == null) {
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}
	
	//요청값 유효성 검사
	if(request.getParameter("productNo") == null  
	|| request.getParameter("productNo").equals("")
	|| request.getParameter("historyNo") == null
	|| request.getParameter("historyNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
		return;
	}
	
	String id = (String)session.getAttribute("loginCstmId");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int historyNo = Integer.parseInt(request.getParameter("historyNo"));
	
	System.out.println(productNo+"<---productNo review");
	System.out.println(historyNo+"<---historyNo review");

%>
<!DOCTYPE html>
<html lang="zxx">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>문의사항 상세보기</title>
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
</head>
<body>
    <!--::header part start::-->
	<header>
	<jsp:include page="/main/menuBar.jsp"></jsp:include>
	</header>
	<!-- Header part end-->
<br>
<h2 style="text-align: center;">상품 리뷰 작성</h2>
<div class="container mt-3">
<form id="insertReview" action="<%=request.getContextPath()%>/review/insertReviewAction.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="historyNo" value="<%=historyNo%>">
<input type="hidden" name="productNo" value="<%=productNo%>">
<input type="hidden" name="id" value="<%=id%>">
<!--* 마이페이지 리뷰 작성-->
	<%
		if(request.getParameter("msg") != null){
	%>
		<div style="font-size: 10pt;"><%=request.getParameter("msg")%></div>
	<%
		}
	%>
	<table class="table table-bordered">
		<tr>
			<td>제목</td>
			<td><input type="text" name="reviewTitle" size=60; placeholder="제목을 입력해주세요(50자 이내)"></td>	
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea rows="5" cols="80" name="reviewContent" id="reviewContent" placeholder="내용을 입력하세요(최대500자)" style="resize: none;"></textarea>
			<br><span id="count"><em>0</em></span><em>/500</em>
			</td>	
		</tr>
		<tr>
			<td>사진 업로드</td>
			<td><input type="file" name="reviewImg" accept="image/jpeg, image/jpg"></td>
		</tr>
	</table>
	<div>
		<button type="submit" class="genric-btn primary radius" style="font-size: 13px;" onclick="insertReview()">작성</button>
		<a href="<%=request.getContextPath()%>/order/customerOrderHistory.jsp"  class="genric-btn primary-border radius" style="font-size: 13px;">취소</a>
	</div>
</form>
</div>
<br><br><br>
<script>
$(document).ready(function(){
	var $reviewContent = $('textarea[name="reviewContent"]');
	const MAX_COUNT = 500; // const 상수선언 사용하는 키워드(자바의 final과 유사함:변경될 수 없는 값)
	$('#reviewContent').keyup(function(){ // 키보드를 눌렀다 떼면
		let len = $('#reviewContent').val().length; // textarea === val 값으로 불러옴
		if(len > MAX_COUNT) { // 길이가 500보다 커지면 0부터 500까지 잘라 보여줌(0부터니까 501자에서 멈추고 자름)
			let str = $('#reviewContent').val().substring(0,MAX_COUNT);
		$('#reviewContent').val(str);
		alert(MAX_COUNT+'자까지만 입력 가능합니다')
		} else {
			$('#count').text(len); // 현재 입력된 글자수 출력
		}
	  });
});

function insertReview() {
	let form = document.getElementById("insertReview");
	if (form.reviewTitle.value.trim() === '') { // 공백 제거 후 비교
		alert('제목을 입력해주세요');
		form.reviewTitle.focus();
		event.preventDefault();
		return;
	}
	if (form.reviewContent.value.trim() === '') {
		alert('내용을 입력해주세요');
		form.reviewContent.focus();
		event.preventDefault();
		return;
	}
	if (form.reviewImg.value.trim() === '') {
		alert('사진을 등록해주세요');
		form.reviewImg.focus();
		event.preventDefault();
		return;
	} // input file 유효성 검사 자바스크립트 방법도 시도해보기
	
	let result = confirm("리뷰를 등록하시겠습니까?");
	  if (result) {
		  document.getElementById("insertReview").submit();
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