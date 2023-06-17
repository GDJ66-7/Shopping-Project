<%@page import="java.util.Arrays"%>
<%@page import="dao.CategoryDao"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDao"%>
<%
	request.setCharacterEncoding("utf-8");

	// dao를 사용하기 위한 productDao클래스 객체 생성
	ProductDao pDao = new ProductDao();
	// 카테고리이름을 출력하기 위한 CategoryDao 객체 생성
	CategoryDao cDao = new CategoryDao();
	
	// 요청값 변수 저장 및 디버깅
	
	/*
		String productName = null;
	
	*/
	
	String productName = request.getParameter("productName"); // null
	String categoryName = request.getParameter("categoryName");
	String ascDesc = request.getParameter("ascDesc");
	String discountProduct = request.getParameter("discountProduct");
	
	// 요청값이 null이 나와서 실행오류가 발생 null일경우 ""(공백)처리
	/*
		if (productName != null) {
	 		puductName = request.getParameter("productName");
	 	}
	*/
	
	if(discountProduct == null) {
		discountProduct ="";
	}
	if (productName == null) {
	    productName = "";
	}
	if (categoryName == null) {
	    categoryName = "";
	}
	if (ascDesc == null) {
	    ascDesc = "";
	}
	System.out.println(productName + "<-- productList productName");
	System.out.println(categoryName + "<-- productList categoryName");
	System.out.println(discountProduct + "<-- productList discountProduct");
	System.out.println(ascDesc + "<-- productList ascDesc");
	
	//현재페이지 변수
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 페이지당 출력할 행의 수
	int rowPerPage = 8;
	
	// 페이지당 시작 행번호
	int beginRow = (currentPage-1) * rowPerPage;
	
	int totalRow = pDao.productListCnt(categoryName, productName, ascDesc, discountProduct);
	System.out.println(totalRow + "<-- productList totalRow");
	
	int lastPage = totalRow / rowPerPage;
	//rowPerPage가 딱 나뉘어 떨어지지 않으면 그 여분을 보여주기 위해 +1
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	// 페이지 네비게이션 페이징
	int pagePerPage = 10;
	/*	cp	minPage		maxPage
		1		1	~	10
		2		1	~	10
		10		1	~	10
		
		11		11	~	20
		12		11	~	20
		20		11	~	20
		
		((cp-1) / pagePerPage) * pagePerPage + 1 --> minPage
		minPage + (pagePerPgae -1) --> maxPage
		maxPage > lastPage --> maxPage = lastPage;
	*/
	// 마지막 페이지 구하기
	// 최소페이지,최대페이지 구하기
	int minPage = ((currentPage-1) / pagePerPage) * pagePerPage + 1;
	int maxPage = minPage + (pagePerPage -1);
	
	// maxPage가 마지막 페이지를 넘어가지 않도록 함
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}

	// 상품 리스트 dao호출
	ArrayList<HashMap<String, Object>> productList = pDao.productList(productName, categoryName, ascDesc, discountProduct, beginRow, rowPerPage);
	
	// 카테고리이름리스트 dao호출
	ArrayList<HashMap<String, Object>> categoryNameList = cDao.categoryNameList();
	
	int cnt = 0;
