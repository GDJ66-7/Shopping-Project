<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//리뷰는 모든 사용자가 볼 수 있다
	if(request.getParameter("historyNo") == null
	||request.getParameter("historyNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}

	// 로그인 세션 검사 -- 조회/수정/삭제
	String id = "";
	if(session.getAttribute("loginCstmId") != null) { //loginCstmId = 현재 로그인한 고객아이디
		id = (String)session.getAttribute("loginCstmId");
	}
	System.out.println(id+"<---review LOGIN ID");
	
	// 리스트에서 받아온 값 저장 & 메서드 호출 & 객체 생성
	int historyNo = Integer.parseInt(request.getParameter("historyNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	//System.out.println(historyNo+"<----");
	
	// 리뷰 이미지와 글 출력 메서드
	ReviewDao review = new ReviewDao(); // DAO (동일)
	Review reviewText = review.selectReviewOne(historyNo); //vo
	ReviewImg reviewImg = review.selectReviewImg(historyNo); //vo
%>
<!DOCTYPE html>
<html lang="zxx">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>리뷰 상세보기</title>
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
<style>
a{text-decoration: none;}
.customer{float: right;}
.customerReview{text-align: center;}
</style>
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
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">상품 리뷰</h2>
<br>
<table class="table table-bordered">
	<tr>
		<tr>
		<td style="text-align: center;"><strong><%=reviewText.getReviewTitle()%><strong></td>
		</tr>
	<tr>
		<td colspan="2">
		<div class="customerReview">
		<div class="revimg"><img src="${pageContext.request.contextPath}/review/reviewImg/<%=(String)reviewImg.getReviewSaveFilename()%>" width="250" height="250"></div>
		<p><%=reviewText.getReviewContent()%></p>
		</div>
		<div class="customer">
		<div class="one"><%=reviewText.getId()%></div>
		<div class="two"><%=reviewText.getCreatedate().substring(0,10)%></div>
		</div>
		</td>
	</tr>
</table>
<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=reviewText.getProductNo()%>" class="btn btn-light">목록</a>
<%
	if(id.equals(reviewText.getId())) { //로그인한 사용자와 작성자가 같을 때만 수정/삭제버튼 노출
%>
<a href="<%=request.getContextPath()%>/review/updateReview.jsp?historyNo=<%=reviewText.getHistoryNo()%>&productNo=<%=reviewText.getProductNo()%>" class="btn btn-light">수정</a>
<a onclick="deleteReview()" href="<%=request.getContextPath()%>/review/deleteReviewAction.jsp?productNo=<%=reviewText.getProductNo()%>&historyNo=<%=reviewText.getHistoryNo()%>&writerId=<%=reviewText.getId()%>" class="btn btn-outline-light text-dark" style="float: right;">삭제</a>
<%
	}
%>
</div>
<br>
<script>
/*let img = document.getElementsByTagName("rimg");
for (let x = 0; x < img.length; x++) {
  img.item(x).onclick = function() {
    window.open(this.src, "_blank", "width=500, height=500");
  };
}*/

function deleteReview(){ //삭제 confirm 추가
	let result = confirm("작성된 리뷰를 삭제하시겠습니까?");
	if(result){
		alert("삭제되었습니다");
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
                                <a href="index.html">Home</a>
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
</body>
</html>
