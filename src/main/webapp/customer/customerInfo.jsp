<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//새션 확인 관리자아이디러 로그인 되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null){
		response.sendRedirect(request.getContextPath()+"/employee/employeeInfo.jsp");
		return;
	}
	//세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginCstmId"));
	//세션아이디 디버깅
	System.out.println(id+"<-- id");	
	//고객 정도 리스트 메소드 선언
	MemberDao li = new MemberDao();
	ArrayList<HashMap<String, Object>> list = li.selectCstmList(id);
	System.out.println(list+"<-- list");
	
%>
<!doctype html>
<html lang="zxx">

<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	 <script>
	 $(function(){
	    	//시작하자마자 숨기기
			$('#myElement').toggle();
	    	$('#adBy').toggle();
	    	$('#emailBy').toggle();
	    	$('#phoneBy').toggle();
	 });
	$(document).ready(function() {
	      // 숨기기/보이기 버튼 클릭 시 실행할 코드
	    $('#toggleButton').click(function() {
	        // #myElement 요소의 숨김/보임 상태를 토글합니다.
	        $('#byElement').toggle();
	        $('#myElement').toggle();
	        $('#toggleButton').toggle();
	        
	      });
	    $('#toggle2Button').click(function() {
	          // #myElement 요소의 숨김/보임 상태를 토글합니다.
	          $('#myElement').toggle();
	          $('#byElement').toggle();
	          $('#toggleButton').toggle();
	        });
	      
	      //address 변경하기 버튼 기능
	    $('#addressBtn').click(function() {
		        // #myElement 요소의 숨김/보임 상태를 토글합니다.
		        $('#adEl').toggle();
		        $('#adBy').toggle();
		        $('#addressBtn').toggle();
		        
		      });
	   	$('#adrCansel').click(function() {
	          // #myElement 요소의 숨김/보임 상태를 토글합니다.
	          $('#adBy').toggle();
	          $('#adEl').toggle();
	          $('#addressBtn').toggle();
	        });
	   	
	   	  //email 변경하기 버튼 기능
		$('#emailBtn').click(function() {  
	        // #myElement 요소의 숨김/보임 상태를 토글합니다.
	        $('#emilEl').toggle();
	        $('#emailBy').toggle();
	        $('#emailBtn').toggle();
	        
	      });
	    $('#emailCansel').click(function() {
	          // #myElement 요소의 숨김/보임 상태를 토글합니다.
	          $('#emailBy').toggle();
	          $('#emilEl').toggle();
	          $('#emailBtn').toggle();
	        });
	    
	    // 전화번호 변경하기 버튼 기능
	    $('#phoneBtn').click(function() {
	        // #myElement 요소의 숨김/보임 상태를 토글합니다.
	        $('#phoneEl').toggle();
	        $('#phoneBy').toggle();
	        $('#phoneBtn').toggle();
	        
	      });
	    $('#phoneCansel').click(function() {
	          // #myElement 요소의 숨김/보임 상태를 토글합니다.
	          $('#phoneBy').toggle();
	          $('#phoneEl').toggle();
	          $('#phoneBtn').toggle();
	        });
	    });
	</script>
	<script>
	$(document).ready(function() {
		let adCheck = false;
	 // 주소유효성 체크
      $('#address_kakao').blur(function(){
         if ($('#address_kakao').val().length < 1) {
            $('#addressMsg').text('주소를 입력하세요');
            
         } else {
            $('#addressMsg').text('');
         }
      });
	   // pw유효성 체크
	      $('#adPw').blur(function(){
	         if ($('#adPw').val().length < 4) {
	            $('#adPwMsg').text('PW는 4자이상이어야 합니다');
	            $('#adPw').val('');
	         } else {
	            $('#adPwMsg').text('');
	            adCheck = true;
	         }
	      });
	      $('#adBtn').click(function() {
	    	  if(adCheck == false) { // if(!allCheck) {
	    		  alert('수정할 정보를 모두 입력하시길 바랍니다')
		            return;
		         }else{
		        	 $('#adForm').submit();
	        	}
	      });
	}); 
	</script>
	<script>
	$(document).ready(function() {
		let emCheck = false;
		// email유효성 체크
	      $('#email').blur(function(){
	         if ($('#email').val() == '') {
	            $('#emailMsg').text('email를 입력하세요');
	            
	         } else {
	            $('#emailMsg').text('');
	         }
	      });
	   // pw유효성 체크
	      $('#emPw').blur(function(){
	         if ($('#emPw').val().length < 4) {
	            $('#emPwMsg').text('PW는 4자이상이어야 합니다');
	            $('#emPw').val('');
	         } else {
	            $('#emPwMsg').text('');
	            emCheck = true;
	         }
	      });
	      $('#emBtn').click(function() {
	    	  if(emCheck == false) { // if(!allCheck) {
	    		  alert('수정할 정보를 모두 입력하시길 바랍니다')
		            return;
		         }else{
		        	 $('#emForm').submit();
	        	}
	      });
	}); 
	</script>
	<script>
	$(document).ready(function() {
		let phCheck = false;
		// 전화번호유효성 체크
	      $('#tel').blur(function(){
	         if ($('#tel').val().length < 1) { 
	            $('#telMsg').text('전화번호를 입력하세요');
	            
	         } else {
	            $('#telMsg').text('');
	            
	         }
	      });
	   // pw유효성 체크
	      $('#phPw').blur(function(){
	         if ($('#phPw').val().length < 4) {
	            $('#phPwMsg').text('PW는 4자이상이어야 합니다');
	            $('#phPw').val('');
	         } else {
	            $('#phPwMsg').text('');
	            phCheck = true;
	         }
	      });
	      $('#phBtn').click(function() {
	    	  if(phCheck == false) { // if(!allCheck) {
	    		  alert('수정할 정보를 모두 입력하시길 바랍니다')
		            return;
		         }else{
		        	 $('#phForm').submit();
	        	}
	      });
	}); 
	</script>			 
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
    <!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
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
                        <h2>마이페이지</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

  <!-- ================ contact section start ================= -->
    <div class="container">
    <br><div class="col-12">
         	 <h2 class="contact-title">회원정보</h2>
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
	<%
		if(id == null){
	%>
		<h1>로그인 해주시길 바랍니다.</h1>
	<%
		}
	%>
	<%
		if(id != null){
			for(HashMap<String, Object> s : list){
	%>
		<table class="table">
			<tr>
				<td><p>이름</p></td>
				<td><%=(String)(s.get("고객이름"))%></td>
				<td></td>
			</tr>
			<tr>
				<td><p>비밀번호</p></td>
				<td>
					<div id="byElement">*******</div>
					<div id="myElement">
						<form action="<%=request.getContextPath()%>/customer/updatePasswordAction.jsp" method="post">
						<input type="hidden" name="id" value="<%=id%>"><!-- 세션값아이디 히든으로 넘기기 -->
			
						<p>현재 비밀번호</p>
						<input type="password" name="onePw" placeholder="비밀번호" required="required" class="single-input"><br>
	
						<p>변경할 비밀번호</p>
						<input type="password" name="pw" placeholder="비밀번호"  class="single-input" required="required"><br>
	
						<p>변경할 비밀번호 확인</p>
						<input type="password" name="checkPw" placeholder="비밀번호 재확인" class="single-input" required="required"><br>
			
						<button type="button" id="toggle2Button" class="genric-btn primary-border circle">취소</button>
						<button type="submit" class="genric-btn primary-border circle">완료</button>
						</form>
					</div></td>
				<td>
					<button id="toggleButton" type="button" class="genric-btn primary-border circle">비밀번호 변경</button>
				</td>

			</tr>
			<tr>
				<td><p>주소</p></td>
				<td>
					<div id="adEl"><%=(String)(s.get("고객주소"))%></div>
					<div id="adBy">
						<form action="<%=request.getContextPath()%>/customer/updateAddressAction.jsp" method="get" id="adForm">
							<input type="hidden" name="id" value="<%=id%>"><!-- 세션값아이디 히든으로 넘기기 -->
							<p>주소</p>
							<p><span id="addressMsg" class="msg"></span></p> 
							<textarea name ="cstmAddress" id="address_kakao" cols ="33" rows="5" placeholder="주소입력" class="single-textarea" required="required" ></textarea><br>
							<p>비밀번호</p>
							<p><span id="adPwMsg" class="msg"></span></p>
							<input type="password" id="adPw" name="pw" placeholder="비밀번호" required="required" class="single-input"><br>					
							<button type="button" id="adrCansel" class="genric-btn primary-border circle">취소</button>
							<button type="button" id="adBtn" class="genric-btn primary-border circle">완료</button>
						</form>
					</div>
				</td>
				<td>
					<button id="addressBtn" type="button" class="genric-btn primary-border circle">주소 변경</button>
				</td>
			</tr>
			<tr>
				<td><p>이메일</p></td>
				<td>
					<div id="emilEl"><%=(String)(s.get("고객이메일"))%></div>
					<div id="emailBy">
						<form action="<%=request.getContextPath()%>/customer/updateEmailAction.jsp" method="get" id="emForm">
							<input type="hidden" name="id" value="<%=id%>"><!-- 세션값아이디 히든으로 넘기기 -->
							<p>이메일</p>
							<p><span id="emailMsg" class="msg"></span></p>
							<input type="email" id="email" name="cstmEmail" required="required" class="single-input"><br>
							<p>비밀번호</p>
							<p><span id="emPwMsg" class="msg"></span></p>
							<input type="password" id="emPw" name="pw" placeholder="비밀번호" required="required" class="single-input"><br>
							<button type="button" id="emailCansel" class="genric-btn primary-border circle">취소</button>
							<button type="button" id="emBtn" class="genric-btn primary-border circle">완료</button>
						</form>
					</div>
				</td>
				<td>
					<button id="emailBtn" type="button" class="genric-btn primary-border circle">이메일 변경</button>
				</td>
			</tr>
			<tr>
				<td><p>생일</p></td>
				<td><%=(String)(s.get("고객생일"))%></td>
				<td></td>
			</tr>
			<tr>
				<td><p>휴대전화</p></td>
				<td>
					<div id="phoneEl"><%=(String)(s.get("고객번호"))%></div>
					<div id="phoneBy">
						<form action="<%=request.getContextPath()%>/customer/updatePhoneAction.jsp" method="get" id="phForm">
							<input type="hidden" name="id" value="<%=id%>"><!-- 세션값아이디 히든으로 넘기기 -->
							<p>전화번호</p>
							<p><span id="telMsg" class="msg"></span></p>
							<input type="tel" id="tel" name="cstmPhone" required="required" class="single-input"><br>
							<p>비밀번호</p>
							<p><span id="phPwMsg" class="msg"></span></p>
							<input type="password" id="phPw" name="pw" placeholder="비밀번호" required="required" class="single-input"><br>
							<button type="button" id="phoneCansel" class="genric-btn primary-border circle">취소</button>
							<button type="submit" id="phBtn" class="genric-btn primary-border circle">완료</button>
						</form>
					</div>
				</td>
				<td>
					<button id="phoneBtn" type="button" class="genric-btn primary-border circle">전화번호 변경</button>
				</td>
			</tr>
			<tr>
				<td><p>등급</p></td>
				<td><%=(String)(s.get("고객등급"))%></td>
				<td></td>
			</tr>
			<tr>
				<td><p>포인트</p></td>
				<td><%=(Integer)(s.get("고객포인트"))%></td>
				<td></td>
			</tr>
			<tr>
				<td><p>가입일</p></td>
				<td><%=(String)(s.get("가입일"))%></td>
				<td></td>
			</tr>
		</table>
	<% 			
			}
		}
	%>
		<br><div class="col-12">
         	 <h2 class="contact-title">회원정보 변경</h2>
        </div>
	<br><a href="<%=request.getContextPath()%>/order/customerOrderHistory.jsp" class="genric-btn primary-border circle">주문내역</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/customer/updateCustomer.jsp" class="genric-btn primary-border circle">개인정보수정</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/customer/customerPointList.jsp" class="genric-btn primary-border circle">포인트내역조회</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/customer/deleteCustomer.jsp" class="genric-btn primary-border circle">회원탈퇴</a>
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