<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");
	
	String id = "customer1";
	
	// dao 객체 생성
	CartDao cartDao = new CartDao();
	
	// 7번 메소드 사용을 위해서 선언
	int point = 0;
	
	// 7. 구매자정보, 받는사람정보, 결제정보 조회 메서드
	ArrayList<HashMap<String, Object>> list7 = cartDao.cartOrderList(id);
	
	// 1. 장바구니 상품 목록 메서드
	ArrayList<HashMap<String, Object>> list1 = cartDao.cartList(id);
	// 체크된 상품이 있는지 확인(구매하기 버튼관련)
	boolean CheckedItem = false;
	for(HashMap<String, Object> c : list1) {
	    String checkedList = (String) c.get("체크");
	    if(checkedList.equals("y")) {
	        CheckedItem = true;
	        break;
	    }
	}
%>
<!DOCTYPE html>
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
	<header class="main_menu home_menu">
		<div class="container">
			<div class="row align-items-center justify-content-center">
                <div class="col-lg-12">
                    <nav class="navbar navbar-expand-lg navbar-light">
                        <a class="navbar-brand" href="index.html"> <img src="<%=request.getContextPath()%>/css/img/logo.png" alt="logo"> </a>
						<button class="navbar-toggler" type="button" data-toggle="collapse"
                            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                            <span class="menu_icon"><i class="fas fa-bars"></i></span>
                        </button>

						<div class="collapse navbar-collapse main-menu-item" id="navbarSupportedContent">
							<ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link" href="index.html">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="about.html">about</a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="blog.html" id="navbarDropdown_1"
                                        role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        product
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown_1">
                                        <a class="dropdown-item" href="product_list.html"> product list</a>
                                        <a class="dropdown-item" href="single-product.html">product details</a>
                                        
                                    </div>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="blog.html" id="navbarDropdown_3"
                                        role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        pages
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown_2">
                                        <a class="dropdown-item" href="login.html"> 
                                            login
                                            
                                        </a>
                                        <a class="dropdown-item" href="checkout.html">product checkout</a>
                                        <a class="dropdown-item" href="cart.html">shopping cart</a>
                                        <a class="dropdown-item" href="confirmation.html">confirmation</a>
                                        <a class="dropdown-item" href="elements.html">elements</a>
                                    </div>
                                </li>
                                
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="blog.html" id="navbarDropdown_2"
                                        role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        blog
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown_2">
                                        <a class="dropdown-item" href="blog.html"> blog</a>
                                        <a class="dropdown-item" href="single-blog.html">Single blog</a>
                                    </div>
                                </li>
                                
                                <li class="nav-item">
                                    <a class="nav-link" href="contact.html">Contact</a>
                                </li>
                            </ul>
                        </div>
                        <div class="hearer_icon d-flex align-items-center">
                            <a id="search_1" href="javascript:void(0)"><i class="ti-search"></i></a>
                            <div class="dropdown cart">
                                <a class="dropdown-toggle" href="#" id="navbarDropdown3" role="button"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="flaticon-shopping-cart-black-shape"></i>
                                </a>
                                <!-- <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <div class="single_product">
    
                                    </div>
                                </div> -->
                            </div>
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
    <section class="breadcrumb_part">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>장바구니 목록</h2>
                    </div>
                </div>
            </div>
        </div>
	</section>
    <!-- breadcrumb part end-->

	<!--================Cart Area =================-->
