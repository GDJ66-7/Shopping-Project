<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//새션 확인 로그인 되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") != null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
	String useId = "";
	if(request.getParameter("useId") != null){
		useId = request.getParameter("useId");
	};
%>
<!doctype html>
<html lang="zxx">
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	
	<script type="text/javascript">
        function openPopup() {
            // 윈도우 팝업 창을 띄우는 함수
            var popup = window.open("checkId.jsp", "popupWindow", "width=500,height=300");
        }
    </script>
    <!-- 카카오API -->
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
	<!-- form입력 자바스크립트로 유효성 검사 -->
	<script>
	$(document).ready(function() {
		 let allCheck = false; 
		// id유효성 체크
	      $('#id').blur(function() {
	         if ($('#id').val().length < 4) {
	            $('#idMsg').text('ID는 4자이상이어야 합니다');
	            
	         } else {
	            console.log($('#id').val()); 
	            // console.log($(this).val()); // this뒤에 jquery메서드를 참조하려면 $(this)후...
	            $('#idMsg').text('');
	            
	         }
	      });
	   // pw유효성 체크
	      $('#pw').blur(function(){
	         if ($('#pw').val().length < 4) {
	            $('#pwMsg').text('PW는 4자이상이어야 합니다');
	            
	         } else {
	            $('#pwMsg').text('');
	            
	         }
	      });
	   // pwck유효성 체크
	      $('#pwck').blur(function(){
	         if ($('#pwck').val() != $('#pw').val()) {
	            $('#pwMsg').text('PW를 확인하세요');
	            
	         } else {
	            $('#pwMsg').text('');
	            
	         }
	      });
	   // name유효성 체크
	      $('#name').blur(function(){
	         if ($('#name').val().length < 1) { // $('#pw').val() == ''
	            $('#nameMsg').text('name을 입력하세요');
	            
	         } else {
	            $('#nameMsg').text('');
	            
	         }
	      });
	      
	      // birth유효성 체크
	      $('#birth').blur(function(){
	         if ($('#birth').val().length < 1) { // $('#pw').val() == ''
	            $('#birthMsg').text('birth을 입력하세요');
	            
	         } else {
	            $('#birthMsg').text('');

	            let today = new Date();
	            let todayYear = today.getFullYear();
	            let birthYear = $(this).val().substring(0,4); //$('#birth').val().substring(0,4);
	            let age = todayYear - Number(birthYear);             
	            $('#age').val(age);
	            
	         }
	      });
	      // 전화번호유효성 체크
	      $('#tel').blur(function(){
	         if ($('#tel').val().length < 1) { 
	            $('#telMsg').text('전화번호를 입력하세요');
	            
	         } else {
	            $('#telMsg').text('');
	            
	         }
	      });
	      // 전화번호유효성 체크
	      $('#quest').blur(function(){
	         if ($('#quest').val().length < 1) {
	            $('#questMsg').text('전화번호를 입력하세요');
	            
	         } else {
	            $('#questMsg').text('');
	            
	         }
	      });
	      // 주소유효성 체크
	      $('#address_kakao').blur(function(){
	         if ($('#address_kakao').val().length < 1) {
	            $('#addressMsg').text('주소를 입력하세요');
	            
	         } else {
	            $('#addressMsg').text('');
	            
	         }
	      });
	   // email유효성 체크
	      $('#email').blur(function(){
	         if ($('#email').val() == '') {
	            $('#emailMsg').text('email를 입력하세요');
	            
	         } else {
	            $('#emailMsg').text('');
	            
	         }
	      });
	      $('#emailUrl').blur(function(){
	         if ($('#emailUrl').val() == '') {
	            $('#emailMsg').text('emailURl를 입력하세요');
	            
	         } else {
	            $('#emailMsg').text('');
	            
	            allCheck = true;
	         }
	      });
	   // signinBtn click + gender선택 유무 + hobby선택 유무 체크
	      $('#signinBtn').click(function() {
	         // 페이지에 바로 버턴 누름을 방지하기 위해
	         if(allCheck == false) { // if(!allCheck) {
	            
	            return;
	         }
	         
	         if($('.gender:checked').length == 0) {
	            $('#genderMsg').text('성별을 선택하세요');
	            return;
	         } else {
	            $('#genderMsg').text('');
	         }
	         
	         if($('.agree:checked').length == 0) {
	            $('#agreeMsg').text('개인정보 동의를 해주세요');
	            return;
	         } else {
	            $('#agreeMsg').text('');
	         }
	         
	         $('#signinForm').submit();
	      });
	});
	</script>
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
						<!-- 메인메뉴 바 -->
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

    <!-- breadcrumb part start-->
    <section class="breadcrumb_part">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                       <h1>고객 회원가입</h1>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

  <!-- ================ contact section start ================= -->
  
    <div class="container">
    <br><div class="col-12">
         	 <h2 class="contact-title">회원정보 입력</h2>
        </div>
   	<h1>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</h1>
		<form action="<%=request.getContextPath()%>/customer/insertCustomerAction.jsp" method="post">
						
				
						<p>아이디(카카오톡 이메일로 회원가입시 카카오톡으로 로그인가능)</p>&nbsp;<button onclick="openPopup()" class="genric-btn primary-border circle">아이디입력하기</button>
						<input type="text" name="id" id="id" placeholder="아이디" readonly="readonly" value="<%=useId%>" class="single-input"><br>
						<span id="idMsg" class="msg"></span>
						<p>비밀번호</p>
						<input type="password" id="pw" name="pw" placeholder="비밀번호"  class="single-input"><br>
						<span id="pwMsg" class="msg"></span>
						<p>비밀번호 확인</p>
						<input type="password" id="pwck" name="checkPw" placeholder="비밀번호 재확인" class="single-input"><br>

						<p>이름</p>
						<input type="text" id="name" name="cstmName"  class="single-input"><br>
						<span id="nameMsg" class="msg"></span>
						<p>생년월일</p>
						<input type="date" name="cstmBirth" id="birth" ><br>
						<span id="birthMsg" class="msg"></span>
						<p>나이</p>
						<input type="text" id="age" readonly="readonly" class="single-input"><br>
						<br>
						<p>전화번호</p>
						<input type="tel" id="tel" name="cstmPhone"  class="single-input"><br>
						<span id="telMsg" class="msg"></span>
						<p>태어난 동네</p>
						<input type="text" id="quest" name="cstmQuestion" class="single-input"><br>
						<span id="questMsg" class="msg"></span>
						<p>주소</p>
						<textarea name ="cstmAddress" id="address_kakao" cols ="33" rows="5" placeholder="주소입력" class="single-textarea" required="required" ></textarea><br>
						<span id="addressMsg" class="msg"></span>
						<p>이메일</p>
						<input type="email" id="email" name="cstmEmail" class="single-input"><br>
						<span id="emailMsg" class="msg"></span>
						<p>성별</p>	
								<input type="radio" name="cstmGender" class="gender" value="남">남 &nbsp;
               					<input type="radio" name="cstmGender" class="gender" value="여">여
            				    <span id="genderMsg" class="msg"></span>
						<p>개인정보동의</p>
								<input type="radio" name="cstmAgree" class="agree" value="y">동의 &nbsp;
		               			<input type="radio" name="cstmAgree" class="agree" value="n">비동의
		           			    <span id="agreeMsg" class="msg"></span>
		           			    <br><br>
			<button type="submit" class="genric-btn primary-border circle">가입하기</button>&nbsp;
			<button type="button" id="signinBtn" class="genric-btn primary-border circle">회원가입</button>&nbsp;
      		<button type="reset" class="genric-btn primary-border circle">초기화</button>
		</form>
    </div><br>
 
  <!-- ================ contact section end ================= -->

  <!--::footer_part start::-->
  <footer class="footer_part">
        <div class="footer_iner section_bg">
            <div class="container">
                <div class="row justify-content-between align-items-center">
                    <div class="col-lg-8">
                        <div class="footer_menu">
                            <div class="footer_logo">
                                <a href="index.html"><img src="<%=request.getContextPath()%>/css/img/logo.png" alt="#"></a>
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

</html>