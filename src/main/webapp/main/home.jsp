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
            <img src="<%=request.getContextPath()%>/main/mainImg/main.jpg" alt="#" class="img-fluid">
            <img src="<%=request.getContextPath()%>/css/img/banner_pattern.png" alt="#" class="pattern_img img-fluid">
        </div>
    </section>
 	<!-- banner part end-->

    <!-- product list start-->
    <br>
    <br>
    <br>
    	<div class="container">
            <div class="row">
                <div class="col-lg-12"> 
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
		                        	<div style="text-align: center;" class="col-lg-4">
		                        		<a style="display: block; text-align: center;" href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=map.get("productNo")%>&productImgNo=<%=map.get("productImgNo")%>">
		                        			<img src="${pageContext.request.contextPath}/product/productImg/<%=map.get("productSaveFilename") %>" width="200" height="200">
		                        		</a>
		                        		
		                        		<span style="font-weight: bold;">
	                        				<%=map.get("productName") %>
	                        			</span>
	                        			
		                        		<span style="display: block;">
		                        			<%=productPrice %> ₩
		                        		</span>	
		                        		<br>
		                        			
		                            	<a style="display: block;" href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=map.get("productNo")%>&productImgNo=<%=map.get("productImgNo")%>" class="btn_3">
		                            		상품바로가기
		                            	</a>
		                            </div>
	                        <% 	
	                        	}
	                        %>                                   
                    	</div>
                    </div>
                </div>
            </div>
        </div>
    <!-- product list end-->
    <!-- trending item start-->
    <br>
    <br>
    <section class="trending_items">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section_tittle text-center">
                        <h2>인기 상품</h2>
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
               				<img src="${pageContext.request.contextPath}/product/productImg/<%=proMap.get("productSaveFilename") %>" width="250" height="250">
               			</a>
               			<h3> 
               				<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=proMap.get("productNo")%>&productImgNo=<%=proMap.get("productImgNo")%>">
               					<%=proMap.get("productInfo") %>
                   			</a> 
                   		</h3>
                   		<p>
                   			<%=productPrice %> ₩
                   		</p>
               		</div>
                   	</div>
               	<% 
               		}
               	%>
            </div>
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
                                <img src="<%=request.getContextPath()%>/css/img/client.png" alt="#">
                            </div>
                            <p>"Working in conjunction with humanitarian aid agencies, we have supported programmes to help alleviate human suffering.</p>
                            <h5>- Micky Mouse</h5>
                        </div>
                        <div class="single_client_review">
                            <div class="client_img">
                                <img src="<%=request.getContextPath()%>/css/img/client_1.png" alt="#">
                            </div>
                            <p>"Working in conjunction with humanitarian aid agencies, we have supported programmes to help alleviate human suffering.</p>
                            <h5>- Micky Mouse</h5>
                        </div>
                        <div class="single_client_review">
                            <div class="client_img">
                                <img src="<%=request.getContextPath()%>/css/img/client_2.png" alt="#">
                            </div>
                            <p>"Working in conjunction with humanitarian aid agencies, we have supported programmes to help alleviate human suffering.</p>
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
                        <h3>Credibly innovate granular
                        internal or organic sources
                        whereas standards.</h3>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="feature_part_content">
                        <p>Seamlessly empower fully researched growth strategies and interoperable internal or “organic” sources. Credibly innovate granular internal or “organic” sources whereas high standards in web-readiness.</p>
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

    <!-- subscribe part here -->
    <section class="subscribe_part section_padding">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="subscribe_part_content">
                        <h2>Get promotions & updates!</h2>
                        <p>Seamlessly empower fully researched growth strategies and interoperable internal or “organic” sources credibly innovate granular internal .</p>
                        <div class="subscribe_form">
                            <input type="email" placeholder="Enter your mail">
                            <a href="#" class="btn_1">Subscribe</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- subscribe part end -->

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
                                <a href="<%=request.getContextPath()%>/product/ProductList.jsp">상품</a>
                                <a href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지사항</a>
                                <a href="<%=request.getContextPath()%>/customer/customerInfo.jsp">마이페이지</a>
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
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="ti-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
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
