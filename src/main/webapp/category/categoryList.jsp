<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 카테고리를 수정및 추가 할 수 있는 카테고리 관리창.
	
	CategoryDao cDao = new CategoryDao();
	ArrayList<HashMap<String,Object>> cList = cDao.categoryNameList();
%>

<!doctype html>
<html lang="zxx">

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
	<!-- msg alert출력 -->
	<%
		if(request.getParameter("updateCategoryMsg") != null) {
	%>
			<script>
				alert('카테고리수정이 완료되었습니다.');
			</script>
	<% 
		} else if(request.getParameter("updateCategoryMsg2") != null) {
	%>
			<script>
				alert('카테고리수정을 실패하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("insertCategoryMsg") != null) {
	%>
			<script>
				alert('카테고리를 추가하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("insertCategoryMsg2") != null) {
	%>
			<script>
				alert('카테고리추가를 실패하였습니다.');
			</script>
	<% 
		}
	%>
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
    <section class="breadcrumb_part">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>카테고리 관리페이지</h2> 
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

  <!-- ================ contact section start ================= -->
    <div class="container">
    <br><div class="col-12">
         	 <h2 style="text-align: center;" class="contact-title"> <br>
	        	<a style="text-align: center;" class="genric-btn primary-border" href="<%=request.getContextPath()%>/category/insertCategory.jsp" >카테고리 추가하기</a>
         	 </h2>
        </div>
	<table class="table table-bordered">
			<%
				for(HashMap<String, Object> cMap : cList) {
			%>	
					<tr>
						<td style="text-align: center;">
							<%=cMap.get("categoryName") %>
							<a class="genric-btn primary-border circle" href=" <%=request.getContextPath() %>/category/updateCategory.jsp?categoryNo=<%=cMap.get("categoryNo")%>&categoryName=<%=cMap.get("categoryName")%>">수정하기</a>
						</td>
					</tr>
			<% 
				}
			%>			
		
	</table>
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
