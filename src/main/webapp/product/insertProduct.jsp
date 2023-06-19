<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 상품추가시 카테고리를 분류해야하는데 카테고리는 외래키로 지정되어 있어 기존 값에서 선택해야한다
	// 그러므로 카테고리 name리스트를 출력해 선택할 수 있도록 했다.
	CategoryDao cDao = new CategoryDao();
	ArrayList<HashMap<String, Object>> cList = cDao.categoryNameList();
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	//  js유효성검사 진행중 중도 하차상태(다시 복귀후 완성)
	$(document).ready(function(){
		
		// 카테고리체크박스 선택시
		$('.categoryCheckbox').change(function() {
			// 체크박스의 값을 출력할 배열선언
		    let checkedValues = [];
			
	    	$('.categoryCheckbox:checked').each(function() {
	    		// checkbox 값을 push로 넣음
	      		checkedValues.push($('.categoryCheckbox').val());
	    	});
	    	// 선택된 checkbox값 출력
	    	console.log(checkedValues);
	  	});
	
		// nameId유효성체크
		$('#nameId').blur(function(){
			// 상품이름길이가 0 이면 작성된것이 없으므로 메세지전송
			if($('#nameId').val().length == 0) {
				$('#nameIdMsg').text('상품이름을 작성해야합니다.');
				return;
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#nameId').val());
				// 메세지 값은 '' 으로 초기화
				$('#nameIdMsg').text('');
				$('#priceId').focus();
			}
		});
		
		
		// priceId유효성체크
		$('#priceId').blur(function(){
			// 상품가격길이가 0 또는 숫자가 아니면 메세지전송하면서 focus()
			if($('#priceId').val().length == 0 || isNaN($('#priceId').val()) == true) {
				$('#priceIdMsg').text('상품가격을(숫자로) 작성해야합니다.');
				$('#priceId').focus();
				return;
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#priceId').val());
				// 메세지 값은 '' 으로 초기화
				$('#priceIdMsg').text('');
				$('#statusId').focus();
			}
		});
		
		// 상태체크박스 선택시
		$('.status').change(function() {
			// 체크박스의 값을 출력할 배열선언
		    let statusValues = [];
			
	    	$('.status:checked').each(function() {
	    		// checkbox 값을 push로 넣음
	      		statusValues.push($('.status').val());
	    	});
	    	// 선택된 checkbox값 출력
	    	console.log(statusValues);
	  	});
		
		// statusId유효성체크
		$('#stockId').change(function(){
			// 상품상태길이가 0 이면 작성된것이 없으므로 메세지전송
			if($('#stockId').val().length == 0) {
				$('#stockIdMsg').text('상품재고량이 설정되지 않았습니다.');
				return;
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#stockId').val());
				// 메세지 값은 '' 으로 초기화
				$('#stockIdMsg').text('');
				$('#stockId').focus();
			}
		});

		// infoId유효성체크
		$('#infoId').blur(function(){
			
			// 상품정보길이가0 이면 메세지전송
			if($('#infoId').val().length == 0) {
				$('#infoIdMsg').text('상품정보를 작성해야합니다');
				return;
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#infoId').val());
				// 메세지 값은 '' 으로 초기화
				$('#infoIdMsg').text('');
			}
		});
		// 최대 글자 제한수 100자
		const maxCnt = 100;
		$('#infoId').keyup(function(){
			// 작성한 글자수의 총개수
			let len = $('#infoId').val().length;
			if(len > maxCnt) {
				// 작성한 글자수가 제한수(100)보다 클경우 0 ~ 100자까지만남기고 자른다
				let str = $('#infoId').val().substring(0, maxCnt);
				// 잘려서 남은 글자를 (str)로다시 집어넣는다.
				$('#infoId').val(str);
				$('#infoIdMsg').text(maxCnt + '자까지만 입력가능합니다');
			} else {
				$('#infoIdMsg').text('(100자이하)현재 글자 수 :' + len);
			}
		});
		
		
		// fileId유효성체크
		$('#fileId').blur(function(){
			// 상품파일이름길이가 1000 보다 크면 메세지전송
			if($('#fileId').val().length == 0) {
				$('#fileIdMsg').text('사진을 넣어야합니다');
				return;
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#fileId').val());
				// 메세지 값은 '' 으로 초기화
				$('#fileIdMsg').text('');
			}
		});
		
		
		// 전송 유효성검사 하나라도 값이 입력되지 않으면 submit이 수행되지 않음.
		$('#productBtn').click(function(){
			
			// 카테고리가 선택이 안됬거나 두개 이상이면
			if($('.categoryCheckbox:checked').length != 1) {
				$('#categoryNameIdMsg').text('카테고리를 1개선택해주세요');
				return;
			// 제대로 선택되면
			} else {
				$('#categoryNameIdMsg').text('');
			}
			
			if($('#nameId').val().length == 0) {
				// 디버깅
				console.log($('#nameId').val());
				$('#nameIdMsg').text('상품이름을 입력해주세요');
				return;
			}
			
			if($('#priceId').val().length == 0) {
				// 디버깅
				console.log($('#priceId').val());
				$('#priceIdMsg').text('상품가격을 입력해주세요');
				return;
			}
			
			// 상품상태가 선택이 안됬거나 두개 이상이면
			if($('.status:checked').length != 1) {
				$('#statusIdMsg').text('상품상태를 1개선택해주세요');
				return;
			// 제대로 선택되면
			} else {
				$('#statusIdMsg').text('');
			}
			
			if($('#stockId').val().length == 0) {
				// 디버깅
				console.log($('#stockId').val());
				$('#stockIdMsg').text('상품재고량을 입력해주세요');
				return;
			}
			
			if($('#infoId').val().length == 0) {
				// 디버깅
				console.log($('#infoId').val());
				$('#infoIdMsg').text('상품정보를 입력해주세요');
				return;
			}
			
			if($('#fileId').val().length == 0) {
				// 디버깅
				console.log($('#fileId').val());
				$('#fileIdMsg').text('상품사진을 설정해주세요');
				return;
			}
			
			$('#insertProductForm').submit();
		});
	});	
		
		
	
