상품수정

<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.ProductImg"%>
<%@page import="java.util.HashMap"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 관리자 로그인 요청값 검사 관리자2만이 상품수정 가능
	if(session.getAttribute("loginEmpId2") == null) {
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
	
	// 유효성 검사 및 변수선언
	if(request.getParameter("productNo") == null
		|| request.getParameter("productImgNo") == null) {
		response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
		return;
	}
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int productImgNo = Integer.parseInt(request.getParameter("productImgNo"));
	System.out.println(productNo + "<--- updateProduct productNo");
	System.out.println(productImgNo + "<--- updateProduct productImgNo");
	
	// updateProductDAO를 사용하기 위한 객체생성
	ProductDao pDao = new ProductDao();
	
	// 기존 상품의 정보를 보여주기 위해 해쉬맵으로 가져옴
	HashMap<String, Object> pMap = new HashMap<>();
	
	// 매개변수 값 두가지 를 넣어 보고싶은 상품의 정보를 가져옴
	pMap = pDao.productOne(productNo, productImgNo);
	
	// 수정할 카테고리는 카테고리목록에 있는것만 가능하게 하기 위해 기존 카테고리 정보 호출
	CategoryDao cDao = new CategoryDao();
	ArrayList<HashMap<String, Object>> cList = cDao.categoryNameList();
	
	// 해쉬맵에 값 잘 들어가서 출력하나 디버깅
	System.out.println(pMap.get("productNo") + "<-- updateProduct pMap.get(productNo)");
	System.out.println(pMap.get("productImgNo")  + "<-- updateProduct pMap.get(productImgNo)");
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
		$('#stockId').blur(function(){
			// 상품재고길이가 0 또는 숫자가 아니면 메세지전송하면서 focus()
			if($('#stockId').val().length == 0 || isNaN($('#stockId').val()) == true) {
				$('#stockIdMsg').text('재고량을(숫자로) 작성해야합니다.');
				$('#stockId').focus();
				return;
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#stockId').val());
				// 메세지 값은 '' 으로 초기화
				$('#stockIdMsg').text('');
				$('#infoId').focus();
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
				// 메세지 값은 '' 으로 초기화
				$('#nameIdMsg').text('상품이름을 입력해주세요');
				return;
			}
			
			if($('#priceId').val().length == 0) {
				// 디버깅
				console.log($('#priceId').val());
				// 메세지 값은 '' 으로 초기화
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
				// 메세지 값은 '' 으로 초기화
				$('#stockIdMsg').text('상품재고량을 입력해주세요');
				return;
			}
			
			if($('#infoId').val().length == 0) {
				// 디버깅
				console.log($('#infoId').val());
				// 메세지 값은 '' 으로 초기화
				$('#infoIdMsg').text('상품정보를 입력해주세요');
				return;
			}
			
			if($('#fileId').val().length == 0) {
				// 디버깅
				console.log($('#fileId').val());
				// 메세지 값은 '' 으로 초기화
				$('#fileIdMsg').text('상품사진을 설정해주세요');
				return;
			}
			
			$('#updateProductForm').submit();
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
                        <h2>상품관리 페이지(수정)</h2> 
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
		<form id="updateProductForm" action="<%=request.getContextPath()%>/product/updateProductAction.jsp" method="post" enctype="multipart/form-data">
			<input type="hidden" name="productNo" value="<%=pMap.get("productNo") %>">
			<input type="hidden" name="productImgNo" value="<%=pMap.get("productImgNo") %>">
			<table class="table table-bordered">
				<tr>
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
						<input type="text" name = "categoryName" id="categoryId" readonly="readonly" placeholder="기존 카테고리 :<%=pMap.get("categoryName")%>">
						<span id="categoryNameIdMsg" class="msg"></span>
					</td>
				</tr>
				
				<tr>
					<th>상품 이름</th>
					<td>
						<input type="text" name="productName" id="nameId" placeholder="기존이름 :<%=pMap.get("productName")%>">
						<span id="nameIdMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td>
						<input type="text" name="productPrice" id="priceId" placeholder="기존가격 :<%=pMap.get("productPrice")%>">
						<span id="priceIdMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>상품 상태 기존 상태 : <%=pMap.get("productStatus")%></th>
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
					<th>상품 재고</th>
					<td>
						<input type="text" name="productStock" id="stockId" placeholder="기존재고량 :<%=pMap.get("productStock")%>">
						<span id="stockIdMsg" class="msg"></span>
					</td>
				</tr>
				
				<tr>
					<th>상품 정보</th>
					<td>
						<textarea rows="3" cols="50" name="productInfo" id="infoId" placeholder="기존설명 :<%=pMap.get("productInfo") %>"></textarea>				
						<span id="infoIdMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>boardFile(수정전 사진이름 : <%=pMap.get("productOriFilename")%></th>
					<td>
						<input id="fileId" type="file" name="productFile">
						<span id="fileIdMsg" class="msg"></span>
					</td>
				</tr>
			</table>
			<div class="button-container">
			  <span style="text-align: left;"><button class="genric-btn primary circle" type="button" id="productBtn">상품수정</button></span>
			  <span style="text-align: right;"><button class="genric-btn danger circle arrow" type="reset">초기화</button></span>
			</div>
		</form>
    </div>
    </div>
  <!-- ================ contact section end ================= -->

  <!--::footer_part start::-->
  	<footer class="footer_part">
		<div class="footer_iner">
	    	<div class="container">
                <div class="row justify-content-between align-items-center">
                    <div class="col-lg-8">
                        <div class="footer_menu">
                            <div class="footer_logo">
                                <a href="index.html"><img src="<%=request.getContextPath()%>/css/img/logo.png" alt="#"></a>
                            </div>
                            <div class="footer_menu_item">
                                <a href="<%=request.getContextPath()%>/main/home.jsp">Home</a>
                                <a href="<%=request.getContextPath()%>/main/home.jsp">회사개요</a>
                                <a href="<%=request.getContextPath()%>/product/productList.jsp">상품</a>
                                <a href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지사항</a>
                                <a href="<%=request.getContextPath()%>/employee/employeeInfo.jsp">관리자정보</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="social_icon">
                            <a href="https://ko-kr.facebook.com"><i class="fab fa-facebook-f"></i></a>
                            <a href="https://www.instagram.com"><i class="fab fa-instagram"></i></a>
                            <a href="https://google.com"><i class="fab fa-google-plus-g"></i></a>
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
shopping &copy;<script>document.write(new Date().getFullYear());</script> 저희 ** 쇼핑몰은 고객과 소통하면서 만들어갑니다.<i class="ti-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">GDJ66</a><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></P>
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