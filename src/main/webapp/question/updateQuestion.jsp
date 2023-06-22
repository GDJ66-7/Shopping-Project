<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 유효성 검사
	if(request.getParameter("qNo") == null
	||request.getParameter("qNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}
	
	// 받아온 값 저장 & 메서드 호출
	String id = (String)session.getAttribute("loginCstmId");
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	QuestionDao question = new QuestionDao();
	
	// Question 객체 변수에 저장(vo) 수정 페이지에 표시할 객체(questionOne과 동일)
	Question one = question.selectQuestionOne(qNo);
	//System.out.println(qNo+"<----");
	
	// 로그인 세션 검사
	if(!id.equals(one.getId())){
		response.sendRedirect(request.getContextPath()+"/question/questionOne.jsp");
		return;
	}
	
	System.out.println(id+"<---loginmember--");
	System.out.println(one.getId()+"<---question writer--");
%>
<!DOCTYPE html>
<html lang="zxx">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>문의사항 수정하기</title>
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
</head>
<body>
	<!--::header part start::-->
	<header>
	<jsp:include page="/main/menuBar.jsp"></jsp:include>
	</header>
	<!-- Header part end-->
<br>
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">상품문의</h2>
<form id="QuestionUpdate" action="<%=request.getContextPath()%>/question/updateQuestionAction.jsp" method="post">
	<input type="hidden" name="productNo" value="<%=one.getProductNo()%>">
	<input type="hidden" name="qNo" value="<%=one.getqNo()%>">
	<input type="hidden" name="id" value="<%=one.getId()%>"><!-- 세션검사 -->
		<table class="table table-bordered">
			<tr>
				<td>제목</td>
				<td>
				<input type="text" name="qTitle" value="<%=one.getqTitle()%>" size=60; placeholder="제목을 입력하세요(50자 이내)">
			</td>
		</tr>
		<tr>
			<td>
				<label for="qCategory">카테고리</label>
			</td>
			<td>
				<select name="qCategory" id="qCategory">
				<option value="배송">배송</option>
				<option value="상품">상품</option>
				<option value="기타">기타</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
			<textarea name="qContent" cols="80" rows="10" style="resize: none;" id="qContent" placeholder="내용을 입력하세요(최대500자)"><%=one.getqContent()%></textarea>
			<br><span id="count"><em>0</em></span><em>/500</em>
			</td>
			</tr>
		</table>
		<div>
			<button type=submit class="genric-btn primary radius" style="font-size: 13px;" onclick="QuestionUpdate()">수정</button>
			<a href="<%=request.getContextPath()%>/question/questionOne.jsp?qNo=<%=one.getqNo()%>&productNo=<%=one.getProductNo()%>" class="genric-btn primary-border radius" style="font-size: 13px;">취소</a>
		</div>
		<br><br>
</form>
</div>
<script>
$(document).ready(function(){
	const MAX_COUNT = 500; //const 상수선언 사용하는 키워드(자바의 final과 유사함:변경될 수 없는 값)
	const $qContent = $('#qContent');
	const $count = $('#count em');
	
	function preContentCheck() { // 현재 입력되어 있는 글자수 확인을 위한 함수 선언
		let len = $qContent.val().length; // 현재 입력되어있는 글자 수 확인
		if(len > MAX_COUNT) {
			let str = $qContent.val().substring(0, MAX_COUNT);
			$qContent.val(str);
			alert(MAX_COUNT + '자까지만 입력 가능합니다');
			len = MAX_COUNT;
		}
		$count.text(len); //현재 입력된 글자수 출력
	}
	$qContent.on('input', preContentCheck); // qContent내에 있는(이벤트종류:input,업데이트 콜백 함수)호출
	preContentCheck(); // 수정 페이지가 로드될 때 원래 입력되어있던 글자 수 체크
});

function QuestionUpdate() {
	let form = document.getElementById("QuestionUpdate");
	if (form.qContent.value.trim() === '') { // 공백 제거 후 비교
		alert('내용을 입력해주세요');
		form.qContent.focus();
		event.preventDefault();
		return;
	}
	if (form.qTitle.value.trim() === '') { // 공백 제거 후 비교
		alert('제목을 입력해주세요');
		form.qTitle.focus();
		event.preventDefault();
		return;
	}
	
	let result = confirm("내용을 수정하시겠습니까?");
	  if (result) {
		  document.getElementById("QuestionUpdate").submit();
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