%>
<!doctype html>
<html lang="zxx">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- google font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&family=Poor+Story&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<style>
    .center-align {
        text-align: center;
    }
    .navbar-nav {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex; /* 가로로 아이템 나열 */
        align-items: center;
    }

    .navbar-nav li {
        margin-right: 15px;
    }

    .navbar-nav input[type="text"] {
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .navbar-nav input[type="radio"],
    .navbar-nav input[type="checkbox"] {
        margin-right: 5px;
    }

    .navbar-nav label {
        font-weight: bold;
    }

    .fontBlackBold {
        color: black; /* a 태그의 텍스트 색상을 검정색으로 변경 */
        font-weight: bold; /* 텍스트를 강조하기 위해 글꼴을 굵게 설정 */
        
        
        /* 다른 스타일 속성을 필요에 따라 추가할 수 있습니다. */
    }
    
    .larger-text {
        font-size: 1.2em; /* 원하는 글자 크기로 조정해주세요 */
    }
    
    .google-font {
   		font-family: 'Sunflower', sans-serif;
    }
    
    .product-image {
	    width: 250px;
	    height: 250px;
	    object-fit: cover;
  	}
  	
  	.search-form {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 20px;
  }
  .search-form input[type="text"] {
    width: 200px;
    height: 30px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
    transition: border-color 0.3s ease;
  }
  .search-form input[type="text"]:focus {
    border-color: purple;
    outline: none;
  }
  .search-form label {
    margin-right: 10px;
    font-size: 14px;
    color: #333;
  }
  .search-form ul {
    list-style: none;
    padding: 0;
    margin: 10px 0;
    display: flex;
    justify-content: center;
  }
  .search-form li {
    margin-right: 10px;
    font-size: 14px;
    color: #333;
  }
</style>
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
						<div>
							<jsp:include page="/main/menuBar.jsp"></jsp:include>
						</div>
                        <div class="hearer_icon d-flex align-items-center">
                            <a id="search_1" href="javascript:void(0)"><i class="ti-search"></i></a>
                            <a href="cart.html">
                                <i class="flaticon-shopping-cart-black-shape"></i>
                            </a>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
        <div class="search_input" id="search_input_box">
            <div class="container ">
            <!--  메뉴바 오른쪽 돋보기 상품검색기능 -->
                <form class="d-flex justify-content-between search-inner" action="<%=request.getContextPath()%>/product/productList.jsp" method="post">
                    <input type="text" class="form-control" name="productName"  placeholder="상품이름검색">
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
                        <h2>product list</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->
    
    <!-- product list part start-->
    <section class="product_list section_padding">
        <div class="container">
    	<!--<div class="row">
        		<div class="col-md-2">-->
                	<div class="product_sidebar">
                    	<!--  상품리스트 왼쪽 검색기능 -->
	                    <form class="search-form" id="productSearchForm" action="<%=request.getContextPath()%>/product/productList.jsp" method="post">
	                    	<ul class="navbar-nav">
	                       		<li>					<!-- value값이 초기엔 null이라 value값을 보여주지 않는다 ex) 침대를 검색시 침대값이 유지된 상태로 검색된다. -->
	                       			<div class="center-align">
	                       				<input type="text" name="productName" <%if(request.getParameter("productName") != null) {%> value="<%=request.getParameter("productName")%>" <%}%> placeholder="상품이름검색">
	                       			</div>
	                       			<br>
        							<label>
										<input type="radio" class="productList" name="discountProduct" value="" 
										<% if(request.getParameter("discountProduct") != null && request.getParameter("discountProduct").equals("")) {%> checked <%} %>> 전체상품보기
									</label>
    							
							
        							<label>
										<input type="radio" class="productList" name="discountProduct" value="할인상품"
										<% if(request.getParameter("discountProduct") != null && request.getParameter("discountProduct").equals("할인상품")) {%> checked <%} %>> 할인상품보기
									</label>
    						
        							<label>
		                       			<input type="radio" class="ascDesc" name="ascDesc" value="asc" <% if(request.getParameter("ascDesc") != null && request.getParameter("ascDesc").equals("asc")) { %> checked <% } %>>오래된순
	        							<input type="radio" class="ascDesc" name="ascDesc" value="desc" <% if(request.getParameter("ascDesc") != null && request.getParameter("ascDesc").equals("desc")) { %> checked <% } %>>최신순
	                      			</label>
	                      			<br>
	                      			<li>
	                       				<%
	                               			for(HashMap<String, Object> categoryNameMap : categoryNameList) {
	                               		%>	
                               					<input type="checkbox" name="categoryName"  value="<%=categoryNameMap.get("categoryName")%>" 
                               					<% if(request.getParameter("categoryName") != null && request.getParameter("categoryName").equals(categoryNameMap.get("categoryName"))) { %> checked <% } %>>
                                				<%=categoryNameMap.get("categoryName")%>
	                               		<% 	
	                               			
	                               			}
	                               		%>
	                               	</li>
		                      	<li>
		                       		<button class="genric-btn primary-border circle" type="submit" id="productBtn">검색</button>
		                      	</li>
	                      	</ul>
	                    </form>
	                   	<!---------------------- js부분 -------------------------->
	                   	
	                    <script>
	                   		// radio는 누르기만 해도 값이 넘어간다.
		                    let radio = $('input[type="radio"]');
		                	
		                    radio.on('change', function() {
		                      $('#productSearchForm').submit();
		                    }); 
	                    </script>
	                    </div>
                  <!-- </div>
            </div>-->
                <!-- -----------------------     상품리스트 출력   ------------------------- -->
                <div class="col-md-12">
                    <div class="product_list">
                        <div class="row">
				            <%
								for(HashMap<String, Object> productMap : productList) {
									// 판매중인 상품만 상품 상세정보에 들어갈 수 있게 설정
									if(productMap.get("productStatus").equals("판매중")){
							%>
										<div class="col-lg-3 col-sm-3">
										<div class="single_product_item">
											<!-- 상품사진 -->
											<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productMap.get("productNo")%>&productImgNo=<%=productMap.get("productImgNo")%>&productDiscountPrice=<%=productMap.get("productDiscountPrice") %>">
												<img class="product-image" src="${pageContext.request.contextPath}/product/productImg/<%=productMap.get("productSaveFilename") %>">
											</a>
											<br>
											<!-- 상품 이름 -->
											<a class="fontBlack center-align larger-text google-font" style="color: black; text-decoration: none;" href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productMap.get("productNo")%>&productImgNo=<%=productMap.get("productImgNo")%>&productDiscountPrice=<%=productMap.get("productDiscountPrice") %>"><em><%=productMap.get("productName") %></em></a>
											<br>	
											<!-- 상품 가격 -->
											<span class="fontBlackBold center-align larger-text">가격 : <%=productMap.get("productPrice") %></span>
											<br>
							<% 
											// 할인가가 있는 상품만 할인가격이 나오게 설정
											
											if ((int)productMap.get("productDiscountPrice") != ((int)productMap.get("productPrice"))) {
							%>
												<span class="fontBlackBold larger-text">할인가</span> : <span class="center-align larger-text" style="color: red; font-weight: bold;"><%=productMap.get("productDiscountPrice") %></span>
												<br>
							<% 
											}
											
							%>
													<!-- 상품상태 -->
													<span class="center-align larger-text"><%=productMap.get("productStatus") %></span>
													<br>
							<%
												// 상품수정 및 상품할인은 관리자로그인시에만 볼 수 있음 관리자2만 상품수정및 할인가능
												if(session.getAttribute("loginEmpId2") != null) {
							%>
													<a class="center-align" href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=productMap.get("productNo")%>&productImgNo=<%=productMap.get("productImgNo")%>">수정</a>
													<br>
													<a class="center-align" href="<%=request.getContextPath()%>/discount/inserttDiscount.jsp?productNo=<%=productMap.get("productNo")%>">할인</a>
							<% 						
												}
							%>
										</div>
										</div>
							<%			
									} else { // 판매중이 아닌 품절이나 단종상품은 상세정보를 못들어감
							%>
										<div class="col-lg-3 col-sm-3">
										<div class="single_product_item">
											<!-- ${pageContext.request.contextPath}는 현재 웹 애플리케이션의 루트 경로를 나타내는 변수이다   -->
											<img class="product-image" src="${pageContext.request.contextPath}/product/productImg/<%=productMap.get("productSaveFilename") %>">
											<span class="fontBlack center-align larger-text google-font" style="color : black;"><%=productMap.get("productName") %></span>
											<br>
											<span class="fontBlackBold center-align larger-text">가격 : <%=productMap.get("productPrice") %></span>
											<br>
											<span style="color: red;" class="larger-text"><%=productMap.get("productStatus") %></span>
											<br>
							<% 		
										// 상품수정은 관리자로그인시에만 볼 수 있음 관리자2만가능
										if(session.getAttribute("loginEmpId2") != null) {
							%>
											<a href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=productMap.get("productNo")%>&productImgNo=<%=productMap.get("productImgNo")%>">수정</a>
							<% 
										}
							%>
										</div>
										</div>
							<% 
									}
								}
							%>
						</div>
                    </div>
                </div>
        </div>
    </section>
   
  	<!--  페이징부분 -->
    	<ul class="pagination justify-content-center list-group list-group-horizontal">
			<% 
				// 최소페이지가 1보다크면 이전페이지(이전페이지는 만약 내가 11페이지면 1페이지로 21페이지면 11페이지로)버튼
				if(minPage>1) {
			%>
					<li class="list-group-item">
						<a href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=minPage-pagePerPage%>&productName=<%=productName%>&categoryName=<%=categoryName%>&ascDesc=<%=ascDesc%>&discountProduct=<%=discountProduct%>">이전</a>
					</li>
			<%			
				}
				// 최소 페이지부터 최대 페이지까지 표시
				for(int i = minPage; i<=maxPage; i=i+1) {
					if(i == currentPage) {	// 현재페이지는 링크 비활성화
			%>	
						<!-- i와 현재페이지가 같은곳이라면 현재위치한 페이지 빨간색표시 -->
						<li class="list-group-item">
							<span style="color: red;"><%=i %></span>
						</li>
			<%			
					// i가 현재페이지와 다르다면 출력
					}else {					
			%>		
						<li class="list-group-item">
							<a href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=i%>&productName=<%=productName%>&categoryName=<%=categoryName%>&ascDesc=<%=ascDesc%>&discountProduct=<%=discountProduct%>"><%=i%></a>
						</li>
			<%				
					}
				}
				
				// maxPage가 마지막페이지와 다르다면 다음버튼 마지막페이지에서는 둘이 같으니 다음버튼이 안나오겠죠
				// 다음페이지(만약 내가 1페이지에서 누르면 11페이지로 11페이지에서 누르면 21페이지로)버튼
				if(maxPage != lastPage) {
			%>
					<li class="list-group-item">
						<a href="<%=request.getContextPath()%>/product/productList.jsp?currentPage=<%=minPage+pagePerPage%>&productName=<%=productName%>&categoryName=<%=categoryName%>&ascDesc=<%=ascDesc%>&discountProduct=<%=discountProduct%>">다음</a>
					</li>
			<%	
				}
			%>
		</ul>
    <!-- product list part end-->
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