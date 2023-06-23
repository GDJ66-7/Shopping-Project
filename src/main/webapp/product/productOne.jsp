<!-- view 상품 상세정보 페이지 카테고리/상품이름/가격/상태/(재고)/정보 -->
<!-- 상세정보/리뷰/상품문의 다 같이 있기때문에 변수명 유의 -->
<%@ page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//cnt & 재고량(장바구니) & 할인값 받아오기
	//상품 상세페이지 productNo 유효성 검사
	if(request.getParameter("productNo") == null
	||request.getParameter("productNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
		return;
	}

	// 로그인 세션 - 상품 상세페이지 내에 있는 게시글 추가 삭제 기능 분리
	// 관리자1 loginEmpId1, 최고관리자 세션이름 loginEmpId2, 고객 세션이름 loginCstmId
	String id = "";
	if(session.getAttribute("loginCstmId") != null) { //loginCstmId = 현재 로그인한 고객아이디
		id = (String)session.getAttribute("loginCstmId");
	}
	System.out.println(id+"<---productOne cstm id 관리자 로그인일 때 null");
	
	// 로그인 세션(2) 관리자 admin&user1 -- 문의글 접근 위함 
	String empid = "";
	if(session.getAttribute("loginEmpId1") != null) { //loginEmpId1&loginEmpId2 = 현재 로그인한 관리자아이디
		empid = (String)session.getAttribute("loginEmpId1");
	} else {
		empid = (String)session.getAttribute("loginEmpId2");
	}
	System.out.println(empid+"<---login empid 고객 로그인일 때 null");
	
	// 리스트에서 받아온 값
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	OneDao one = new OneDao();

	// DAO 사용
	HashMap<String,Object> p = one.selectProductOne(productNo);
	
	// 상품가격 천단위 표시
	DecimalFormat dc = new DecimalFormat("###,###,###");
	
//-------------------------------------------------------------------------------------------------
	
	// 해당 상품 - 리뷰 페이징 -------------------------------------------------------------------------
	// 페이징 다른 페이지 연동 오류 --- where product_no 조건 안 줌 --- 수정
	// 페이징 1) 현재 페이지
	int revcurrentPage = 1;
	if(request.getParameter("revcurrentPage")!=null){ // 유효한 값이면 정상 출력
		revcurrentPage = Integer.parseInt(request.getParameter("revcurrentPage"));
	}
	
	// 페이징 2) 전체 페이지 (dao 쓰겠다 선언) -- 리뷰 페이징 변수는 앞에 'rev' 붙임
	ReviewDao review = new ReviewDao();
	int revtotalRow = review.selectReviewCnt(productNo); //dao 전체 row
	int revrowPerPage = 5; // 페이지 당 행의 수 5개씩 출력할 것
	int revbeginRow = (revcurrentPage-1) * revrowPerPage; //시작 행 - 0부터
	
	// 페이징 3) 페이지 네비게이션 (하단 페이징)
	int revpagePerPage = 5; // 하단 페이징 숫자
	int revlastPage = revtotalRow / revrowPerPage; // 마지막 페이지
	if(revtotalRow % revrowPerPage != 0){ // 나누어 떨어지지 않으면 페이지 +1 하여 넘어감
		revlastPage = revlastPage + 1;
	}
	
	// minpage : 하단 페이징 가장 작은 수
	int revminPage = ((revcurrentPage -1) / revpagePerPage) * revpagePerPage + 1;
	
	// maxpage : 하단 페이징 가장 큰 수
	int revmaxPage = revminPage + revpagePerPage -1;
	if(revmaxPage > revlastPage) {
		revmaxPage = revlastPage;
	}
	
	ArrayList<HashMap<String,Object>> rlist = review.selectReviewListByPage(productNo, revbeginRow, revrowPerPage);
	
//-----------------------------------------------------------------------------------------------------
	
	// 해당 상품 - 문의 페이징 --------------------------------------------------------------------------
	// 페이징 1) 현재 페이지
	int currentPage = 1; // 페이지 시작은 1
	if(request.getParameter("currentPage")!=null){ // 유효한 값이면 정상 출력
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	// 페이징 2) 전체 페이지
	QuestionDao questionDao = new QuestionDao();
	int totalRow = questionDao.selectQuestionCnt(productNo); //dao 전체 row
	int rowPerPage = 5;  // 페이지 당 행의 수 5개씩 출력할 것
	int beginRow = (currentPage-1) * rowPerPage; //시작 행
	
	// 페이징 3) 페이지 네비게이션 (하단 페이징)
	int pagePerPage = 5; // 하단 페이징 숫자
	
	int lastPage = totalRow / rowPerPage; //마지막 페이지
	if(totalRow % rowPerPage != 0){ // 나누어 떨어지지 않으면 페이지 +1 하여 넘어감
		lastPage = lastPage + 1;
	}
	
	// minpage : 하단 페이징 가장 작은 수
	int minPage = ((currentPage -1) / pagePerPage) * pagePerPage + 1;
	
	// maxpage : 하단 페이징 가장 큰 수
	int maxPage = minPage + pagePerPage -1;
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}
	
	ArrayList<HashMap<String,Object>> list = questionDao.selectQuestionListByPage(productNo, beginRow, rowPerPage);
	
%>
<!DOCTYPE html>
<html lang="zxx">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>상품 상세페이지</title>
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
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}
#re{
font-weight: bold;
font-family: 'Pretendard-Regular';
}
#pn{
font-family: 'Pretendard-Regular';
font-size: 17px;
}
#cn{
font-family: 'Pretendard-Regular';
color: #747474;
}
#pi{
font-family: 'Pretendard-Regular';
font-size: 17px;
}
#dp{
color: #B08EAD;
}
#dpone{
font-size: 20px;
}
.single_product_breadcrumb {
    height: 200px !important;
}
.card_area {
    margin-top: 30px;
}
.productInfo {
  height: 300px;
  max-height: 300px;
}
.col-md-5{
  display: flex;
}
a{
color: #000000;
}
a:hover{
color: #B08EAD;
}
#productPrice{
font-family: 'Pretendard-Regular';
font-weight: 700;
font-size: 17px; }
.genric-btn{
    display: inline-block;
    outline: none;
    line-height: 2;
    padding:0px 10px;
}
</style>
<body>
	<header>
    <!--::header part start::-->
    <!-- 메인메뉴 바 -->
		<jsp:include page="/main/menuBar.jsp"></jsp:include>
	</header>
    <!-- Header part end-->
