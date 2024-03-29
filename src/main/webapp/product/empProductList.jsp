<%@page import="dao.CategoryDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginEmpId2") == null) {
		out.println("<script>alert('최고 관리자만 접근 가능합니다.'); location.href='"+request.getContextPath()+"/main/home.jsp';</script>");
		return;
	}

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
  
  /* 스타일링된 링크 */
  .styled-link {
     display: inline-block;
     padding: 6px 10px; /* 패딩 */
     background-color: #DBB5D6; /* 배경색 */
     color: #F6F6F6; /* 텍스트 색상 */
     text-decoration: none; /* 텍스트 장식 제거 */
     border-radius: 4px; /* 테두리 반경 */
     box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* 그림자 */
     transition: background-color 0.3s ease, color 0.3s ease; /* 호버 효과 전환 시간과 속도 조정 */
   }
   
   /* 링크 호버 효과 */
   .styled-link:hover {
     background-color: #FFB2D9; /* 호버 시 배경색 변경 */
     color: #fff; /* 호버 시 텍스트 색상 변경 */
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
		} else if(request.getParameter("insertProductMsg") != null) {
	%>
			<script>
				alert('상품을 추가하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("updateProductMsg3") != null) {
	%>
			<script>
				alert('jpg파일만 넣어주세요.');
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
	   				<label for="productName">
	             													<!-- value값이 초기엔 null이라 value값을 보여주지 않는다 ex) 침대를 검색시 침대값이 유지된 상태로 검색된다. -->
	                   	<input style="text-align: center;" type="text" placeholder="상품검색" name="productName" <%if(request.getParameter("productName") != null) {%> value="<%=request.getParameter("productName")%>" <%}%>>
	                   		<button class="genric-btn primary-border circle" type="submit" id="productBtn">검색</button>
	                </label>
                	<div class="checkbox">
			        	<button type="button" class="btn btn-link" data-toggle="collapse" data-target="#categoryCollapse" aria-expanded="true">
			               <p>카테고리</p>
			            </button>
			            <div class="collapse" id="categoryCollapse">
			                <% 
			                	for (HashMap<String, Object> categoryNameMap : cList) { 
			                %>
				                    <div class="form-check form-check-inline">
				                        <input type="checkbox" class="form-check-input" name="categoryName" value="<%= categoryNameMap.get("categoryName") %>" <% if(request.getParameter("categoryName") != null && request.getParameter("categoryName").equals(categoryNameMap.get("categoryName"))) { %> checked <% } %>>
				                        <label class="form-check-label"><%= categoryNameMap.get("categoryName") %></label>
				                    </div>
			                <% 
			                	} 
			                %>
			            </div>
		        	</div>
		        	
		        	<div class="radio">
			            <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#sortCollapse" aria-expanded="true">
			                <p>정렬</p>
			            </button>
			            <div class="collapse" id="sortCollapse">
			                <div class="form-check form-check-inline">
			                    <input type="radio" class="form-check-input" name="discountProduct" value="" <% if(request.getParameter("discountProduct") == null || request.getParameter("discountProduct").equals("")) { %> checked <% } %>>
			                    <label class="form-check-label">전체상품보기</label>
			                    
			                    <input type="radio" class="form-check-input" name="discountProduct" value="할인상품" <% if(request.getParameter("discountProduct") != null && request.getParameter("discountProduct").equals("할인상품")) { %> checked <% } %>>
			                    <label class="form-check-label">할인상품보기</label>
			                    
			                    <input type="radio" class="form-check-input" name="ascDesc" value="asc" <% if(request.getParameter("ascDesc") != null && request.getParameter("ascDesc").equals("asc")) { %> checked <% } %>>
			                    <label class="form-check-label">오래된순</label>
			                    
			                    <input type="radio" class="form-check-input" name="ascDesc" value="desc" <% if(request.getParameter("ascDesc") != null && request.getParameter("ascDesc").equals("desc")) { %> checked <% } %>>
			                    <label class="form-check-label">최신순</label>
		                	</div>
			            </div>
			        </div>
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
							<td><a style="color: black;" href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productMap.get("productNo")%>"><%=productMap.get("productNo") %></a></td>
							<td><%=productMap.get("categoryName") %></td>
				<% 			
						// 할인이 들어간 상품은 빨간글씨로 이름표시하며 할인가도 같이 나옴
						if ((int)productMap.get("productDiscountPrice") != ((int)productMap.get("productPrice"))) {
				%>
							<td>
								<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productMap.get("productNo")%>">
									<img class="product-image" src="${pageContext.request.contextPath}/product/productImg/<%=productMap.get("productSaveFilename") %>" width="50" height="50">
									<span  class="product-name" style="color: red;"><%=productMap.get("productName") %></span>
								</a>
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
								<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productMap.get("productNo")%>">
									<img class="product-image" src="${pageContext.request.contextPath}/product/productImg/<%=productMap.get("productSaveFilename") %>" width="50" height="50">
									<span style="color: black;" class="product-name"><%=productMap.get("productName") %></span>
								</a>
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
								<a href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=productMap.get("productNo")%>&productImgNo=<%=productMap.get("productImgNo")%>"><img width="30" height="30" src="<%=request.getContextPath()%>/product/icon/수정1.png"></a>
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
		<br>
		<!--  페이징부분 -->
		<div style="text-align: center;">
			<% 
				// 최소페이지가 1보다크면 이전페이지(이전페이지는 만약 내가 11페이지면 1페이지로 21페이지면 11페이지로)버튼
				if(minPage>1) {
			%>
						<a class="styled-link" href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=minPage-pagePerPage%>&productName=<%=productName%>&categoryName=<%=categoryName%>&ascDesc=<%=ascDesc%>&discountProduct=<%=discountProduct%>">이전</a>
			<%			
				}
				// 최소 페이지부터 최대 페이지까지 표시
				for(int i = minPage; i<=maxPage; i=i+1) {
					if(i == currentPage) {	// 현재페이지는 링크 비활성화
			%>	
						<!-- i와 현재페이지가 같은곳이라면 현재위치한 페이지 빨간색표시 -->
							<span class="styled-link" style="color: black;"><%=i %></span>
			<%			
					// i가 현재페이지와 다르다면 출력
					}else {					
			%>		
							<a class="styled-link" href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=i%>&productName=<%=productName%>&categoryName=<%=categoryName%>&ascDesc=<%=ascDesc%>&discountProduct=<%=discountProduct%>"><%=i%></a>
			<%				
					}
				}
				
				// maxPage가 마지막페이지와 다르다면 다음버튼 마지막페이지에서는 둘이 같으니 다음버튼이 안나오겠죠
				// 다음페이지(만약 내가 1페이지에서 누르면 11페이지로 11페이지에서 누르면 21페이지로)버튼
				if(maxPage != lastPage) {
			%>
						<a class="styled-link" href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=minPage+pagePerPage%>&productName=<%=productName%>&categoryName=<%=categoryName%>&ascDesc=<%=ascDesc%>&discountProduct=<%=discountProduct%>">다음</a>
			<%	
				}
			%>
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