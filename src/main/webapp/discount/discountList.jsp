<%@page import="java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// dao 객체 생성
	DiscountDao dDao = new DiscountDao();
	CategoryDao cDao = new CategoryDao();	

	//관리자 할인상품리스트는 전체할인상품을 보여주므로 매개변수 공백값처리.
	String productName =  request.getParameter("productName");
	String categoryName = request.getParameter("categoryName");	
	
	
	// 초기값이을 공백으로 잡아서 전체리스트를 출력하게 한다. (Dao에서 공백일때 초기값으로지정)
	if(productName == null) {
		productName = "";
	}
	if(categoryName == null) {
		categoryName = "";
	}
	
	System.out.println(productName + "<-- discountList productName");
	System.out.println(categoryName + "<-- discountList categoryName");
	
	
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
	
	int totalRow = dDao.productListCnt1(productName, categoryName);
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
	
	// 1. 상품 할인 리스트 조회하기
	ArrayList<HashMap<String, Object>> discountList = new ArrayList<>();
	discountList = dDao.discountList(productName, categoryName, beginRow, rowPerPage);
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
	<!-- msg alert출력 -->
	<%
		if(request.getParameter("insertDiscountMsg") != null) {
	%>
			<script>
				alert('할인상품등록이 완료되었습니다.');
			</script>
	<% 
		} else if(request.getParameter("insertDiscountMsg2") != null) {
	%>
			<script>
				alert('할인상품등록에 실패하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("updateDiscountMsg") != null) {
	%>
			<script>
				alert('할인상품수정을 완료하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("updateDiscountMsg2") != null) {
	%>
			<script>
				alert('할인상품수정을 실패하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("deleteDiscountMsg") != null) {
	%>
			<script>
				alert('할인상품(개별)삭제를 완료하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("deleteDiscountMsg") != null) {
	%>
			<script>
				alert('할인상품(개별)삭제를 완료하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("deleteDiscountMsg2") != null) {
	%>
			<script>
				alert('할인상품(개별)삭제를 실패하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("allDeleteDiscountMsg") != null) {
	%>
			<script>
				alert('기간만료할인상품(전체) 삭제를 완료하였습니다.');
			</script>
	<% 
		} else if(request.getParameter("allDeleteDiscountMsg2") != null) {
	%>
			<script>
				alert('기간만료할인상품(전체) 삭제를 실패하였습니다. (기간이 만료된 상품이 없을 수 있습니다.)');
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
                        <h2>상품할인관리페이지(수정,삭제)</h2> 
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
	     	<form style="text-align:center;" action="<%=request.getContextPath()%>/discount/discountList.jsp" method="get">
		      	<div class="styled-input">
		      																		<!-- value값이 초기엔 null이라 value값을 보여주지 않는다 ex) 침대를 검색시 침대값이 유지된 상태로 검색된다. -->
		      		<input style="text-align: center;" type="text" name="productName" <%if(request.getParameter("productName") != null) {%> value="<%=request.getParameter("productName")%>" <%}%> placeholder="상품이름검색">
		      		<button class="genric-btn primary-border circle" type="submit">검색</button>
		      	</div>
		      	<ul class="navbar-nav">
               		<li>
               			<input type="checkbox" name="categoryName" value="">전체보기
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
			<%
		    	if(session.getAttribute("loginEmpId2") != null) {
		    %>
					<div style="text-align:left;">
						<a class="genric-btn primary-border circle" id="deleteDiscount"><span style="color: red;">할인기간종료상품 전체삭제</span></a>
					</div>
		    <% 
		    	}
		    %>
		    
		    <script>
			$(document).ready(function() {
				$('#deleteDiscount').click(function() {
			    	event.preventDefault();
			    	if (confirm("전체 할인 상품을 삭제하시겠습니까?")) {
				        // 확인 버튼을 클릭하면 아래 주소로 이동
				    	var url = '<%=request.getContextPath()%>/discount/allDeleteDiscountAction.jsp';
				    	// url주소로 이동
				    	window.location.href = url;
			      	}else {
			        	// 취소 버튼을 클릭한 경우에 수행할 동작을 여기에 작성
			        	return;
			      	}
				});
			});
			</script>
			<br>
			<table style="width:100%; height:100%">
				<tr class="backgroundColor">
					<th>할인번호</th>
					<th>상품번호</th>
					<th>상품이름</th>
					<th>상품원가</th>
					<th>상품할인가</th>
					<th>할인시작일</th>
					<th>할인종료일</th>
					<th>할인율</th>
					<th>할인수정일</th>
					<th>할인수정</th>
					<th>할인삭제</th>
				</tr>
				<%
					for(HashMap<String,Object> dMap : discountList) {
						java.text.NumberFormat numberFormat = java.text.NumberFormat.getInstance();
						String discountPrice = numberFormat.format(dMap.get("productPrice")); 
						
						// 할인율이 double타입이라 십의단위로 나타내고 싶어 형변환후 *100
						double discountRate = (double) dMap.get("discountRate");
						int discountRatePercentage = (int) (discountRate * 100);
				%>
					<tr>
						<td>
							<%=dMap.get("discountNo") %>
						</td>
						<td>
							<%=dMap.get("productNo") %>
						</td>
						<td>
							<%=dMap.get("productName") %>
						</td>
						<td>
							<%=discountPrice %>원
						</td>
						<td>
							<span style="color: red;"><%=(int)dMap.get("productDiscountPrice")%>원</span>
						</td>
						<td>
							<%=dMap.get("discountStart") %>
						</td>
						<td>
							<%=dMap.get("discountEnd") %>
						</td>
						<td>
							<%=discountRatePercentage %>%
						</td>
						<td>
							<%=dMap.get("updatedate") %>
						</td>
				<%
		    			if(session.getAttribute("loginEmpId2") != null) {
		    	%>
							<td>
								<a href="<%=request.getContextPath()%>/discount/updateDiscount.jsp?discountNo=<%=dMap.get("discountNo")%>&productName=<%=dMap.get("productName")%>&productNo=<%=dMap.get("productNo")%>&discountStart=<%=dMap.get("discountStart")%>"> 
									수정
								</a>
							</td>
							<td>
								<a href="<%=request.getContextPath()%>/discount/deleteDiscountAction.jsp?discountNo=<%=dMap.get("discountNo")%>&productName=<%=dMap.get("productName")%>&productNo=<%=dMap.get("productNo")%>">
									삭제
								</a>
							</td>
		    	<% 
		    			}
		    	%>
					</tr>
				<% 	
					}
				%>
		</table>
		<!--  페이징부분 -->
			
		  	<ul class="pagination justify-content-center list-group list-group-horizontal">
			<% 
				/*
				// 최소페이지가 1보다크면 이전페이지(이전페이지는 만약 내가 11페이지면 1페이지로 21페이지면 11페이지로)버튼
				if(minPage>1) {
			%>
					<li class="list-group-item">
						<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=minPage-pagePerPage%>&productName=<%=productName%>&categoryName=<%=categoryName%>">이전</a>
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
							<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=i%>&productName=<%=productName%>&categoryName=<%=categoryName%>"><%=i%></a>
						</li>
			<%				
					}
				}
				
				// maxPage가 마지막페이지와 다르다면 다음버튼 마지막페이지에서는 둘이 같으니 다음버튼이 안나오겠죠
				// 다음페이지(만약 내가 1페이지에서 누르면 11페이지로 11페이지에서 누르면 21페이지로)버튼
				if(maxPage != lastPage) {
			%>
					<li class="list-group-item">
						<a href="<%=request.getContextPath()%>/product/empProductList.jsp?currentPage=<%=minPage+pagePerPage%>&productName=<%=productName%>&categoryName=<%=categoryName%>">다음</a>
					</li>
			<%	
				}
				*/
			%>
		</ul>
		</div>
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