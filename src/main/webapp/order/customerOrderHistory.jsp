<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>

<%
//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") == null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
//세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginCstmId"));
// 날짜 검색했을때 변수 선언
	String startDate = "";
	String endDate = "";
	if(request.getParameter("startDate") != null){
		startDate = request.getParameter("startDate");
	}
	if(request.getParameter("endDate") != null ){
		endDate = request.getParameter("endDate");
	}
	//보여줄페이지 첫번째 행 선언
		int currentPage = 1; 
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//페이지당 보여줄 행
		int rowPerPage = 10;
		// 시작할 행 알고리즘 사용
		int beginRow = (currentPage -1) * rowPerPage;
		
		//세션아이디 디버깅
		System.out.println(id+"<-- id");	
	// 구매내역 리스트 메소드 사용
	OrderDao li = new OrderDao();
	ArrayList<HashMap<String, Object>> list =li.orderList(id, startDate, endDate, beginRow, rowPerPage);
	//총 행의 수를 얻기위한 메소드 사용
	OrderDao tr = new OrderDao();
	int totalRow = tr.selectOrder(id, startDate, endDate);
	System.out.println(totalRow+"<-- totalRow");
	// 라스트 페이즐 구하기 위한 변수선언
	int lastPage = totalRow/rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage++;
	}
	int pageCount = 5;// 페이지당 출력될 페이지수
	// startPage가 currentPage가 1~10이면 1로 고정 11~20이면 2로 고정되게 소수점을 이용하여 고정값 만드는 알고리즘
	int startPage = ((currentPage -1)/pageCount)*pageCount+1;
	// startPage에서 9를 더한값이 마지막 출력될 Page이지만 lastPage보다 커지면 endPage는 lastpage로변환
	int endPage = startPage+9;
	if(endPage > lastPage){
	endPage = lastPage;
	}
	System.out.println(startPage+"<-- startPage");
	System.out.println(endPage+"<-- endPage");
%>
<!doctype html>
<html lang="zxx">

<head>
<style>
    /* 스타일링된 링크 */
    .styled-link {
      display: inline-block;
      padding: 6px 10px; /* 패딩 */
      background-color: #B08EAD; /* 배경색 */
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
<style>
	  /* 스타일링된 링크 */
	  .styled-linke {
	    display: inline-block;
	    padding: 6px 5px; /* 패딩 */
	    background-color: #B08EAD; /* 배경색 */
	    color: #F6F6F6; /* 텍스트 색상 */
	    text-decoration: none; /* 텍스트 장식 제거 */
	    border-radius: 6px; /* 테두리 반경 */
	    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* 그림자 */
	    transition: background-color 0.3s ease, color 0.3s ease; /* 호버 효과 전환 시간과 속도 조정 */
	    width: 120px; /* 크기 고정 */
	    text-align: center; /* 글자 가운데 정렬 */
	    font-size: 13px;
		font-weight: 500;
	     
	  }
	
	  /* 링크 호버 효과 */
	  .styled-linke:hover {
	    background-color: #fff; /* 호버 시 배경색 변경 */
	    color: black; /* 호버 시 텍스트 색상 변경 */
	    
	  }
<style>
  #ckId {
    padding: 0px 20px; /* 원하는 패딩 값을 지정하세요 */
    font-size: 10px; /* 원하는 폰트 크기를 지정하세요 */
  }
  /* 컨테이너 스타일 */
.date-container {
  position: relative;
  display: inline-block;
}

/* 가짜 input 스타일 */
.custom-date {
  padding: 10px;
  font-size: 16px;
  color: #333;
  background-color: #fff;
  border: 1px solid #ccc;
  border-radius: 4px;
  cursor: pointer;
}

/* 가짜 input 아이콘 스타일 */
.custom-date::after {
  content: "\f073";
  font-family: "Font Awesome 5 Free";
  font-weight: 900;
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  pointer-events: none;
}

/* 실제 input 요소 스타일 */
.custom-date input[type="date"] {
  opacity: 0;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  cursor: pointer;
}

