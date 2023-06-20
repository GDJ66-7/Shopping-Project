<!-- view 상품 상세정보 페이지 카테고리/상품이름/가격/상태/(재고)/정보 -->
<!-- 상세정보/리뷰/상품문의 다 같이 있기때문에 변수명 유의 -->
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

<!-- <ul class="tab-tit">
<li><a href="#productOne" role="button">상품 상세정보</a></li>

<li><a href="#productReview" role="button">고객리뷰</a></li>
<li><a href="#productQnA" role="button">상품 Q&amp;A</a></li>
</ul> -->
<div class="container mt-3">
	<h3>상품상세</h3>
	<input type="hidden" name="productStock" id="stock" value="<%=p.get("productStock")%>">
	<table class="table" id="productOne">
		<tr>
			<td>카테고리 :<%=p.get("categoryName")%></td><!-- 상품 카테고리 -->
		</tr>
		<tr>
			<td><img src="${pageContext.request.contextPath}/product/productImg/<%=p.get("productSaveFilename")%>" width="100" height="100"></td>
		</tr>
		<tr>
			<td><%=p.get("productName")%></td><!-- 상품이름 -->
		</tr>
		<tr>
			<td><%=p.get("productPrice")%>원</td><!-- 상품가격 -->
		</tr>
		<tr>
			<td><%=p.get("productInfo")%></td><!-- 상품정보 -->
		</tr>
	</table>
	<!-- 장바구니 담기 버튼 -->
	<form id="addCart" action="<%=request.getContextPath()%>/cart/insertCartAction.jsp" method="post">
	<input type="hidden" name="productNo" value="<%=p.get("productNo")%>">
	<input type="hidden" name="id" value=<%=id%>>
	<input type="button" name="minus" id="deQuantity" value="-"><!-- 수량(-) -->
	<input type="text" name="cartCnt" id="selectCnt" value="1" readonly="readonly"><!-- 수량count -->
	<input type="button" name="plus" id="upQuantity" value="+" ><!-- 수량(+) -->
	<button id="addToCart">장바구니에 담기</button><!-- 장바구니 버튼 클릭 시 addToCart 함수 호출 -->
	</form>
<!-- 2) 상품 리뷰 -------------------------------------------------------------------------->
<hr>
	<h3>상품리뷰</h3>
	<!-- 마이페이지 작성/로그인 세션 테스트 하기 위해서 남겨둠 -->
	<a href="<%=request.getContextPath()%>/review/insertReview.jsp?productNo=<%=productNo%>&historyNo=<%=2%>">추가</a>
	<!--------------------------------------------->
	<table class="table" id="productReview">
		<tr>
			<th>제목</th>
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
			<td>
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
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&revcurrentPage=<%=revminPage-revpagePerPage%>">이전</a>
	<%
			}
		for(int r = revminPage; r<=revmaxPage; r=r+1) {
			if(r == revcurrentPage){
	%>
			<span><%=r%></span>		
	<%			
			}else{	
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&revcurrentPage=<%=r%>">
		<%=r%>
		</a>
	<%
			}
		}	
		if(revmaxPage != revlastPage) { // maxpage와 lastpage가 같지 않을 때 다음 출력
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&revcurrentPage=<%=revminPage+revpagePerPage%>">다음</a>
	<%
		}
	%>
	</div>
<br>
<!-- 3) 상품 문의사항 ----------------------------------------------------------------------->
	<h3>문의사항</h3>
<%
	if(session.getAttribute("loginCstmId")!=null) { // 로그아웃 상태면 문의하기 버튼이 보이지 않는다. 로그인 상태면 모든 고객이 작성 가능
%>
	<a href="<%=request.getContextPath()%>/question/insertQuestion.jsp?productNo=<%=productNo%>">문의하기</a>
<%
	}
%>
	<table class="table" id="productQnA">
		<tr>
			<th>문의유형</th>
			<th>제목</th>
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
			<td><%=q.get("category")%></td>
			<td>
			<a href="<%=request.getContextPath()%>/question/questionOne.jsp?qNo=<%=q.get("qNo")%>&productNo=<%=q.get("productNo")%>">
			<%=q.get("title")%>
			</a>
			</td>
			<td><%=q.get("id")%></td>
			<td><%=q.get("createdate")%></td>
		</tr>
<%
		}
	}
%>
	</table>
	<!-------------- 문의 사항 페이징 버튼 -------------------------------------------------------->
	<div>
	<%
		if(minPage > 1) { //minpage가 1보다 클때 이전 페이지 출력
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&currentPage=<%=minPage-pagePerPage%>">이전</a>
	<%
			}
		for(int i = minPage; i<=maxPage; i=i+1) {
			if(i == currentPage){
	%>
			<span><%=i%></span>		
	<%			
			}else{	
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&currentPage=<%=i%>">
		<%=i%>
		</a>
	<%
			}
		}	
		if(maxPage != lastPage) { // maxpage와 lastpage가 같지 않을 때 다음 출력
	%>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&currentPage=<%=minPage+pagePerPage%>">다음</a>
	<%
		}
	%>
	</div>
<br>
</div>
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