<!-- breadcrumb part start-->
<section class="breadcrumb_part single_product_breadcrumb">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb_iner">
                <h2>product</h2>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- breadcrumb part end-->
<!--================Single Product Area =================-->
<br>
<div class="container mt-3">
	<input type="hidden" name="productStock" id="stock" value="<%=p.get("productStock")%>">
		<div class="row">
			<div class="col-md-5">
				<img src="${pageContext.request.contextPath}/product/productImg/<%=p.get("productSaveFilename")%>">
			</div>
			<div class="col-md-7">
				<div class="productInfo">
					<table class="table">
						<tr>
							<td id="cn">category > <%=p.get("categoryName")%></td><!-- 상품 카테고리 -->
						</tr>						
						<tr>
							<td id="pn"><%=p.get("productName")%></td><!-- 상품이름 -->
						</tr>
						<!-- 할인가 / 원가 -->
						<%
							double discountRate = (double)p.get("discountRate");
							int discountRateP = (int)(discountRate*100);
							int productPrice = (Integer)p.get("productPrice");
							double discountPrice = productPrice - (productPrice * discountRate);
							if(discountPrice == productPrice){
						%>
						<tr>
							<td id="productPrice"><%=dc.format(p.get("productPrice"))%>원</td>
						</tr>
						<%
							}else{
						%>
						<tr>
							<!-- ₩ -->
							<td id="productPrice">
							<span id="dp"><%=discountRateP%>% <s><%=dc.format(p.get("productPrice"))%></s></span><br>
							<span id="dpone"><%=dc.format(discountPrice)%>원</span></td>
						</tr>
						<%
							}
						%>
						<tr>
							<td id="pi"><%=p.get("productInfo")%></td>
						</tr>
					</table>
				</div>
			<!-- 장바구니 담기 버튼 -->
				<form id="addCart" action="<%=request.getContextPath()%>/cart/insertCartAction.jsp" method="post">
					<input type="hidden" name="productNo" value="<%=p.get("productNo")%>">
					<input type="hidden" name="id" value=<%=id%>>
					<br><br>
					<div class="card_area">
            		<!-- 장바구니 수량 check - input은 최종 개수만 보냄 -->
                     	<span id="deQuantity" class="btn btn-outline-light text-dark"><i class="ti-minus"></i></span> <!-- 수량(-) -->
                     	<input type="text" name="cartCnt" id="selectCnt" value="1" readonly="readonly" class="btn" style="width: 60px;"> <!-- 수량 count -->
                     	<span id="upQuantity"  class="btn btn-outline-light text-dark"><i class="ti-plus"></i></span> <!-- 수량(+) -->
                  		<div><br>
                  		<button id="addToCart" class="btn_3">add to cart</button>
                  		</div>
              		</div>
				</form>
			</div>
		</div><!-- 전체 div는 맨 아래에 -->