<br>	
<br>	
	<div class="container">
		 <div class="cart_inner">
				<table class="table">
					<thead>
						<tr>
							<th scope="col"><h5>선택</h5></th>
							<th scope="col"><h5>상품이미지</h5></th>
							<th scope="col"><h5>상품이름</h5></th>
							<th scope="col"><h5>상품가격</h5></th>
							<th scope="col"><h5>할인금액</h5></th>
							<th scope="col"><h5>할인적용가격</h5></th>
							<th scope="col"><h5>수량</h5></th>
							<th scope="col"><h5>전체가격</h5></th>
							<th scope="col"><h5>삭제</h5></th>				
						</tr>
					</thead>
					<tbody>
						<%
							for(HashMap<String, Object> c : list1) {
								// 1. 변수에 조회한 값을 저장
								int productNo = (int)(c.get("상품번호"));
								int cartCnt = (int)(c.get("수량"));
								String checked = (String)(c.get("체크"));
						
								// 2. 상품의 최대로 선택 가능한 개수(상품의 재고량만큼)
								int totalCnt = cartDao.maxCartCnt(productNo);
									
								// 수량이 0이거나 재고가 없는 경우 해당 상품을 리스트에 표시하지 않는다
								if(cartCnt ==0 || totalCnt==0) {
									continue;	// 건너뛴다.
								}
						%>
							<tr>
								<!-- 상품 선택(체크) -->
								<td>
									<!-- 체크 상태를 수정 하기 위한 폼 -->
									<form action="<%=request.getContextPath()%>/cart/updateCheckedAction.jsp" method="post">
										<input type="hidden" name=id value="<%=(String)(c.get("아이디"))%>">
										<input type="hidden" name=cartNo value="<%=(int)(c.get("장바구니번호"))%>">
										<label>	
											<input type="radio" name="checked" value="y" <%=(checked.equals("y")) ? "checked" : ""%>> Y
										</label>
										<label>	
											<input type="radio" name="checked" value="n" <%=(checked.equals("n")) ? "checked" : ""%>> N
										</label>
										<input type="submit" value="변경">
									</form>
								</td>
								<!-- 상품 이미지 -->
								<td>
									<img src="${pageContext.request.contextPath}/product/productImg/<%=c.get("상품이미지")%>" width="100" height="100">
								</td>
								<!-- 상품 이름 -->
								<td>
									<a href="<%=request.getContextPath()%>/product/productOne.jsp">
										<%=(String)(c.get("상품이름"))%>
									</a>	
								</td>
								<!-- 상품 가격 -->	
								<td>
									<h5><%=(int)(c.get("상품가격"))%>원</h5>
								</td>		
								<!-- 할인 금액 -->				
								<td>
									<h5><%=(int)(c.get("할인금액"))%>원</h5>
								</td>
								<!-- 할인 적용 가격 -->
								<td>
									<h5><%=(int)(c.get("할인상품가격"))%>원</h5>
								</td>
								<!-- 수량 -->
								<td>
									<!-- 단일 상품 개수를 수정 하기 위한 폼 -->
									<form action="<%=request.getContextPath()%>/cart/updateCartCntAction.jsp" method="post">
										<input type="hidden" name=cartNo value="<%=(int)(c.get("장바구니번호"))%>">
										<input type="hidden" name="id" value="<%=(String)(c.get("아이디"))%>">	
										<select name = "cartCnt">
										<%			
											for(int i=1; i<=totalCnt; i++) {	// totalCnt = cartDao.maxCartCnt(productNo)
										%>
												<!-- i(1부터 상품 재고량까지) 와 현재 장바구니 상품 수량이 같으면 고정  -->
												<option <%=(i == cartCnt) ? "selected" : "" %> value="<%=i%>"> <%=i%> </option>					
										<%
											}
										%>
										</select>	
										<input type="submit" value="변경">		
									</form>
				                </td>	
								<!-- 전체가격 -->				
				                <td>
				                  <h5><%=(int)(c.get("전체가격"))%>원</h5>
				                </td>
				                <!-- 단일 상품 삭제 -->	
				                <td>
				                	<!-- 단일행 삭제를 위한 폼 -->
									<form action="<%=request.getContextPath()%>/cart/deleteCartAction.jsp" method="post">
										<input type="hidden" name="cartNo" value="<%=(int)(c.get("장바구니번호"))%>">
										<input type="hidden" name="id" value="<%=(String)(c.get("아이디"))%>">				
										<input type="submit" value="X">
									</form>
				                </td>
              				</tr>
						<%
							}
						%>	
              	</table>
                  
				<table>
					<%
						for(HashMap<String, Object> c : list7) {			
					%>
							<tr>
								<th>
									총 상품가격 <%=c.get("전체금액")%>원 + 총 배송비 0원 = 총 주문금액 <span style="color:red"><%=c.get("전체금액")%></span>
								</th>
							</tr>
					<%
						}
					%>	
				</table>
              
              
              	<table class="table">
					<tr>
		                <td>
		                	<a href="<%=request.getContextPath()%>/main/home.jsp">
								<button class="btn_1" type="button">계속쇼핑하기</button>
							</a>    
		                </td>
			            <%
							if(CheckedItem) { // CheckedItem이 true이면 cartOrder로 (cartOrder.jsp)
						%>
								<td>
									<a href="<%=request.getContextPath()%>/cart/cartOrder.jsp">
										<button class="btn_1" type="button">구매하기</button>
									</a>
								</td>
						<%
							} else { // CheckedItem이 false이면 현재페이지로 (cartList.jsp)
						%>
								<td>
									<button class="btn_1" type="button" onclick="history.back()">구매하기</button>
								</td>
						<%
							} 
						%>
			     	</tr>
				</table> 
        </div>
      </div>

  <!--================End Cart Area =================-->
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