</script>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>pillloMart</title>
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
    <header class="main_menu home_menu">
        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-lg-12">
                    <nav class="navbar navbar-expand-lg navbar-light">
                        <a class="navbar-brand" href="/Shopping/main/home.jsp"> <img src="/Shopping/css/img/logo.png" alt="logo"> </a>
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
                              <a href="/Shopping/cart/cartList.jsp">
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
    <section class="breadcrumb_part" style = "height :200px;">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>상품관리 페이지</h2> 
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
	<form id="insertProductForm" action="<%=request.getContextPath()%>/product/insertProductAction.jsp" method = "post" enctype="multipart/form-data">
		<div class="row">
			<table class="table table-bordered">
				<!-- 상품 추가 폼 -->
				<tr>
					<!-- 카테고리 선택 -->
					<th>카테고리 분류</th>
					<td>
						<ul>
							<li>
	                     		<%
	                            	for(HashMap<String, Object> categoryNameMap : cList) {
	                            %>	
	                            		<input id="categoryNameId" class="categoryCheckbox" type="checkbox" name="categoryName" value="<%= categoryNameMap.get("categoryName") %>" autocomplete="off">
	                             		<%=categoryNameMap.get("categoryName")%>
	                            <% 	
	                             			
	                             	}
	                            %>
	                    	</li>
						</ul>
						<span id="categoryNameIdMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>상품 이름</th>
					<td>
						<input type="text" id="nameId" name="productName" >
						<span id="nameIdMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td>
						<input type="text" id="priceId" name="productPrice" placeholder="숫자만 입력해주세요">
						<span id="priceIdMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<!--  ENUM으로 값이 설정되어 있어 세가지중 하나를 선택하여 보냄 -->
					<th>상품 상태</th>
					<td>
						<ul>
							<li>
								<input type="checkbox" name="productStatus" class="status" value="판매중">판매중
								<input type="checkbox" name="productStatus" class="status" value="품절">품절
								<input type="checkbox" name="productStatus" class="status" value="단종">단종
							</li>
						</ul>
						<span id="statusIdMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>상품 재고량</th>
					<td>
						<input type="text" id="stockId" name="productStock" placeholder="숫자로 입력해주세요">
						<span id="stockIdMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>상품 정보</th>
					<td>
						<textarea rows="3" cols="50" id="infoId" name="productInfo"></textarea>
						<span id="infoIdMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>상품 사진</th>
					<td>
						<!-- 사진 파일 전송 -->
						<input type="file" id="fileId" name="productFile">
						<span id="fileIdMsg" class="msg"></span>
					</td>
				</tr>
			</table>
			<button class="genric-btn primary-border circle" type="button" id="productBtn">상품추가</button>
			<button type="reset">초기화</button>
		</div>
	</form>
    </div>
    </div>
  <!-- ================ contact section end ================= -->

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