<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>

<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	// 로그인 세션 유효성 검사 
	String id = null; // 아이디 변수 초기화

	// 관리자 계정으로 접속했을때
	if(session.getAttribute("loginEmpId1") != null || session.getAttribute("loginEmpId2") != null) {
		out.println("<script>alert('관리자 계정으로 로그인 중'); location.href='"+request.getContextPath()+"/main/home.jsp';</script>");
		return;
	}

	// 고객 계정으로 접속했을때
	if(session.getAttribute("loginCstmId") != null) {
		id = (String)(session.getAttribute("loginCstmId"));
		System.out.println(id+ " <-- cartList 고객아이디");
	}
	
	// 장바구니 세션이 없을때
	HashMap<String, Cart> newCartList = (HashMap<String, Cart>) session.getAttribute("newCartList");
	if (session.getAttribute("loginCstmId") == null && (newCartList == null || newCartList.isEmpty())) {
		out.println("<script>alert('장바구니가 비어있습니다.'); location.href='"+request.getContextPath()+"/main/home.jsp';</script>");
    	return;
	}
	
	// 비회원으로 접속했을때
	if(session.getAttribute("loginCstmId") == null) {
		newCartList = (HashMap<String, Cart>) session.getAttribute("newCartList");
		System.out.println(newCartList + " <-- cartList newCartList ");
		System.out.println(id + " <-- cartList 비회원");
	}
	
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
	
	// 비회원 장바구니 세션 값을 담을 리스트 생성
	ArrayList<HashMap<String,Object>> list2 = new ArrayList<>();
	
	// 비회원 접속했을때 장바구니 상품번호와 수량
	if(session.getAttribute("loginId")==null){
		HashMap<String, Cart> notLoginCart = (HashMap<String, Cart>) session.getAttribute("newCartList");
		if (notLoginCart != null) {
			for(Cart c : notLoginCart.values()){
				int productNo = c.getProductNo();
				int cartCnt = c.getCartCnt();
				// 21. 비회원 장바구니 출력
				ArrayList<HashMap<String, Object>> cartItemList = cartDao.notLoginSelectCart(productNo, cartCnt);
				list2.addAll(cartItemList);
			}
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
	<!-- 메인메뉴 시작 -->
		<jsp:include page="/main/menuBar.jsp"></jsp:include>
	<!-- 메인메뉴 끝 -->
	
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

	<!--================ Cart Area =================-->
<br>	
<br>	
	<div class="container">
		<div class="cart_inner">
			<!-- 비회원으로 로그인 -->
			<%
				if(id == null){ // 비회원
			%>	
				<table class="table">
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col"><h5>상품이름</h5></th>
							<th scope="col"><h5>상품가격</h5></th>
							<th scope="col"><h5>할인금액</h5></th>
							<th scope="col"><h5>할인적용가격</h5></th>
							<th scope="col"><h5>수량</h5></th>
							<th scope="col"><h5>전체가격</h5></th>			
						</tr>
					</thead>
					<tbody>
						<%
							int sum = 0; 
							for(HashMap<String,Object> m : list2){ 
								sum += (Integer) m.get("전체가격");
						%>
							<tr>			
								<td>
									<img src="${pageContext.request.contextPath}/product/productImg/<%=(String)(m.get("상품이미지"))%>" width="100" height="100">
								</td>
								<td>
									<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=(Integer)(m.get("상품번호"))%>">
										<%=(String)(m.get("상품이름"))%>
									</a>
								</td>
								<td>
									<h5><%=(Integer)(m.get("상품가격"))%>원</h5>
								</td>
								<td>
									<h5><%=(Integer)(m.get("할인금액"))%>원</h5>
								</td>
								<td>
									<h5><%=(Integer)(m.get("할인상품가격"))%>원</h5>
								</td>
								<td>
									<h5><%=(Integer)(m.get("수량"))%>개</h5>
								</td>
								<td>
									<h5><%=(Integer)(m.get("전체가격"))%>원</h5>
								</td>
							</tr>
						<%
							}
						%>										
				</table>   
			         
				<table class="table table-borderless" style="border-collapse: collapse; border: none;">
					
							<tr class="table table-borderless" style="text-align: center; border: 1px solid #B08EAD;">
								<th>
									<h4>총 상품가격 <%=sum%>원 + 총 배송비 0원 = 총 주문금액 <span style="color:red"><%=sum%></span></h4>
								</th>
							</tr>	
				</table>
	                          
				<table class="table table-borderless" style="border-collapse: collapse; border: none;">
					<tr>
						<td>
							<a href="<%=request.getContextPath()%>/product/productList.jsp">
								<button class="btn_1" type="button">계속쇼핑하기</button>
							</a>    
			            </td>
						<td style="text-align: right;">
							<a href="<%=request.getContextPath()%>/login/login.jsp">
								<button class="btn_1" type="button" onclick="alert('로그인을 해주세요.');">
									구매하기
								</button>
							</a>
						</td>			
					</tr>
					</tbody>
				</table>
			<%
				}
			%>					

			<!-- 고객 계정으로 로그인 -->
			<%
				if(id != null){ // 고객 계정
			%>
				<table class="table">
					<thead>
						<tr>
							<th scope="col"><h5>선택</h5></th>
							<th scope="col"></th>
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
							<td><!-- 상품 선택(체크) -->
								<!-- 체크 상태를 수정 하기 위한 폼 -->
								<form action="<%=request.getContextPath()%>/cart/updateCheckedAction.jsp" method="post">
									<input type="hidden" name=id value="<%=(String)(c.get("아이디"))%>">
									<input type="hidden" name=cartNo value="<%=(int)(c.get("장바구니번호"))%>">
									<label style="accent-color:#B08EAD;">	
										<input type="radio" name="checked" value="y" <%=(checked.equals("y")) ? "checked" : ""%>> Y
									</label>
									<label style="accent-color:#B08EAD;">	
										<input type="radio" name="checked" value="n" <%=(checked.equals("n")) ? "checked" : ""%>> N
									</label>
									<br>
									<input class="btn_1" type="submit" value="변경" style="width:60px; height:30px; text-align: center; padding: 0; line-height: 20px;">
								</form>
							</td>	
							<td><!-- 상품 이미지 -->
								<img src="${pageContext.request.contextPath}/product/productImg/<%=c.get("상품이미지")%>" width="100" height="100">
							</td>
							<td><!-- 상품 이름 -->
								<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>">
									<%=(String)(c.get("상품이름"))%>
								</a>	
							</td>
							<td><!-- 상품 가격 -->	
								<h5><%=(int)(c.get("상품가격"))%>원</h5>
							</td>				
							<td><!-- 할인 금액 -->	
								<h5><%=(int)(c.get("할인금액"))%>원</h5>
							</td>
							<td><!-- 할인 적용 가격 -->
								<h5><%=(int)(c.get("할인상품가격"))%>원</h5>
							</td>
							<td><!-- 수량 -->
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
									<br>
									<br>
									<input class="btn_1" type="submit" value="변경" style="width:60px; height:30px; text-align: center; padding: 0; line-height: 20px;">
								</form>
			                </td>				
			                <td><!-- 전체가격 -->
								<h5><%=(int)(c.get("전체가격"))%>원</h5>
			                </td>
			                <td> <!-- 단일 상품 삭제 -->	
			                	<!-- 단일행 삭제를 위한 폼 -->
								<form action="<%=request.getContextPath()%>/cart/deleteCartAction.jsp" method="post">
									<input type="hidden" name="cartNo" value="<%=(int)(c.get("장바구니번호"))%>">
									<input type="hidden" name="id" value="<%=(String)(c.get("아이디"))%>">				
									<input class="btn_1" type="submit" value="X" style="width:30px; height:30px; text-align: center; padding: 0; line-height: 20px;">
								</form>
			                </td>
	            		</tr>
						<%
							}
						%>	
				</table>             
				<table class="table table-borderless" style="border-collapse: collapse; border: none;">
					<%
						for(HashMap<String, Object> c : list7) {			
					%>
							<tr class="table table-borderless" style="text-align: center; border: 1px solid #B08EAD;">
								<th>
									<h4>총 상품가격 <%=c.get("전체금액")%>원 + 총 배송비 0원 = 총 주문금액 <span style="color:red"><%=c.get("전체금액")%></span></h4>
								</th>
							</tr>
					<%
						}
					%>	
				</table>
	                          
				<table class="table table-borderless" style="border-collapse: collapse; border: none;">
					<tr>
						<td>
							<a href="<%=request.getContextPath()%>/product/productList.jsp">
								<button class="btn_1" type="button">계속쇼핑하기</button>
							</a>    
			            </td>
				        <%
							if(CheckedItem) { // 체크된 상품이 있으면(y) cartOrder로
						%>
								<td style="text-align: right;">
									<a href="<%=request.getContextPath()%>/cart/cartOrder.jsp">
										<button class="btn_1" type="button">구매하기</button>
									</a>
								</td>
						<%
							} else { // 체크된 상품이 없으면(n) cartList로
						%>
								<td style="text-align: right;">
									<button class="btn_1" type="button" onclick="alert('상품을 선택해주세요.');">구매하기</button>	
								</td>			
						<%			
							}	 
						%>
					</tr>
					</tbody>
				</table>
			<%
				}
			%>	
		</div>
	</div>
	<!--================End Cart Area =================-->
	
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
                                <a href="<%=request.getContextPath()%>/customer/customerInfo.jsp">마이페이지</a>
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