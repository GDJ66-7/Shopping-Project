<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	if(request.getParameter("historyNo") == null
	||request.getParameter("historyNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}

	// 로그인 세션 검사 -- 조회/수정/삭제
	String id = (String)session.getAttribute("loginCstmId");
	
	// 리뷰one에서 받은 값 저장 & 메서드 호출 --- 수정 전 데이터 불러오기라 reviewOne과 동일
	int historyNo = Integer.parseInt(request.getParameter("historyNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(historyNo+"<-----updateReview historyNo");
	System.out.println(productNo+"<-----updateReview productNo");
	
	// 리뷰 이미지와 글 출력 메서드
	ReviewDao review = new ReviewDao(); // DAO (동일)
	Review reviewText = review.selectReviewOne(historyNo); //vo
	ReviewImg reviewImg = review.selectReviewImg(historyNo); //vo
	System.out.println(reviewImg+"<---- review updateImg");
	
	// 작성자와 로그인 멤버가 일치하지 않을때 redirect
	if(id == null||!session.getAttribute("loginCstmId").equals(reviewText.getId())){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}
	
	System.out.println(id+"<---updateReview loginid");
	System.out.println(reviewText.getId()+"<---updateReview writer");

%>
<!DOCTYPE html>
<html lang="zxx">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>리뷰 수정하기</title>
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
    <header class="main_menu home_menu">
        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-lg-12">
                    <nav class="navbar navbar-expand-lg navbar-light">
                        <a class="navbar-brand" href="<%=request.getContextPath()%>/main/home.jsp"> <img src="<%=request.getContextPath()%>/css/img/logo.png" alt="logo"> </a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse"
                            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                            <span class="menu_icon"><i class="fas fa-bars"></i></span>
                        </button>
                        <!---- 메인메뉴 바 ---->
                        <div>
							<jsp:include page="/main/menuBar.jsp"></jsp:include>
						</div>
                        <div class="hearer_icon d-flex align-items-center">
                            <a id="search_1" href="javascript:void(0)"><i class="ti-search"></i></a>
                             <a href="<%=request.getContextPath()%>/cart/cartList.jsp">
                                <i class="flaticon-shopping-cart-black-shape"></i>
                            </a>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
        <div class="search_input" id="search_input_box">
            <div class="container ">
                <form class="d-flex justify-content-between search-inner">
                    <input type="text" class="form-control" id="search_input" placeholder="Search Here">
                    <button type="submit" class="btn"></button>
                    <span class="ti-close" id="close_search" title="Close Search"></span>
                </form>
            </div>
        </div>
    </header>
   	<!-- Header part end-->
<br>
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">상품 리뷰 수정하기</h2>
<form id="updateReview" action="<%=request.getContextPath()%>/review/updateReviewAction.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="productNo" value="<%=productNo%>">
<input type="hidden" name="historyNo" value="<%=historyNo%>">	
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
				<td>
				<input type="text" name="reviewTitle" value="<%=reviewText.getReviewTitle()%>" size=60; placeholder="제목을 입력해주세요(50자 이내)">
				</td>
			</tr>
			<tr>
				<td>사진</td>
				<td>
				수정전 파일 :<%=(String)reviewImg.getReviewOriFilename()%>
				<input type="file" name="reviewImg">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
				<textarea name="reviewContent" id="reviewContent" cols="80" rows="10" style="resize: none;" placeholder="내용을 입력하세요(최대500자)"><%=reviewText.getReviewContent()%></textarea>
				<br><span id="count"><em>0</em></span><em>/500</em>
				</td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><%=reviewText.getCreatedate().substring(0,10)%></td>
			</tr>
			<tr>
				<td>수정일</td>
				<td><%=reviewText.getUpdatedate().substring(0,10)%></td>
			</tr>
			</table>
			<div>
				<button type=submit id="button" onclick="updateReview()"  class="genric-btn primary radius" style="font-size: 13px;">수정</button>
				<a href="<%=request.getContextPath()%>/review/reviewOne.jsp?historyNo=<%=reviewText.getHistoryNo()%>&productNo=<%=reviewText.getProductNo()%>"  class="genric-btn primary-border radius" style="font-size: 13px;">취소</a>
			</div>
			<br><br>
		</form>
	</div>
<script>
$(document).ready(function(){
	const MAX_COUNT = 500; //const 상수선언 사용하는 키워드(자바의 final과 유사함:변경될 수 없는 값)
	const $reviewContent = $('#reviewContent'); //내용 id
	const $count = $('#count em'); //글자수 id
	
	function preContentCheck() { // 현재 입력되어 있는 글자수 확인을 위한 함수 선언(변수와 달리 함수명은 사용자가 정한다)
		let len = $reviewContent.val().length; // 현재 입력되어있는 글자 수 확인
		if(len > MAX_COUNT) {
			let str = $reviewContent.val().substring(0, MAX_COUNT);
			$reviewContent.val(str);
			alert(MAX_COUNT + '자까지만 입력 가능합니다');
			len = MAX_COUNT;
		}
		$count.text(len); //현재 입력된 글자수 출력
	}
	$reviewContent.on('input', preContentCheck); // reviewContent내에 있는(이벤트종류:input,업데이트 콜백 함수)호출
	preContentCheck(); // 수정 페이지가 로드될 때 원래 입력되어있던 글자 수 체크
});

function updateReview() {
	let form = document.getElementById("updateReview");
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
	
	let result = confirm("게시글을 수정하시겠습니까?");
	  if (result) {
		  document.getElementById("updateReview").submit();
		  alert("게시글 수정이 완료되었습니다.");
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