<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <!--::header part start::-->
    <header class="main_menu home_menu">
        <div class="container">
            <div class="row align-items-center justify-content-center">
            	<div style="text-align: center;"> 
              		<div class="col-lg-12">
	                    <nav class="navbar navbar-expand-lg navbar-light">
	                    							<!--  이부분 경로 수정해야 로고 눌러도 홈으로 옴 -->
	                        <a class="navbar-brand" href="<%=request.getContextPath()%>/main/home.jsp"> <img src="<%=request.getContextPath()%>/css/img/logo.png" alt="logo"> </a>
	                        <button class="navbar-toggler" type="button" data-toggle="collapse"
	                            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
	                            aria-expanded="false" aria-label="Toggle navigation">
	                            <span class="menu_icon"><i class="fas fa-bars"></i></span>
	                        </button>
							<div>
							<div style="text-align: center;" class="collapse navbar-collapse main-menu-item" id="navbarSupportedContent">
								<ul class="navbar-nav">
									<li class="nav-item">
							            <a class="nav-link" href=""></a>
							        </li>
							    	<li class="nav-item">
							            <a class="nav-link" href="<%=request.getContextPath()%>/main/home.jsp">Home</a>
							        </li>
							        <!--  회사개요페이지 아직 미완성 -->
							        <li class="nav-item">
							            <a class="nav-link" href="about.html">회사개요</a>
							        </li>
							        <li class="nav-item">
							            <a class="nav-link" href="<%=request.getContextPath()%>/product/productList.jsp" id="navbarDropdown_1">
							                상품
							            </a>
							            <!--  우선 사용안하니 주석처리
							            <div class="dropdown-menu" aria-labelledby="navbarDropdown_1">
							                <a class="dropdown-item" href="<%=request.getContextPath()%>/product/productList.jsp"> 상품 목록</a>
							            </div>
							             -->
							        </li>
							        <!-- 공지사항 관리자는 공지사항추가 목록 나옴 -->
							        <%
							        	if(session.getAttribute("loginEmpId1") != null || session.getAttribute("loginEmpId2") != null) {
							        %>
							        		<li class="nav-item dropdown">
									            <a class="nav-link dropdown-toggle" href="<%=request.getContextPath()%>/notice/noticeList.jsp">
									            	공지사항
									            </a>
									            <div class="dropdown-menu" aria-labelledby="navbarDropdown_2">
									            	<a class="dropdown-item" href="<%=request.getContextPath()%>/notice/insertNotice.jsp">공지사항 추가</a>
									            </div>
								       		</li>
						            <%
						            	// 일반고객은 공지사항만 표시
						        		} else {
						        	%>
						        			<li class="nav-item">
							    	            <a class="nav-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp">
							    	            	공지사항
							    	            </a>
						    	        	</li>
						        	<% 	
						        		}
							        	if(session.getAttribute("loginEmpId1") != null || session.getAttribute("loginEmpId2") != null) {
							        %>
									    <li class="nav-item dropdown">
								            <a class="nav-link dropdown-toggle" href="blog.html" id="navbarDropdown_2"
								                role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								                관리자페이지
								            </a>
								            <div class="dropdown-menu" aria-labelledby="navbarDropdown_2">
								                <a class="dropdown-item" href="<%=request.getContextPath()%>/employee/employeeInfo.jsp"> 관리자정보</a>
								                <a class="dropdown-item" href="<%=request.getContextPath()%>/category/categoryList.jsp">카테고리 관리</a>
								    <%	// 관리자2만 상품관리가 가능
								        	if(session.getAttribute("loginEmpId2") != null || session.getAttribute("loginEmpId1") != null) {
								    %>	
						           				<a class="dropdown-item" href="<%=request.getContextPath()%>/product/empProductList.jsp">상품관리(추가,수정,상품할인추가)</a>
						           				<a class="dropdown-item" href="<%=request.getContextPath()%>/discount/discountList.jsp">상품할인관리(수정,삭제)</a>
								            </div>
							        	</li>
								    <%
								            } 
								        } else { 
								    %>
								    		<li class="nav-item">
									    		<a class="nav-link" href="<%=request.getContextPath()%>/customer/customerInfo.jsp" id="navbarDropdown_1">
													마이페이지
												</a>
											</li>
							        <%
							        	}
						
							        	if(session.getAttribute("loginEmpId1") == null && session.getAttribute("loginEmpId2") == null && session.getAttribute("loginCstmId") == null) {
								    %>
									        <li class="nav-item">
									        	<a class="nav-link" href="<%=request.getContextPath()%>/login/login.jsp">
									            	login
									            </a>
								    	    </li>
						    	    <%
							        	}
							        %>
							        
							        <%
							        	if(session.getAttribute("loginEmpId1") != null || session.getAttribute("loginEmpId2") != null || session.getAttribute("loginCstmId") != null) {
								    %>
									         <li class="nav-item">
									            <a class="nav-link" href="<%=request.getContextPath()%>/login/logoutAction.jsp">logout</a>
									        </li>
							        <%
							        	}
							        %>
								</ul>
							</div>
							</div>
	                        <div class="hearer_icon d-flex align-items-center">
	                        <!--  돋보기 기능아직 없음 -->
	                            <a id="search_1" href="javascript:void(0)"><i class="ti-search"></i></a>
	                            <a href="<%=request.getContextPath()%>/cart/cartList.jsp">
	                                <i class="flaticon-shopping-cart-black-shape"></i>
	                            </a>
	                        </div>
	                    </nav>
                	</div>   
                </div>
            </div>
        </div>
        <div class="search_input" id="search_input_box">
            <div class="container ">
                <!--  메뉴바 오른쪽 돋보기 상품검색기능 -->
                <form class="d-flex justify-content-between search-inner" action="<%=request.getContextPath()%>/product/productList.jsp" method="post">
                    <input type="text" class="form-control" name="searchName"  placeholder="상품이름검색">
                    <button type="submit" class="btn"></button>
                    <span class="ti-close" id="close_search" title="Close Search"></span>
                </form>
            </div>
        </div>
    </header>
</body>
</html>