/* 가짜 input에 포커스 스타일 */
.custom-date:focus-within {
  outline: none;
  box-shadow: 0 0 0 2px lightblue; /* 포커스 시에 원하는 스타일을 적용하세요. */
}
</style>
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
    <div>
		<jsp:include page="/main/menuBar.jsp"></jsp:include>
	</div>
    <!-- Header part end-->

    <!-- breadcrumb part start-->
    <section class="breadcrumb_part">
        <div class="container" style="margin-left: 70px; margin-right: 70px;">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>주문 내역</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

  <!-- ================ contact section start ================= -->
    <div class="container">
    <br><div class="col-12">
         	 <h2 class="contact-title">주문 상세 정보</h2>
        </div>
	<p>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</p>
	<form action="<%=request.getContextPath()%>/order/customerOrderHistory.jsp" action="post">

		<div class="date-container">
 				<input type="date" name="startDate" id="birth" class="custom-date">
 				&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;
 				<input type="date" name="endDate" id="birth" class="custom-date">
		</div>
		&nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" class="genric-btn primary-border circle">검색</button>
	</form><br>
	
		<table class="table">
		
			<tr>
				<td style="width: 120px;">주문번호</td>
				<td>상품이름</td>
				<td style="width: 120px;">결제상태</td>
				<td  style="width: 120px;">배송상태</td>
				<td  style="width: 60px;">수량</td>
				<td>주문가격</td>
				<td  style="width: 160px;">주문배송지</td>
				<td  style="width: 140px;">구매일</td>
				<td></td>
				<td></td>
			</tr>
			<%
				for(HashMap<String, Object> s : list){
					java.text.NumberFormat numberFormat = java.text.NumberFormat.getInstance();
					String productPrice = numberFormat.format(s.get("주문가격"));
			%>
			<tr>
				<td><%=(Integer)(s.get("주문번호"))%></td>
				<td><a style="color: #B08EAD;" href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=(Integer)(s.get("상품번호"))%>"><%=(String)(s.get("상품이름"))%></a></td>
				<td><%=(String)(s.get("결제상태"))%></td>
				<td><%=(String)(s.get("배송상태"))%></td>
				<td><%=(Integer)(s.get("수량"))%></td>
				<td><%=productPrice%></td>
				<td><%=(String)(s.get("주문배송지"))%></td>
				<td><%=(String)(s.get("구매일"))%></td>
				<%
					if(s.get("배송상태").equals("구매취소")){
				%>
					<td></td>
					<td></td>
				<%
					}
					if(s.get("결제상태").equals("결제대기") || s.get("배송상태").equals("배송중")){
				%>
				<td><a  class="styled-linke" href="<%=request.getContextPath()%>/order/deleteOrder.jsp?orderNo=<%=(Integer)(s.get("주문번호"))%>">주문취소하기</a></td>
				<%
					}
					if(s.get("결제상태").equals("결제완료") && s.get("배송상태").equals("배송중")){
				%>
				<td><a class="styled-linke" href="<%=request.getContextPath()%>/order/orderComplete.jsp?orderNo=<%=(Integer)(s.get("주문번호"))%>">구매확정</a></td>
				<%
					}
					if(s.get("배송상태").equals("구매확정")){
				%>
				<td><a class="styled-linke" href="<%=request.getContextPath()%>/review/insertReview.jsp?historyNo=<%=(Integer)(s.get("주문내역번호"))%>&productNo=<%=(Integer)(s.get("상품번호"))%>">리뷰쓰기</a></td><td></td>
				<%
					}
				%>				
			</tr>
			<%
				}
			%>
		</table>
	
	<div style="text-align: center;">
		<%
			if(startPage > 5){
		%>
			<a class="styled-link" href="<%=request.getContextPath()%>/order/customerOrderHistory.jsp?currentPage=<%=startPage-1%>">이전</a>
		<%
			}
			for(int i = startPage; i<=endPage; i++){
		%>
			<a class="styled-link"  href="<%=request.getContextPath()%>/order/customerOrderHistory.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
			}
			if(endPage<lastPage){
		%>
			<a class="styled-link" href="<%=request.getContextPath()%>/order/customerOrderHistory.jsp?currentPage=<%=endPage+1%>">다음</a>
		<%
			}
		%>
	</div>
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
                                <a href="<%=request.getContextPath()%>/main/home.jsp">Home</a>
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