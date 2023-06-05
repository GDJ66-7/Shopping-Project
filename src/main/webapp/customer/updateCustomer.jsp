<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") == null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
String id = (String)(session.getAttribute("loginCstmId"));
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
                       <h1>고객 개인정보 수정</h1>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

  <!-- ================ contact section start ================= -->
    <div class="container">
    <br><div class="col-12">
         	 <h2 class="contact-title">수정할 정보입력</h2>
        </div>
   <h1>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</h1>
	<form action="<%=request.getContextPath()%>/customer/updateCustomerAction.jsp" method="get">
		<input type="hidden" name="id" value="<%=id%>"><!-- 세션값아이디 히든으로 넘기기 -->
		<table class="table table-bordered">	
			<tr>
				<td>주소 :</td>
					<td>
						<textarea name ="cstmAddress" cols ="33" rows="5" placeholder="주소입력"></textarea>
					</td>
				</tr>	
				<tr>
					<td>이메일 :</td>
					<td>
						<input type="email" id="email" name="cstmEmail" placeholder="email@naver.com">
					</td>
				</tr>
				<tr>
					<td>전화번호 :</td>
					<td>
						<input type="tel"  name="cstmPhone" placeholder="010-0000-0000">
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인:</td>
				<td>
					<input type="password" name="pw" placeholder="비밀번호">
				</td>
			</tr>
		</table>
			<button type="submit" class="genric-btn primary-border circle">수정완료</button>
		</form>
    </div><br>
  <!-- ================ contact section end ================= -->

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