<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginEmpId2") == null) {
		out.println("<script>alert('최고 관리자만 접근 가능합니다.'); location.href='"+request.getContextPath()+"/main/home.jsp';</script>");
		return;
	}

	// discountNo를 통하여 할인정보 수정
	if(request.getParameter("discountNo") == null){
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
		return;
	}

	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String productName = request.getParameter("productName");
	String discountStart = request.getParameter("discountStart");
	
	System.out.println(discountNo + "insertDiscount discountNo");
	System.out.println(productNo + "insertDiscount productNo");
	System.out.println(productName + "insertDiscount productName");
	System.out.println(discountStart + "insertDiscount discountStart");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.button-container {
	  display: flex;
	  justify-content: space-between;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	//jQuery 유효성검사
	$(document).ready(function(){
		// 전송 유효성 검사 값이 하나라도 미입력시 전송x
		$('#updateDiscountBtn').click(function(){
			
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
			
			$('#updateDiscountForm').submit();
		});
	});
</script>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>GDJ-Mart</title>
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
	<!-- 메인메뉴 바 -->
	<jsp:include page="/main/menuBar.jsp"></jsp:include>
    <!-- Header part end-->

    <!-- breadcrumb part start-->
    <section class="breadcrumb_part" style = "height :200px;">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>할인상품관리 페이지(수정)</h2> 
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
	<form id="updateDiscountForm" action="<%=request.getContextPath()%>/discount/updateDiscountAction.jsp">
		<div class="row align-items-center justify-content-center">
			<table class="table table-bordered">
				<tr>
					<th>할인번호</th>
					<td>
						<input type="text" name="discountNo" value="<%=discountNo%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>상품번호</th>
					<td>
						<input type="text" value="<%=productNo%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>상품이름</th>
					<td>
						<input type="text" value="<%=productName%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>할인시작일</th>
					<td>
						<input id="discountStartId" type="datetime-local" name="discountStart">기존 할인 시작일: <%=discountStart%>
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
						<input id="discountRateId" type="text" name="discountRate">
						<span id="discountRateIdMsg" class="msg"></span>
					</td>
				</tr>		
			</table>
		</div>
		<div class="button-container">
		  <span style="text-align: left;"><button class="genric-btn primary circle" type="button" id="updateDiscountBtn">할인상품수정</button></span>
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
    <script src="<%=request.getContextPath()%>/css/js/jquery-1.12.1.min.js"></script>
    <!-- popper js -->
    <script src="<%=request.getContextPath()%>/css/js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src=<%=request.getContextPath()%>/css/js/bootstrap.min.js"></script>
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