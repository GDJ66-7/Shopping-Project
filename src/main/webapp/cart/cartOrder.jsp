<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>

<%
	// 한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	String id = "customer1";

	// updatePoint.jsp에서 받아 온 값이 있으면 inputPoint 변수에 값을 저장한다.
	int inputPoint = 0;
	if(request.getParameter("inputPoint")!= null) {
		inputPoint = Integer.parseInt(request.getParameter("inputPoint"));
	}
	
	// 받아 온 값이 있으면 selectAddress 변수에 값을 저장한다.
	String selectAddress = null;
	if(request.getParameter("selectAddress")!= null) {
		selectAddress = request.getParameter("selectAddress");
	}
	
	// 사용 할 포인트 초기값(사용자가 포인트를 입력하지않으면 기본값은 0이다.)
	int usePoint = 0;
	usePoint = usePoint + inputPoint; // // 사용 할 포인트(사용자가 포인트 입력한 값)

	// dao 객체 생성
	CartDao cartDao = new CartDao();	
	
	// 8. 보유 포인트 조회 메서드
	int point = cartDao.selectPoint(id);
	
	// 9. 총결제금액
	int totalPay = cartDao.totalPayment(usePoint, id);
	
	// 6. 장바구니에서 체크한 상품 조회 메서드
	ArrayList<HashMap<String, Object>> list6 = cartDao.checkedList(id);
	
	// 7. 구매자정보, 받는사람정보, 결제정보 조회 메서드
	ArrayList<HashMap<String, Object>> list7 = cartDao.cartOrderList(id);
	
	// 총 상품 개수
	int totalCartCnt = 0;
	for(HashMap<String, Object> c : list7) {
		totalCartCnt = (Integer)(c.get("총상품개수"));
	}
	
	// 10. 주소 내역 리스트 불러오기
	ArrayList<String> list10 = cartDao.addressList(id);
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
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/flaticon.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/themify-icons.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/magnific-popup.css">
    <!-- swiper CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/slick.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css/style.css">
       
<script>
	function addressOpenPopup(url) {
		window.open(url, 'addressPopupWindow', 'width=600, height=400');
	}
</script>
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
                        <h2>주문/결제</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

<!--================Checkout Area =================-->
<br>
<br>
    <div class="container">
    	<!-- 구매자 정보 -->
    	<div class="cupon_area">
        	<div class="check_title">
          		<h2>구매자 정보</h2>
			</div>
			
			<table>	
			<%
				for(HashMap<String, Object> c : list7) { 				
			%>
				<tr>
					<th> 구매자 이름</th>
					<td><input type="text" value="<%=(String)(c.get("이름"))%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>구매자 이메일</th>
					<td><input type="text" value="<%=(String)(c.get("이메일"))%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>구매자 전화번호</th>
					<td><input type="text" value="<%=(String)(c.get("휴대폰번호"))%>" readonly="readonly"></td>
				</tr>		
			<%
				}
			%>					
			</table>	
		</div>
    
    	<!-- 받는사람 정보 -->
		<div class="returning_customer">
			<div class="check_title">
				<h2>받는 사람 정보</h2>
			</div>
			<p> 이전에 고객님께서 쇼핑한 적이 있는 경우 아래 주소에서 하나를 선택해주십시오.
				신규 고객인 경우 주소 추가를 눌러서 주소를 추가해주십시오.
			</p>

			<form class="row contact_form" action="<%=request.getContextPath()%>/cart/cartOrder.jsp" method="post">
				<input type="hidden" name="id" value="<%=id%>">
				<input type="hidden" name="inputPoint" value="<%=inputPoint%>">
				<table>
					<tr>
						<th>최근 배송 주소</th>
					</tr>
					<%
						for(String address : list10) {
					%>
							<tr>	
								<td>
									<input type="radio" name="selectAddress" value="<%=address%>" <%if (address.equals(selectAddress)) { %>checked<% } %>>
									<%=address%>
								</td>
							</tr>
					<%
						}
					%>
					<tr>
						<td>
							<input class="tp_btn" type="submit" value="주소 선택">
						</td>
						<td>
							<a class="tp_btn" href="#" onclick="addressOpenPopup('<%=request.getContextPath()%>/cart/insertAddress.jsp?id=<%=id%>')">주소추가</a>
						</td>
					</tr>
				</table>
			</form>  
		</div>
      	<br>
      	<!--  결제 정보  -->
		<div class="billing_details">
			<div class="check_title">
				<h2>포인트 사용</h2>
            </div>
		<br>
            
		<div class="row">
			<div class="col-lg-8">
            	<form class="row contact_form" action="<%=request.getContextPath()%>/cart/updatePoint.jsp" method="post">
            		<input type="hidden" name="id" value="<%=id%>">
					<input type="hidden" name="selectAddress" value="<%=selectAddress%>">		
            		<table>
	            		<tr>
							<th>
								<div class="col-md-6 form-group p_star">보유포인트</div>	
							</th>
							<th>
								<div class="col-md-6 form-group p_star">사용포인트</div>	
							</th>
						</tr>
	            		<tr>
							<td>
								<div class="col-md-6 form-group p_star">
			               		 	<input class="form-control" type="text" readonly="readonly" name="point" value="<%=point%>">
								</div>
							</td>
							<td>
								<div class="col-md-6 form-group p_star">
			               		 	<input class="form-control" type="text" readonly="readonly" name="usePoint" value="<%=usePoint%>">
								</div>
							</td>
						</tr>
						<tr>
	            		
						<td>
							<div class="col-md-6 form-group p_star">         
								<input class="tp_btn" type="submit" value="포인트 사용하기">
							</div>
						</td>
						</tr>
	              	</table>
            	</form>
			</div>
          
			<!-- 주문내역 -->
			<div class="col-lg-4">
            	<div class="order_box">
              		<h2>주문 내역</h2>
              		<!-- 배송 상품 목록 -->
						<table class="table">	
							<tr>
								<th>상품이름</th>
								<th>수량</th>
							</tr>		
							<%
								for(HashMap<String, Object> c : list6) {		
							%>		
									<tr>
										<td><%=(String)(c.get("상품이름"))%></td>
										<td>x <%=(Integer)(c.get("수량"))%></td>
										<td></td>
									</tr>	
							<%
								}
							%>	
												
							<%
								for(HashMap<String, Object> c : list7) { 
									int discountAmount = (Integer)(c.get("할인금액"));
									int totalDiscntAmount = discountAmount + inputPoint;
							%>
							<tr>
								<th>상품가격</th>
								<td><%=(Integer)(c.get("총상품가격"))%></td>
							</tr>
							<tr>
								<th>할인금액</th>
								<td><%=totalDiscntAmount%></td>
							</tr>
							<tr>
								<th>결제금액</th>
								<td><%=totalPay%></td>
							</tr>			
							<%	
								}
							%>
							<tr>
								<td>
									<form action="<%=request.getContextPath()%>/cart/cartOrderAction.jsp">		
										<input type="hidden" name="id" value="<%=id%>">	
										<input type="hidden" name="totalCartCnt" value="<%=totalCartCnt%>">	
										<input type="hidden" name="totalPay" value="<%=totalPay%>">	
										<input type="hidden" name="selectAddress" value="<%=selectAddress%>">	
										<input type="hidden" name="inputPoint" value="<%=inputPoint%>">						
										<input class="btn_3" type="submit" value="결제하기">			
									</form>
								</td>	
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
<!--================End Checkout Area =================-->

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