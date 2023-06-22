<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
 	// 유효성 검사
	if(request.getParameter("aNo") == null
	||request.getParameter("aNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}
	
	// 받아온 값 저장 - 수정할 aNo & 해당 qNo
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(productNo+"<---u.a productNo---");
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	String aContent = request.getParameter("aContent");
	String empid = (String)session.getAttribute("loginEmpId1");
	if (empid == null) { // 답변을 단 관리자
	    empid = (String) session.getAttribute("loginEmpId2");
	}
	//System.out.println(aNo+"<----");
	
	// Dao 선언 & 저장 (view에서는 수정 전 내용 가져와야 하니까 answerOne)
	AnswerDao answer = new AnswerDao();
	Answer one = answer.answerOne(qNo);
	
	//로그인 세션 검사
	if(!empid.equals(one.getId())){
		response.sendRedirect(request.getContextPath()+"/question/questionOne.jsp?qNo="+qNo);
		return;
	}

%>
<!DOCTYPE html>
<html lang="zxx">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>답변 수정하기</title>
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
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">문의 답변 수정하기</h2>
<form id="updateAnswer" action="<%=request.getContextPath()%>/answer/updateAnswerAction.jsp" method="post"> 
<input type="hidden" name="aNo" value="<%=one.getaNo()%>">
<input type="hidden" name="qNo" value="<%=one.getqNo()%>">
<input type="hidden" name="id" value="<%=one.getId()%>">
<input type="hidden" name="productNo" value="<%=productNo%>">
		<table class="table table-bordered">
		<tr>
			<td>내용</td>
			<td>
			<textarea name="aContent" cols="80" rows="10" style="resize: none;"><%=one.getaContent()%></textarea>
			</td>
			</tr>
		</table>
		<div>
			<button type=submit class="genric-btn primary radius" style="font-size: 13px;" onclick="updateAnswer()">수정</button>
			<a href="<%=request.getContextPath()%>/question/questionOne.jsp?qNo=<%=one.getqNo()%>&productNo=<%=productNo%>"  class="genric-btn primary-border radius" style="font-size: 13px;">취소</a>
		</div>
		<br><br>
	</form>
	</div>
<script>
function updateAnswer() {
	let form = document.getElementById("updateAnswer");
	if (form.aContent.value.trim() === '') { // 공백 제거 후 비교
		alert('내용을 입력해주세요');
		form.aContent.focus();
		event.preventDefault();
		return;
	}
	
	let result = confirm("내용을 수정하시겠습니까?");
	  if (result) {
		  document.getElementById("updateAnswer").submit();
		  alert("답변 수정이 완료되었습니다.");
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