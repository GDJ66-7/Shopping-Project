
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
    <!-- 카카오API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	window.onload = function(){
		  $("#address_kakao").click(function(){ //주소입력칸을 클릭하면
		        //카카오 지도 발생
		        new daum.Postcode({
		            oncomplete: function(data) { //선택시 입력값 세팅
		                $('#address_kakao').val(data.address) // 주소 넣기
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
	            $('#pw').val('');
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
	            allCheck = true;
	         }
	      });
	   
	      
	   // signinBtn click + gender선택 유무 + hobby선택 유무 체크
	      $('#signinBtn').click(function() {
	         // 페이지에 바로 버턴 누름을 방지하기 위해
	         if(allCheck == false) { // if(!allCheck) {
	        	 alert('회원정보를 모두 입력하시길 바랍니다')
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
	         
	         $('#singinForm').submit();
	      });
	});
	</script>
	<script>
  $(document).ready(function() {
    $('#ckId').click(function() {
      var value = $('#id').val();
      createHiddenFormAndSubmit(value);
    });

    function createHiddenFormAndSubmit(value) {
      var form = $('<form>', {
        action: '<%=request.getContextPath()%>/customer/checkIdAction.jsp',
        method: 'post'
      });

      $('<input>').attr({
        type: 'hidden',
        name: 'id',
        value: value
      }).appendTo(form);

      form.appendTo('body').submit();
    }
  });
</script>
<style>
  #ckId {
    padding: 0px 20px; /* 원하는 패딩 값을 지정하세요 */
    font-size: 10px; /* 원하는 폰트 크기를 지정하세요 */
  }
  /* 컨테이너 스타일 */
.date-container {
  position: relative;
  display: inline-block;
}

/* 가짜 input 스타일 */
.custom-date {
  padding: 10px;
  font-size: 16px;
  color: #333;
  background-color: #fff;
  border: 1px solid #ccc;
  border-radius: 4px;
  cursor: pointer;
}

/* 가짜 input 아이콘 스타일 */
.custom-date::after {
  content: "\f073";
  font-family: "Font Awesome 5 Free";
  font-weight: 900;
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  pointer-events: none;
}

/* 실제 input 요소 스타일 */
.custom-date input[type="date"] {
  opacity: 0;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  cursor: pointer;
}

/* 가짜 input에 포커스 스타일 */
.custom-date:focus-within {
  outline: none;
  box-shadow: 0 0 0 2px lightblue; /* 포커스 시에 원하는 스타일을 적용하세요. */
}
</style>

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
    <div>
		<jsp:include page="/main/menuBar.jsp"></jsp:include>
	</div>
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
   	<p>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</p>
		<form action="<%=request.getContextPath()%>/customer/insertCustomerAction.jsp" method="post" id="singinForm">
			<p>아이디(카카오톡 이메일로 회원가입시 카카오톡으로 로그인가능)</p>	<button type="button" id="ckId" class="genric-btn primary-border circle">중복체크</button><br>
			<p><span id="idMsg" class="msg"></span></p>
			<input type="text" id="id" value="<%=useId%>" placeholder="아이디" class="single-input"><br>
			<p>중복 확인된 아이디</p>
			<input type="text" name="id" id="id" value="<%=useId%>" placeholder="아이디" class="single-input" readonly="readonly"><br>
			
			<p>비밀번호</p>
			<p><span id="pwMsg" class="msg"></span></p>
			<input type="password" id="pw" name="pw" placeholder="비밀번호"  class="single-input"><br>
			
			<p>비밀번호 확인</p>
			<input type="password" id="pwck" name="checkPw" placeholder="비밀번호 재확인" class="single-input"><br>

			<p>이름</p>
			<p><span id="nameMsg" class="msg"></span></p>
			<input type="text" id="name" name="cstmName"  class="single-input"><br>
			
			<p>생년월일</p>
			<p><span id="birthMsg" class="msg"></span></p>
			<div class="date-container">
 				<input type="date" name="cstmBirth" id="birth" class="custom-date">
			</div>
			
			<p>나이</p>
			<input type="text" id="age" readonly="readonly" class="single-input"><br>
			
			<p>전화번호</p>
			<p><span id="telMsg" class="msg"></span></p>
			<input type="tel" id="tel" name="cstmPhone"  class="single-input"><br>
			
			<p>태어난 동네</p>
			<p><span id="questMsg" class="msg"></span></p>
			<input type="text" id="quest" name="cstmQuestion" class="single-input"><br>
			
			<p>주소(입력창 클릭시 검색가능)</p>
			<p><span id="addressMsg" class="msg"></span></p>
			<textarea name ="cstmAddress" id="address_kakao" cols ="33" rows="5" placeholder="주소입력" class="single-textarea" required="required" ></textarea><br>
			
			<p>이메일</p>
			<p><span id="emailMsg" class="msg"></span></p>
			<input type="email" id="email" name="cstmEmail" class="single-input"><br>
			
			<p>성별</p>	
				    <p><span id="genderMsg" class="msg"></span></p>
					<input type="radio" name="cstmGender" class="gender" value="남">&nbsp;남 &nbsp;
   					<input type="radio" name="cstmGender" class="gender" value="여">&nbsp;여
			<p>개인정보동의</p>
       			    <p><span id="agreeMsg" class="msg"></span></p>
					<input type="radio" name="cstmAgree" class="agree" value="y">&nbsp;동의 &nbsp;
           			<input type="radio" name="cstmAgree" class="agree" value="n">&nbsp;비동의
       			    <br><br>
			<button type="button" id="signinBtn" class="genric-btn primary-border circle">회원가입</button>&nbsp;&nbsp;
      		<button type="reset" class="genric-btn primary-border circle">초기화</button>
      		<br><span id="clickMsg" class="msg"></span>
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