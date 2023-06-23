<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

<%
	// 유효성 검사 상품 번호를 이용하여 할인가격을 추가시키기 때문에 상품번호가 필수적
	if(request.getParameter("productNo") == null) {
		response.sendRedirect(request.getContextPath()+"/main/empMain.jsp");
		return;
	}

	String productName = request.getParameter("productName");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	// 디버깅
	System.out.println(productNo + "insertDiscount productNo");
	System.out.println(productName + "insertDiscount productName");
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인 상품 추가</title>
<style>
	.button-container {
	  display: flex;
	  justify-content: space-between;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
				
	// jQuery 유효성검사
	$(document).ready(function(){
		// 전송 유효성 검사 값이 하나라도 미입력시 전송x
		$('#insertDiscountBtn').click(function(){
			
		    var currentDateTime = new Date(); // 현재 날짜와 시간 가져오기
		    
		    // 할인시작일이 없으면 실행
			if($('#discountStartId').val().length == 0) {
				$('#discountStartIdMsg').text('할인 시작일을 설정해주세요');
				return;
				// 할인시작일이 현재보다 이전이면 실행
			} else if(new Date($('#discountStartId').val()) < currentDateTime) {
				// 디버깅
				console.log($('#discountStartId').val());
				$('#discountStartIdMsg').text('할인 시작일을 현재보다 이전으로 설정할 수 없습니다');
				return;
			} else {
				$('#discountStartIdMsg').text('');
			}
		    
			
			if($('#discountEndId').val().length == 0) {
				$('#discountEndIdMsg').text('할인 종료일을 설정해주세요');
				return;
				// 할인종료일이 할인시작일보다 빠르면 실행
			} else if(new Date($('#discountEndId').val()) < new Date($('#discountStartId').val())) {
				console.log($('#discountEndId').val());
				$('#discountEndIdMsg').text('할인 종료일을 할인 시작일 이전으로 설정할 수 없습니다');
				return;
			} else {
				$('#discountEndIdMsg').text('');
			}
			
			
			if($('#discountRateId').val().length == 0) {
				// 디버깅
				console.log($('#discountRateId').val());
				$('#discountRateIdMsg').text('할인율을 입력해주세요');
				return;
			} else {
				$('#discountRateIdMsg').text('');
			}
			
			// 할인율을 0.0단위로 입력하기 어려울 수 있으니 10단위로 입력하면 자동으로 0.0단위로 변환
			var discountRate = parseFloat($('#discountRateId').val());
			// 할인율은 1~100까지
			if(discountRate > 0 && discountRate <= 100) {
				 $('#discountRateId').val(discountRate / 100);
			} else {
				$('#discountRateIdMsg').text('할인율은 1~99까지만 입력해주세요');
				return;
			}
			
			$('#insertDiscountForm').submit();
				
			
		});
		
	});
	
</script>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>GDJ-Mart</title>
    <link rel="icon" href="/Shopping/css/img/favicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/Shopping/css/css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="/Shopping/css/css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="/Shopping/css/css/owl.carousel.min.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="/Shopping/css/css/all.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="/Shopping/css/css/flaticon.css">
    <link rel="stylesheet" href="/Shopping/css/css/themify-icons.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="/Shopping/css/css/magnific-popup.css">
    <!-- swiper CSS -->
    <link rel="stylesheet" href="/Shopping/css/css/slick.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="/Shopping/css/css/style.css">
</head>

<body>
    <!--::header part start::-->
	<!-- 메인메뉴 바 -->
	<jsp:include page="/main/menuBar.jsp"></jsp:include>
    <!-- Header part end-->

    <!-- breadcrumb part start-->
    <section class="breadcrumb_part" style = "height :200px;">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>상품관리 페이지(할인 추가)</h2> 
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->
     <!-- ================ 카테고리추가 폼 ================= -->
	<div class="container">
	<div class="col-12">
   	<br>
	<form id="insertDiscountForm" action="<%=request.getContextPath()%>/discount/insertDiscountAction.jsp">
		<div class="row align-items-center justify-content-center">
		<input type="hidden" name="productNo" value="<%=productNo%>">;
		<table class="table table-bordered">
			<tr>
				<th>상품이름</th>
				<td>
					<input type="text" value="<%=productName %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>할인시작일</th>
				<td>
					<input id="discountStartId" type="datetime-local" name="discountStart">
					<span id="discountStartIdMsg" class="msg"></span>
				</td>
			</tr>	
			<tr>
				<th>할인종료일</th>
				<td>
					<input id="discountEndId" type="datetime-local" name="discountEnd">
					<span id="discountEndIdMsg" class="msg"></span>
				</td>
			</tr>	
			<tr>
				<th>할인율</th>
				<td>
					<input id="discountRateId" type="text" name="discountRate"  style="width:200px; height:30px; font-size:10px;" placeholder="1~99 사이로 입력해주세요(%로자동계산)">
					<span id="discountRateIdMsg" class="msg"></span>
				</td>
			</tr>		
		</table>
		</div>
		<div class="button-container">
			  <span style="text-align: left;"><button class="genric-btn primary circle" type="button" id="insertDiscountBtn">상품할인추가</button></span>
			  <span style="text-align: right;"><button class="genric-btn danger circle arrow" type="reset">초기화</button></span>
		</div>
	</form>
    </div>
    </div>
  <!-- ================ contact section end ================= -->

  <!--::footer_part start::-->
  	<footer class="footer_part">
		<div class="footer_iner">
	    	<div class="container">
                <div class="row justify-content-between align-items-center">
                    <div class="col-lg-8">
                        <div class="footer_menu">
                            <div class="footer_logo">
                                <a href="index.html"><img src="<%=request.getContextPath()%>/css/img/logo.png" alt="#"></a>
                            </div>
                            <div class="footer_menu_item">
                                <a href="<%=request.getContextPath()%>/main/home.jsp">Home</a>
                                <a href="<%=request.getContextPath()%>/main/home.jsp">회사개요</a>
                                <a href="<%=request.getContextPath()%>/product/productList.jsp">상품</a>
                                <a href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지사항</a>
                                <a href="<%=request.getContextPath()%>/employee/employeeInfo.jsp">관리자정보</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="social_icon">
                            <a href="https://ko-kr.facebook.com"><i class="fab fa-facebook-f"></i></a>
                            <a href="https://www.instagram.com"><i class="fab fa-instagram"></i></a>
                            <a href="https://google.com"><i class="fab fa-google-plus-g"></i></a>
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
shopping &copy;<script>document.write(new Date().getFullYear());</script> 저희 ** 쇼핑몰은 고객과 소통하면서 만들어갑니다.<i class="ti-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">GDJ66</a><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></P>
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
    <script src="/Shopping/css/js/jquery-1.12.1.min.js"></script>
    <!-- popper js -->
    <script src="/Shopping/css/js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="/Shopping/css/js/bootstrap.min.js"></script>
    <!-- easing js -->
    <script src="/Shopping/css/js/jquery.magnific-popup.js"></script>
    <!-- swiper js -->
    <script src="/Shopping/css/js/swiper.min.js"></script>
    <!-- swiper js -->
    <script src="/Shopping/css/js/mixitup.min.js"></script>
    <!-- particles js -->
    <script src="/Shopping/css/js/owl.carousel.min.js"></script>
    <script src="/Shopping/css/js/jquery.nice-select.min.js"></script>
    <!-- slick js -->
    <script src="/Shopping/css/js/slick.min.js"></script>
    <script src="/Shopping/css/js/jquery.counterup.min.js"></script>
    <script src="/Shopping/css/js/waypoints.min.js"></script>
    <script src="/Shopping/css/js/contact.js"></script>
    <script src="/Shopping/css/js/jquery.ajaxchimp.min.js"></script>
    <script src="/Shopping/css/js/jquery.form.js"></script>
    <script src="/Shopping/css/js/jquery.validate.min.js"></script>
    <script src="/Shopping/css/js/mail-script.js"></script>
    <!-- custom js -->
    <script src="/Shopping/css/js/custom.js"></script>
</body>

</html>