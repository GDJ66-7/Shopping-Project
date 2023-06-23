<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!-- 작성된 문의 사항 게시글 안에 답변까지 같이 있음(댓글) -->
<!-- 1.관리자와 작성자만 접근가능한 페이지, 게시글에 대한 수정과 삭제는 작성자(고객)만 가능 관리자에게는 노출하지 않음 -->
<!-- 2.답변은 댓글 형식(한개만 작성가능), 작성자(고객)에게는 댓글 입력창과, 댓글 수정 삭제 노출하지 않음 -->
<!-- 3.해당 게시글의 답변한 관리자만 답변 수정&삭제 가능 -->
<%
	// 유효성 검사
	if(request.getParameter("qNo") == null
	||request.getParameter("qNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;	
	}
	
	// 받아온 값 저장 & 메서드 호출 & 객체 생성
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(productNo+"<---questionOne productNo");
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	QuestionDao question = new QuestionDao();
	Question one = question.selectQuestionOne(qNo);
	//System.out.println(qNo+"<----");
	
	String writerId = one.getId(); // 작성자 아이디 대조를 위해 불러오기
	String id = (String)session.getAttribute("loginCstmId"); //로그인 한 사용자 || or 
	String empid = (String)session.getAttribute("loginEmpId1"); //로그인 한 관리자
	if (empid == null) {
	    empid = (String) session.getAttribute("loginEmpId2");
	}
	if (empid == null && !writerId.equals(id)) {
	    out.println("<script>alert('작성자 또는 관리자만 접근할 수 있습니다.'); location.href='" + request.getContextPath() + "/product/productOne.jsp?productNo=" + one.getProductNo() + "';</script>");
	    return;
	}
	System.out.println(id+"<---QA cstmid");
	System.out.println(empid+"<---QA empid");
	
	/*if(session.getAttribute("loginCstmId") == null && session.getAttribute("loginEmpId1")
			== null && session.getAttribute("loginEmpId2") == null){
			response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
			return;
	}*/
	
	AnswerDao answer = new AnswerDao(); //선언
	Answer aone = answer.answerOne(qNo); //dao에서 answerOne메서드 사용 -> 반환값 aone에 담김

	boolean completeAnswer = (aone != null); // 답변이 있는 상태면 true , 없으면 false
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
<style>
.customerQna{text-align: right;}
</style>
<body>
	<!--::header part start::-->
	<header>
	<jsp:include page="/main/menuBar.jsp"></jsp:include>
	</header>
    <!-- Header part end-->
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">상품Q&A</h2>
<br>
<table class="table table-bordered">
	<tr>
		<td>
		<span class="badge rounded-pill bg-light text-dark p-2">category</span>
		<%=one.getqCategory()%>
		</td>
	</tr>
	<tr>
		<td>
		<span class="badge rounded-pill bg-light text-dark p-2">NO.<%=one.getqNo()%></span>
		<%=one.getqTitle()%>
		</td>
	</tr>
	<tr>
		<td>
		<p><%=one.getqContent()%></p>
		<div class="customerQna">
		<div><%=one.getId()%></div>
		<div><%=one.getCreatedate()%></div>
		</div>
		</td>
	</tr>
</table>
<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=one.getProductNo()%>" class="genric-btn primary radius" style="font-size: 13px;">목록</a>
<%
	if(session.getAttribute("loginCstmId")!=null) { //처음부터 작성자와 관리자가 아니면 접근을 막아놨으므로 null값이 아닌 거로만 체크
%>
<a href="<%=request.getContextPath()%>/question/updateQuestion.jsp?qNo=<%=one.getqNo()%>" class="genric-btn primary-border radius" style="font-size: 13px;">수정</a>
<a href="<%=request.getContextPath()%>/question/deleteQuestionAction.jsp?qNo=<%=one.getqNo()%>&productNo=<%=productNo%>" onclick="QuestionDelete()" class="genric-btn primary-border radius" style="float: right;" style="font-size: 13px;">삭제</a>
<%
	}
%>
<script>
function QuestionDelete(){ //게시글 삭제 confirm 추가
	let result = confirm("게시글을 삭제하시겠습니까?");
	if(result){
		alert("삭제되었습니다");
	}else{
		event.preventDefault();
	    return;
	}
}
</script>
<!------------------------------ 문의 사항 답변 --------------------------------------------------->
	<br><br>
	<h4>Answer</h4>
<% 
	if((empid!=null)&&!completeAnswer){ //답변이 하나라도 있는 상태면 폼 숨김
%>
		<form id="insertAnswer" action="<%=request.getContextPath()%>/answer/insertAnswerAction.jsp" method="post">
			<input type="hidden" name="productNo" value="<%=one.getProductNo()%>"> <!-- 로그인 세션 추가해야함 admin 임시 test-->
			<input type="hidden" name="qNo" value="<%=one.getqNo()%>">
			<input type="hidden" name="id" value="<%=empid%>"> <!-- 아이디 체크 -->
			<table class="table2">
				<tr>
					<td style="padding-right: 5pt;">comment</td>
					<td>
						<textarea rows="3" cols="100" name="aContent" id="aContent" placeholder="내용을 입력하세요"></textarea>
					</td>
					<th>
					<button type="submit" class="genric-btn primary small" onclick="insertAnswer()">답변입력</button>
					</th>
				</tr>
			</table>
		</form>
<%
	}
%>
<script>
function insertAnswer() {
	let form = document.getElementById("insertAnswer");
	if (form.aContent.value.trim() === '') { // 공백 제거 후 비교
		alert('내용을 입력해주세요');
		form.aContent.focus();
		event.preventDefault();
		return;
	}

	let result = confirm("문의사항에 대한 답변을 입력하시겠습니까?");
	if (result) {
		form.submit();
		alert("답변이 등록되었습니다.");
	} else {
		event.preventDefault();
		return;
	}
}
</script>
<!---------------------------- 답변 결과셋 ----------------------------------------------------------->
<hr>
<% 
	if (aone != null){ // 답변이 있을 시
%>
	<table class="table table-borderless">
		<tr style="background-color: #F6F6F6;">
			<th>작성자</th>
			<th>내용</th>
			<th>작성일</th>
			<th></th>
			<th></th>
		</tr>
		<tr>
			<td><span class="badge rounded-pill bg-light text-dark p-2"><%=aone.getId()%></span></td>
			<td style="width : 50%;"><%=aone.getaContent()%></td>
			<td><%=aone.getCreatedate().substring(0,10)%></td>
<%
	if(empid.equals(aone.getId())) { // 해당 게시글에 답변한 관리자만 수정/삭제 가능
%>
			<td>
				<a href="<%=request.getContextPath()%>/answer/updateAnswer.jsp?qNo=<%=one.getqNo()%>&aNo=<%=aone.getaNo()%>&productNo=<%=one.getProductNo()%>" class="genric-btn primary small">수정</a>
			</td>
			<td>
				<a href="<%=request.getContextPath()%>/answer/deleteAnswerAction.jsp?aNo=<%=aone.getaNo()%>&qNo=<%=one.getqNo()%>&productNo=<%=one.getProductNo()%>" onclick="AnswerDelete()" class="genric-btn primary small">삭제</a>
			</td>
		</tr>
<%
	}
%>
	</table>
<%
	}else{
%>
	<div>문의하신 내용에 대한 답변을 준비중입니다.</div>
<%
	}
%>
</div>
<script>
function AnswerDelete(){ //답변 삭제 confirm 추가
	let result = confirm("답변을 삭제하시겠습니까?");
	if(result){
		alert("삭제되었습니다");
	}else{
		event.preventDefault();
	    return false;
	}
}
</script>
<br><br><br><br>
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