<!--================End Single Product Area =================-->
<!-- 2) 상품 리뷰 -------------------------------------------------------------------------->
<br><br>
	<h3 id="re">리뷰</h3>
	<!-- 마이페이지 작성/로그인 세션 테스트 하기 위해서 남겨둠 -->
	<!-- <a href="<%=request.getContextPath()%>/review/insertReview.jsp?productNo=<%=productNo%>&historyNo=<%=2%>">추가</a>-->
	<!--------------------------------------------->
	<table class="table" id="productReview">
		<tr>
			<th style="width : 50%;">제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
<%
	if(rlist.isEmpty()){ //isEmpty = 리스트 null 체크
%>
		<tr>
			<td colspan="3">등록된 리뷰가 없습니다.</td>
		</tr>
<%
	}else{
		for(HashMap<String,Object> r : rlist){
%>
		<tr>
			<td style="width : 50%;">
			<a href="<%=request.getContextPath()%>/review/reviewOne.jsp?historyNo=<%=r.get("historyNo")%>&productNo=<%=r.get("productNo")%>">
			<%=r.get("reviewTitle")%></a>
			</td>
			<td><%=r.get("id")%></td>
			<td><%=r.get("createdate")%></td>
		</tr>
<%
		}
	}
%>
	</table>
<!-------------- 리뷰목록 페이징 버튼  -------------------------------------------------------->
	<div>
	<%
		if(revminPage > 1) { //minpage가 1보다 클때 이전 페이지 출력
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&revcurrentPage=<%=revminPage-revpagePerPage%>" class="genric-btn default radius">이전</a>
	<%
			}
		for(int r = revminPage; r<=revmaxPage; r=r+1) {
			if(r == revcurrentPage){
	%>
			<span class="genric-btn default radius"><%=r%></span>		
	<%			
			}else{	
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&revcurrentPage=<%=r%>">
		<span class="genric-btn default radius"><%=r%></span>
		</a>
	<%
			}
		}	
		if(revmaxPage != revlastPage) { // maxpage와 lastpage가 같지 않을 때 다음 출력
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&revcurrentPage=<%=revminPage+revpagePerPage%>" class="genric-btn default radius">다음</a>
	<%
		}
	%>
	</div>
