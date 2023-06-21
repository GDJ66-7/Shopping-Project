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
<html lang="zxx">
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
	//  js유효성검사 진행중 중도 하차상태(다시 복귀후 완성)
	$(document).ready(function(){
		
		// categoryNameId유효성체크
		$('#categoryNameId').change(function(){
			// 카테고리 설정하면 input창에 값 대입
			$('#categoryId').val($('#categoryNameId').val());
			// 카테고리이름길이가 0 이면 작성된것이 없으므로 메세지전송
			if($('#categoryId').val().length == 0) {
				$('#categoryNameIdMsg').text('카테고리가 설정되지 않았습니다.');
				return;
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#categoryId').val());
				// 메세지 값은 '' 으로 초기화
				$('#categoryNameIdMsg').text('');
				$('#nameId').focus();
			}
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
		
		// statusId유효성체크
		$('#statusId').change(function(){
			// 상품상태길이가 0 이면 작성된것이 없으므로 메세지전송
			if($('#statusId').val().length == 0) {
				$('#statusIdMsg').text('상품상태가 설정되지 않았습니다.');
				return;
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#statusId').val());
				// 메세지 값은 '' 으로 초기화
				$('#statusIdMsg').text('');
				$('#stockId').focus();
			}
		});
		
		// stockId유효성체크
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
			
			if($('#categoryNameId').val().length == 0) {
				// 디버깅
				console.log($('#categoryNameId').val());
				$('#categoryNameIdMsg').text('카테고리를 설정해주세요');
				return;
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
			
			if($('#statusId').val().length == 0) {
				// 디버깅
				console.log($('#statusId').val());
				$('#statusIdMsg').text('상품상태를 설정해주세요');
				return;
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
    <link rel="icon" href="<%=request.getContextPath()%>/css/img/favicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/owl.carousel.min.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/all.css">
    <!-- icon CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/flaticon.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/themify-icons.css">
    <!-- magnific popup CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/nice-select.css">
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
                        <h2>상품관리 페이지(추가)</h2>
                    </div>
                </div>
            </div>
        </div>
	</section>
    <!-- breadcrumb part end-->

	<!--================상품추가 Area =================-->
	<div class="container">
	<div class="col-12">
	<br>	
		<form id="insertProductForm" action="<%=request.getContextPath()%>/product/insertProductAction.jsp" method = "post" enctype="multipart/form-data">
			<table class="table table-bordered">
				<!-- 상품 추가 폼 -->
				<tr>
					<!-- 카테고리 선택 -->
					<th>카테고리 분류</th>
					<td>
						<select id="categoryNameId">
							<option value="">==선택하기==</option>
							<%
								for(HashMap<String, Object> cMap : cList) {
							%>
									<option value="<%=cMap.get("categoryName")%>">
										<%=cMap.get("categoryName")%>
									</option>
							<% 
								}
							%>
						</select>
						<input type="text" name = "categoryName" id="categoryId" readonly="readonly">
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
						<select id="statusId" name="productStatus">
							<option value="판매중"> 판매중</option>
							<option value="품절"> 품절</option>
							<option value="단종"> 단종</option>
						</select>	
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
			<div class="button-container">
				<span style="text-align: left;"><button class="genric-btn primary-border circle" type="button" id="productBtn">상품추가</button></span>
				<span style="text-align: right;"><button class="genric-btn danger circle arrow" type="reset">초기화</button></span>
			</div>
		</form>
	</div>
	</div>
  	<!--================End 상품추가 Area =================-->
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
                                <a href="about.html">About</a>
                                <a href="product_list.html">Products</a>
                                <a href="#">Pages</a>
                                <a href="blog.html">Blog</a>
                                <a href="contact.html">Contact</a>
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
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="ti-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></P>
                            <div class="copyright_link">
                                <a href="#">Turms AND Conditions</a>
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