<%@ page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ProductDao pDao = new ProductDao();
	
	ArrayList<HashMap<String, Object>> productList = pDao.productListLimit3();
	
	ArrayList<HashMap<String, Object>> productList2 = pDao.productListLimit6();
	
%>

<!doctype html>
<html lang="zxx">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>GDJ-Mart</title>
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
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Slick 슬라이더 스타일 -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick.css">
    <!-- Slick 라이브러리 -->
    <script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick.min.js"></script>
</head>

<body>
    <!--::header part start::-->
    <!-- 메인메뉴 바 -->
	<jsp:include page="/main/menuBar.jsp"></jsp:include>
    <!-- Header part end-->

    <!-- banner part start-->
    <section class="banner_part">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-5">
                    <div class="banner_text">
                        <div class="banner_text_iner">
                            <h1>Best quality
                                furniture</h1>
                            <p>"Experience products made with the finest ingredients."</p>
                            <a href="<%=request.getContextPath()%>/product/productList.jsp" class="btn_1">Shop</a>
                            <a href="<%=request.getContextPath()%>/product/productList.jsp?discountProduct=할인상품" class="btn_1">SALE</a>
                       </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="banner_img">
        	<div class="slider-image">
        		<a href="<%=request.getContextPath()%>/product/productList.jsp">
           			<img style="width: 1200px; height: 650px" src="<%=request.getContextPath()%>/main/mainImg/main.jpg" alt="#" class="img-fluid">
           		</a>
            </div>
        	<div class="slider-image">
        		<a href="<%=request.getContextPath()%>/product/productList.jsp?discountProduct=할인상품">
           			<img style="width: 1200px; height: 650px" src="<%=request.getContextPath()%>/main/mainImg/saleMain.jpg" alt="#" class="img-fluid">
           		</a>
            </div>
        	<div class="slider-image">
        		<a href="<%=request.getContextPath()%>/product/productList.jsp">
           			<img style="width: 1200px; height: 650px" src="<%=request.getContextPath()%>/main/mainImg/main2.jpg" alt="#" class="img-fluid">
           		</a>
            </div>
        </div>
    </section>
    
    <script>
	    $(document).ready(function(){
	        $('.banner_img').slick({
	            dots: false, // 하단에 버튼여부
	            autoplay: true, // 자동 재생 여부
	            autoplaySpeed: 3000, // 자동 재생 간격 (3초)
	            arrows: false // 이전/다음 버튼 숨김
	        });
	    });
    </script>
 	<!-- banner part end-->
    <!-- product list start-->
    <br>
    <br>
    <br>
   	<div class="col-lg-12"> 
       	<h2 style="text-align: center;">최신상품</h2>
       		<div class="row">
               	<!--  기존 사진 <img src="<%=request.getContextPath()%>/css/img/single_product_1.png" class="img-fluid" alt="#">-->                                  
 				<%
                	for(HashMap<String,Object> map : productList) {
                		// 상품가격단위을 1000단위마다,를 넣기위해 NumberForMat클래스 사용
    					java.text.NumberFormat numberFormat = java.text.NumberFormat.getInstance();
    					String productPrice = numberFormat.format(map.get("productPrice"));
                %>
	                 	<div style="text-align: center;" class="col-lg-3">
	                 		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=map.get("productNo")%>&productImgNo=<%=map.get("productImgNo")%>" style="display: block; text-align: center;">
	                 			<img src="${pageContext.request.contextPath}/product/productImg/<%=map.get("productSaveFilename") %>" width="350" height="350">
	                 		</a>
	                 		<span style="font-size: 15px; font: bolder;">
	                				<%=map.get("productName") %>
	                			</span>
	                			
	                 		<span style="display: block; font-weight: bold; font-size: 20px;">
	                 			<%=productPrice %> ₩
	                 		</span>	
	                 		<br>
	                    </div>
                <% 	
                	}
                %>                                   
    		</div>
	</div>
    <!-- product list end-->
    
    
    
    <!-- trending item start-->
    <br>
    <br>
    <section class="trending_items">
    	<div class="row">
        	<div class="col-lg-12">
            	<div class="section_tittle text-center">
                	<h2>인기 상품 Top6</h2>
                </div>
            </div>
        </div>
        <div class="row">
        	<%
            	for(HashMap<String,Object> proMap : productList2) {
             		// 상품가격단위을 1000단위마다,를 넣기위해 NumberForMat클래스 사용
  					java.text.NumberFormat numberFormat = java.text.NumberFormat.getInstance();
  					String productPrice = numberFormat.format(proMap.get("productPrice"));
            %>
             		<div style="text-align: center;" class="col-lg-4">
             		<div class="single_product_item">
             			<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=proMap.get("productNo")%>&productImgNo=<%=proMap.get("productImgNo")%>">
             				<img src="${pageContext.request.contextPath}/product/productImg/<%=proMap.get("productSaveFilename") %>" width="400" height="400">
             			</a>
             			<br>
             			<!--  <p style="font-weight: bold; font-size: 18px;"><%=proMap.get("productName") %></p>-->
             				<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=proMap.get("productNo")%>&productImgNo=<%=proMap.get("productImgNo")%>">
             					<span style="font-size: 15px; color: black; font: bold;"><%=proMap.get("productName") %></span>
                 			</a> 
                 		<p>
                 			<%=productPrice %> ₩
                 		</p>
             		</div>
                 	</div>
            <% 
             		}
            %>
          </div>
    </section>
    <!-- trending item end-->

    <!-- client review part here -->
    <section class="client_review">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="client_review_slider owl-carousel">
                        <div class="single_client_review">
                            <div class="client_img">
                                <img src="<%=request.getContextPath()%>/css/img/goowon.png" alt="#">
                            </div>
                            <p>"구원이1"</p>
                            <h5>- Micky Mouse</h5>
                        </div>
                        <div class="single_client_review">
                            <div class="client_img">
                                <img src="<%=request.getContextPath()%>/css/img/goowon2.png" alt="#">
                            </div>
                            <p>"구원이2"</p>
                            <h5>- Micky Mouse</h5>
                        </div>
                        <div class="single_client_review">
                            <div class="client_img">
                                <img src="<%=request.getContextPath()%>/css/img/goowon3.png" alt="#">
                            </div>
                            <p>"구원이3"</p>
                            <h5>- Micky Mouse</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- client review part end -->


    <!-- feature part here -->
    <section class="feature_part section_padding">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-6">
                    <div class="feature_part_tittle">
                        <h3>"퀄리티와 스타일이 어우러진 최상의 선택, 이곳에서 특별한 공간을 완성하세요."</h3>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="feature_part_content">
                        <p>
                        맞춤 가구로 인테리어를 더욱 완성해 보세요.
                        <br>
						스타일링의 마지막 조감도, 특별한 공간을 만들어보세요.
						<br>
						디테일에서 찾는 섬세함, 이곳에서 그 특별함을 느껴보세요.
						<br>
						세련된 공간의 비밀을 함께 풀어나가보세요.
                        </p>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-3 col-sm-6">
                    <div class="single_feature_part">
                        <img src="<%=request.getContextPath()%>/css/img/icon/feature_icon_1.svg" alt="#">
                        <h4>Credit Card Support</h4>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="single_feature_part">
                        <img src="<%=request.getContextPath()%>/css/img/icon/feature_icon_2.svg" alt="#">
                        <h4>Online Order</h4>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="single_feature_part">
                        <img src="<%=request.getContextPath()%>/css/img/icon/feature_icon_3.svg" alt="#">
                        <h4>Free Delivery</h4>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="single_feature_part">
                        <img src="<%=request.getContextPath()%>/css/img/icon/feature_icon_4.svg" alt="#">
                        <h4>Product with Gift</h4>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- feature part end -->

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
                                <%	// 관리자는 관리자회원정보
                                	if(session.getAttribute("loginEmpId2") != null || session.getAttribute("loginEmpId1") != null) {
                                %>
                                		<a href="<%=request.getContextPath()%>/employee/employeeInfo.jsp">관리자정보</a>
                                <% 
                                	// 고객은 고객회원정보
                                	} else {
                                %>
                                		<a href="<%=request.getContextPath()%>/customer/customerInfo.jsp">마이페이지</a>
                                <% 
                                	}
                                %>
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
    <script src="<%=request.getContextPath()%>/css/js/jquery-1.12.1.min.js"></script>
    <!-- popper js -->
    <script src="<%=request.getContextPath()%>/css/js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="<%=request.getContextPath()%>/css/js/bootstrap.min.js"></script>
    <!-- magnific popup js -->
    <script src="<%=request.getContextPath()%>/css/js/jquery.magnific-popup.js"></script>
    <!-- carousel js -->
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
