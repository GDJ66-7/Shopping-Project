<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ProductDao pDao = new ProductDao();

	// 관리자 상품리스트는 전체상품을 보여주므로 매개변수 공백값처리.
	String productName =  request.getParameter("productName");
	if(productName == null) {
		productName = "";
	}
	
	String discountProduct = "";
	String categoryName = "";
	String ascDesc = "";
	
	// ----------------- 페이징 처리---------------------------
	//현재페이지 변수
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 페이지당 출력할 행의 수
	int rowPerPage = 10;
	
	// 페이지당 시작 행번호
	int beginRow = (currentPage-1) * rowPerPage;
	
	int totalRow = pDao.empProductListCnt(categoryName, productName, ascDesc, discountProduct);
	System.out.println(totalRow + "<-- productList totalRow");
	
	int lastPage = totalRow / rowPerPage;
	//rowPerPage가 딱 나뉘어 떨어지지 않으면 그 여분을 보여주기 위해 +1
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	// 페이지 네비게이션 페이징
	int pagePerPage = 10;

	// 마지막 페이지 구하기
	// 최소페이지,최대페이지 구하기
	int minPage = ((currentPage-1) / pagePerPage) * pagePerPage + 1;
	int maxPage = minPage + (pagePerPage -1);
	
	// maxPage가 마지막 페이지를 넘어가지 않도록 함
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}
	
	ArrayList<HashMap<String,Object>> pList = pDao.empProductList(productName, categoryName, ascDesc, discountProduct, beginRow, rowPerPage);
	
	
%>

<!DOCTYPE html>
<html>
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
<style>
  table {
    border-collapse: collapse;
    width: 100%;
  }
  
  th, td {
    border: 1px solid black;
    padding: 10px;
    text-align: center;
  }
  
  th {
    background-color: #f1f1f1;
    font-weight: bold;
  }
  
  tr:nth-child(even) {
    background-color: #f9f9f9;
  }
  
  .product-image {
    width: 50px;
    height: 50px;
    object-fit: cover;
    border-radius: 50%;
  }
  
  .product-name {
    font-weight: bold;
  }
  .discounted-price {
    color: red;
    font-weight: bold;
  }
  
  .styled-input {
    display: inline-block;
    position: relative;
  }
  .styled-input input {

    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    transition: border-color 0.3s ease;
  }
  .styled-input input:focus {
    border-color: purple;
    outline: none;
  }
  .styled-input input::placeholder {
    color: #999;
  }
</style>
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
    <section class="breadcrumb_part" style="height:200px">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>상품관리페이지</h2> 
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

  <!-- ================ contact section start ================= -->
    <div class="container">
    <br>
    	<div class="col-12">
    		<div style="text-align:center;">
		    <a href="<%=request.getContextPath()%>/product/insertProduct.jsp">상품추가</a>
		    </div>
	     	<form style="text-align:center;" action="<%=request.getContextPath()%>/product/empProductList.jsp" method="get">
		      	<div class="styled-input">
		      																								<!-- value값이 초기엔 null이라 value값을 보여주지 않는다 ex) 침대를 검색시 침대값이 유지된 상태로 검색된다. -->
		      		<input style="text-align: center;" type="text" name="productName" <%if(request.getParameter("productName") != null) {%> value="<%=request.getParameter("productName")%>" <%}%> placeholder="상품이름검색">
		      	</div>
		      	<button class="genric-btn primary-border circle" type="submit">검색</button>
			</form>
			<table style="width:100%; height:100%">
				<tr class="backgroundColor">
					<th>번호</th>
					<th>카테고리</th>
					<th>이름</th>
					<th>가격</th>
					<th>상태</th>
					<th>재고</th>
					<th>등록일</th>
					<th>수정일</th>
					<th>수정</th>
					<th>할인</th>
				</tr>
				<%
					for(HashMap<String, Object> productMap : pList) {
				%>
						<tr>
							<td><%=productMap.get("productNo") %></td>
							<td><%=productMap.get("categoryName") %></td>
				<% 			
						// 할인이 들어간 상품은 빨간글씨로 이름표시하며 할인가도 같이 나옴
						if ((int)productMap.get("productDiscountPrice") != ((int)productMap.get("productPrice"))) {
				%>
							<td>
								<img class="product-image" src="${pageContext.request.contextPath}/product/productImg/<%=productMap.get("productSaveFilename") %>" width="50" height="50">
								<span  class="product-name" style="color: red;"><%=productMap.get("productName") %></span>
							</td>
							<td>
								원가:<%=productMap.get("productPrice") %>
								<br>
								
								<span class="discounted-price">할인가:<%=productMap.get("productDiscountPrice") %></span>
							</td>
				<% 
						} else {
				%>
							<td>
								<img class="product-image" src="${pageContext.request.contextPath}/product/productImg/<%=productMap.get("productSaveFilename") %>" width="50" height="50">
								<span  class="product-name"><%=productMap.get("productName") %></span>
							</td>
							<td><%=productMap.get("productPrice") %></td>
				<% 
						}
				%>
							<td><%=productMap.get("productStatus") %></td>
							<td><%=productMap.get("productStock") %></td>
							<td><%=productMap.get("createdate") %></td>
							<td><%=productMap.get("updatedate") %></td>
				<% 		
						// 상품수정은 관리자로그인시에만 볼 수 있음 관리자2만가능
						if(session.getAttribute("loginEmpId2") != null) {
				%>
							<td>
								<a href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=productMap.get("productNo")%>&productImgNo=<%=productMap.get("productImgNo")%>">수정</a>
							</td>
				<%
							// 할인가격이 없을경우에만 할인추가표시가 생성
							if((int)productMap.get("productDiscountPrice") == ((int)productMap.get("productPrice"))) {
				%>
								<td>
									<a style="text-align:center;" href="<%=request.getContextPath()%>/discount/insertDiscount.jsp?productNo=<%=productMap.get("productNo")%>&productName=<%=productMap.get("productName")%>"><img width="30" height="30" src="<%=request.getContextPath()%>/product/icon/할인.png"></a>
								</td>
				<% 
							}
				%>
						</tr>
				<% 
						}
					}
				%>
		</table>
		<!--  페이징부분 -->
		  	<ul class="pagination justify-content-center list-group list-group-horizontal">
			<% 
				// 최소페이지가 1보다크면 이전페이지(이전페이지는 만약 내가 11페이지면 1페이지로 21페이지면 11페이지로)버튼
				if(minPage>1) {
			%>
					<li class="list-group-item">
						<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=minPage-pagePerPage%>&productName=<%=productName%>">이전</a>
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
							<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=i%>&productName=<%=productName%>"><%=i%></a>
						</li>
			<%				
					}
				}
				
				// maxPage가 마지막페이지와 다르다면 다음버튼 마지막페이지에서는 둘이 같으니 다음버튼이 안나오겠죠
				// 다음페이지(만약 내가 1페이지에서 누르면 11페이지로 11페이지에서 누르면 21페이지로)버튼
				if(maxPage != lastPage) {
			%>
					<li class="list-group-item">
						<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=minPage+pagePerPage%>&productName=<%=productName%>">다음</a>
					</li>
			<%	
				}
			%>
		</ul>
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