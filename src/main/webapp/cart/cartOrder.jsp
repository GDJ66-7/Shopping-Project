<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>

<%
	// 한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	// 로그인 세션 유효성 검사 
	String id = null; // 아이디 변수 초기화

	//관리자 계정으로 접속했을때
	if(session.getAttribute("loginEmpId1") != null || session.getAttribute("loginEmpId2") != null) {
		out.println("<script>alert('관리자 계정으로 로그인 중'); location.href='"+request.getContextPath()+"/main/home.jsp';</script>");
		return;
	}

	// 고객 계정으로 접속했을때
	if(session.getAttribute("loginCstmId") != null) {
		id = (String)(session.getAttribute("loginCstmId"));
		System.out.println(id+ " <-- cartList 고객아이디");
	}
	
	// 비회원으로 접속했을때
	if(session.getAttribute("loginCstmId") == null) {	
	out.println("<script>alert('비회원으로 로그인 중'); location.href='"+request.getContextPath()+"/main/home.jsp';</script>");
	return;
	}
	
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
	
	// 7. 고객 주소 정보를 변수에 저장
	String customerAddress = "";
	for(HashMap<String, Object> c : list7) {
		customerAddress = (String)(c.get("배송주소"));
	}
	
	// 10. 주소 내역 리스트 불러오기
	ArrayList<String> list10 = cartDao.addressList(id);
	
	// 주소를 선택하지 않았을때 고객 주소를 기본값으로 설정
	if(request.getParameter("selectAddress")== null) {
		selectAddress = customerAddress;
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
	<!-- 메인메뉴 시작 -->
		<jsp:include page="/main/menuBar.jsp"></jsp:include>
	<!-- 메인메뉴 끝 -->
	
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
          		<h2><span style="font-size: 20px;">구매자 정보</span></h2>
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
					<th> 구매자 주소</th>
					<td><input type="text" value="<%=(String)(c.get("배송주소"))%>" readonly="readonly"></td>
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
				<h2><span style="font-size: 20px;">받는 사람 정보</span></h2>
			</div>
			<p> 주소를 선택하지 않으시면 고객님의 주소로 자동으로 선택됩니다.<br>주소 변경을 원하시면 주소를 추가하고 선택해주세요.</p>
			<form class="row contact_form" action="<%=request.getContextPath()%>/cart/cartOrder.jsp" method="post">
				<input type="hidden" name="id" value="<%=id%>">
				<input type="hidden" name="inputPoint" value="<%=inputPoint%>">
				<table>
					<tr>
						<th>기본 배송 주소</th>
					</tr>
					<tr>
						<td style="accent-color:#B08EAD;">
							<input type="radio" name="selectAddress" value="<%=customerAddress%>" checked="checked">
							<%=customerAddress%>
						<br>
						<br>
						</td>
					</tr>
					<tr>
						<th>최근 배송 주소</th>
					</tr>
					<%
						for(String address : list10) {
					%>
							<tr>	
								<td style="accent-color:#B08EAD;">
									<input type="radio" name="selectAddress" value="<%=address%>" <%if (address.equals(selectAddress)) { %>checked<% } %>>
									<%=address%>
								</td>
							</tr>
					<%
						}
					%>
					<tr>
						<td>
						<br>
							<input class="btn_1" style="width:140px; height:30px; text-align: center; padding: 0; line-height: 20px;" type="submit" value="주소 선택">
						</td>
						<td>
						<br>
							<a class="btn_1" style="width:140px; height:30px; text-align: center; padding: 0; line-height: 30px;" href="#" onclick="addressOpenPopup('<%=request.getContextPath()%>/cart/insertAddress.jsp?id=<%=id%>')">주소추가</a>
						</td>
					</tr>
				</table>
			</form>  
		</div>
      	<br>
      	<!--  결제 정보  -->
		<div class="billing_details">
			<div class="check_title">
				<h2><span style="font-size: 20px;">포인트 사용</span></h2>
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
								<input class="btn_1" style="color: white; background-color: #B08EAD; width:140px; height:30px; text-align: center; padding: 0; line-height: 20px;" type="submit" value="포인트 사용하기">
							</div>
						</td>
						</tr>
	              	</table>
            	</form>
			</div>
          
			<!-- 주문내역 -->
			<div class="col-lg-4">
            	<div class="order_box">
            		<div style="text-align:center;">
              			<h1><span style="color: #B08EAD;">주문 내역</span></h1>
            		</div>
            		<br>
              		<!-- 배송 상품 목록 -->
						<table class="table">	
							<tr>
								<th style="text-align:left;">상품이름</th>
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
								<td style="text-align: right;">
								<br>
									<form action="<%=request.getContextPath()%>/cart/cartOrderAction.jsp">		
										<input type="hidden" name="id" value="<%=id%>">	
										<input type="hidden" name="totalCartCnt" value="<%=totalCartCnt%>">	
										<input type="hidden" name="totalPay" value="<%=totalPay%>">	
										<input type="hidden" name="selectAddress" value="<%=selectAddress%>">	
										<input type="hidden" name="inputPoint" value="<%=inputPoint%>">					
										<input class="btn_1" style="width:200px; height:50px; text-align: center; padding: 0; line-height: 30px;" type="submit" value="결제하기">			
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