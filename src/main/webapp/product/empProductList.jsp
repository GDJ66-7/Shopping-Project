<%@page import="dao.CategoryDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ProductDao pDao = new ProductDao();
	CategoryDao cDao = new CategoryDao();

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
	System.out.println(productName + "<-- empProductList productName");
	System.out.println(categoryName + "<-- empProductList categoryName");
	System.out.println(discountProduct + "<-- empProductList discountProduct");
	System.out.println(ascDesc + "<-- empProductList ascDesc");
	
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
	ArrayList<HashMap<String,Object>> cList = cDao.categoryNameList();
	
%>

<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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
	<!-- msg출력 -->
	<%
		if(request.getParameter("updateProductMsg") != null) {
	%>
			<script>
				alert('상품수정이 완료되었습니다.');
			</script>
	<% 
		} else if(request.getParameter("updateProductMsg2") != null) {
	%>
			<script>
				alert('상품수정을 실패하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("insertproductMsg") != null) {
	%>
			<script>
				alert('상품을 추가하였습니다.');
			</script>
	<% 
		}
	%>
    <!--::header part start::-->
	<!-- 메인메뉴 바 -->
	<jsp:include page="/main/menuBar.jsp"></jsp:include>
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
	     		<form style="text-align:center;" id="empProductSearchForm" action="<%=request.getContextPath()%>/product/empProductList.jsp" method="get">
   					<div class="styled-input">
	   																						<!-- value값이 초기엔 null이라 value값을 보여주지 않는다 ex) 침대를 검색시 침대값이 유지된 상태로 검색된다. -->
	              		<input style="text-align: center;"  type="text" name="productName" <%if(request.getParameter("productName") != null) {%> value="<%=request.getParameter("productName")%>" <%}%> placeholder="상품이름검색">
                		<button class="genric-btn primary-border circle" type="submit" id="productBtn">검색</button>
                	</div>
                	<ul class="navbar-nav">
                   		<li>					<!-- value값이 초기엔 null이라 value값을 보여주지 않는다 ex) 침대를 검색시 침대값이 유지된 상태로 검색된다. -->
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
                           			for(HashMap<String, Object> categoryNameMap : cList) {
                           		%>	
                          					<input type="checkbox" name="categoryName"  value="<%=categoryNameMap.get("categoryName")%>" 
                          					<% if(request.getParameter("categoryName") != null && request.getParameter("categoryName").equals(categoryNameMap.get("categoryName"))) { %> checked <% } %>>
                           					<%=categoryNameMap.get("categoryName")%>
                           		<% 	
                           			
                           			}
                           		%>
                           	</li>
		         	</ul>
	           	 </form>
	                <!---------------------- js부분 -------------------------->
	              	 <script>
	               	// radio는 누르기만 해도 값이 넘어간다.
	                let radio = $('input[type="radio"]');
		                radio.on('change', function() {
		                $('#empProductSearchForm').submit();
	                }); 
	                </script>
		      	</div>
		    </div>
		    <%
		    	if(session.getAttribute("loginEmpId2") != null) {
		    %>
				    <div style="right: = auto;">
				    	<a class="genric-btn info-border circle" href="<%=request.getContextPath()%>/product/insertProduct.jsp">상품추가하기</a>
				    </div>
		    <% 
		    	}
		    %>
		    <br>
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
						java.text.NumberFormat numberFormat = java.text.NumberFormat.getInstance();
						String productPrice = numberFormat.format(productMap.get("productPrice")); 
						String discountPrice = numberFormat.format(productMap.get("productDiscountPrice"));
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
								원가:<%=productPrice %>
								<br>
								
								<span class="discounted-price">할인가:<%=discountPrice %></span>
							</td>
				<% 
						} else {
				%>
							<td>
								<img class="product-image" src="${pageContext.request.contextPath}/product/productImg/<%=productMap.get("productSaveFilename") %>" width="50" height="50">
								<span  class="product-name"><%=productMap.get("productName") %></span>
							</td>
							<td><%=productPrice %>원</td>
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
							<td>
				<%
							// 할인가격이 없을경우에만 할인추가표시가 생성
							if((int)productMap.get("productDiscountPrice") == ((int)productMap.get("productPrice"))) {
				%>
									<a style="text-align:center;" href="<%=request.getContextPath()%>/discount/insertDiscount.jsp?productNo=<%=productMap.get("productNo")%>&productName=<%=productMap.get("productName")%>"><img width="30" height="30" src="<%=request.getContextPath()%>/product/icon/할인.png"></a>
				<% 
							}
				%>
							</td>
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
						<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=minPage-pagePerPage%>&productName=<%=productName%>&categoryName=<%=categoryName%>&ascDesc=<%=ascDesc%>&discountProduct=<%=discountProduct%>">이전</a>
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
							<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=i%>&productName=<%=productName%>&categoryName=<%=categoryName%>&ascDesc=<%=ascDesc%>&discountProduct=<%=discountProduct%>"><%=i%></a>
						</li>
			<%				
					}
				}
				
				// maxPage가 마지막페이지와 다르다면 다음버튼 마지막페이지에서는 둘이 같으니 다음버튼이 안나오겠죠
				// 다음페이지(만약 내가 1페이지에서 누르면 11페이지로 11페이지에서 누르면 21페이지로)버튼
				if(maxPage != lastPage) {
			%>
					<li class="list-group-item">
						<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=minPage+pagePerPage%>&productName=<%=productName%>&categoryName=<%=categoryName%>&ascDesc=<%=ascDesc%>&discountProduct=<%=discountProduct%>">다음</a>
					</li>
			<%	
				}
			%>
		</ul>
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