<br>
<!-- 3) 상품 문의사항 ----------------------------------------------------------------------->
	<h3 id="re">상품 Q&A</h3>
	<!-- 로그인 하지 않은 상태에서 문의하기를 누르면 로그인폼으로 이동 -->
	<a href="<%=request.getContextPath()%>/question/insertQuestion.jsp?productNo=<%=productNo%>&productName=<%=p.get("productName")%>" class="genric-btn primary small">문의하기</a>
	<br><br>
	<div id="productQnA">
	<table class="table">
		<tr>
			<th>제목</th>
			<th>문의유형</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
<%
	if(list.isEmpty()){ //isEmpty = 리스트 null 체크
%>
	<tr>
		<td colspan="4">등록된 게시글이 없습니다.</td>
	</tr>
<%
	}else{
	for(HashMap<String,Object> q : list){
		
%>
		<tr>
			<td style="width : 50%;">
			<a href="<%=request.getContextPath()%>/question/questionOne.jsp?qNo=<%=q.get("qNo")%>&productNo=<%=q.get("productNo")%>">
			<%=q.get("title")%>
			</a>
			</td>
			<td><%=q.get("category")%></td>
			<td><%=q.get("id")%></td>
			<td><%=q.get("createdate")%></td>
		</tr>
<%
		}
	}
%>
	</table>
	</div>
	<!-------------- 문의 사항 페이징 버튼 -------------------------------------------------------->
	<div>
	<%
		if(minPage > 1) { //minpage가 1보다 클때 이전 페이지 출력
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&currentPage=<%=minPage-pagePerPage%>" class="genric-btn default radius">이전</a>
	<%
			}
		for(int i = minPage; i<=maxPage; i=i+1) {
			if(i == currentPage){
	%>
			<span class="genric-btn primary radius"><%=i%></span><!-- 현재페이지 -->
	<%			
			}else{	
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&currentPage=<%=i%>">
		<span class="genric-btn default radius"><%=i%></span>
		</a>
	<%
			}
		}	
		if(maxPage != lastPage) { // maxpage와 lastpage가 같지 않을 때 다음 출력
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&currentPage=<%=minPage+pagePerPage%>" class="genric-btn default radius">다음</a>
	<%
		}
	%>
	</div>
<!-- 페이징 로드 -->
<br>
</div>
<script>
// 장바구니 버튼 ----------------------------------------------------------
		$(document).ready(function() {
		    $("#addToCart").click(function(event) {
		        let stock = parseInt($("#stock").val());  // 상품 잔여 수량
		        let quantity = parseInt($("#selectCnt").val());  // 선택한 수량
		        if (quantity > stock) { // 상품의 수량을 초과할 시
		            alert("최대 주문개수를 초과하였습니다.");
		            event.preventDefault();  // = 기본 동작을 취소하고 폼 제출을 막는 메서드
		        } else if (confirm("장바구니에 추가하시겠습니까?")) {
		            $("#addCart").submit();  // confirm(boolean타입) 확인 true = 폼 제출
		        } else {
		            event.preventDefault();  // 취소 false
		            $("#addCart")[0].reset();  // addCart 폼 초기화
		        }
		    });

        // 수량 증가 버튼
        $("#upQuantity").click(function() {
            let cartCnt = $("#selectCnt");
            let quantity = parseInt(cartCnt.val());
            let stock = parseInt($("#stock").val());
            if (quantity < stock) {  // 선택한 수량이 잔여 수량보다 작은 경우 계속 추가 가능 (+)
                cartCnt.val(quantity + 1);
            } else {
                alert("최대 주문개수를 초과하였습니다.");
            }
        });

        // 수량 감소 버튼 (value=1 (기본선택값))
        $("#deQuantity").click(function() {
            let cartCnt = $("#selectCnt");
            let quantity = parseInt(cartCnt.val());
            if (quantity > 1) {
                cartCnt.val(quantity - 1);
            }
        });
  	});
  		
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