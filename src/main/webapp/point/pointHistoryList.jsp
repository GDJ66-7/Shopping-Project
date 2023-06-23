<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
// 세션 확인 관리자만 들어올 수 있도록
if(session.getAttribute("loginEmpId1") == null && session.getAttribute("loginEmpId2") == null){
	out.println("<script>alert('관리자만 이용가능합니다.'); location.href='"+request.getContextPath() + "/main/home.jsp';</script>");
		return;
	}
//보여줄페이지 첫번째 행 선언
	int currentPage = 1; 
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	String id ="";
	if(request.getParameter("id") != null){
		id = request.getParameter("id");
	}
	//페이지당 보여줄 행
	int rowPerPage = 10;
	// 시작할 행 알고리즘 사용
	int beginRow = (currentPage -1) * rowPerPage;
	//모든 고객 포인트 리스트 메소드 사용
	PointDao li = new PointDao();
	ArrayList<HashMap<String, Object>> pointList = li.pointList(beginRow, rowPerPage, id);
	//총 행의 수를 얻기위한 메소드 사용
		PointDao tr = new PointDao();
		int totalRow = tr.pointRow(id);
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
      background-color: #B08EAD; /* 호버 시 배경색 변경 */
      color: #fff; /* 호버 시 텍스트 색상 변경 */
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
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>고객 포인트 정보</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

  <!-- ================ contact section start ================= -->
    <div class="container">
    <br><div class="col-12">
         	 <h2 class="contact-title">포인트 내역 상세보기</h2>
        </div>
	    <form action="<%=request.getContextPath()%>/point/pointHistoryList.jsp" method="get">
			 	<input type="text" name="id" placeholder="고객 검색(Enter)" class="single-input"><br>
		 </form>
  		<p>
  			<%
  				if(request.getParameter("msg") != null){
  			%>
  				<%=request.getParameter("msg")%>
  			<%
  				}
  			%>
  		</p>
		<table class="table">
			<tr>
				<th>주문번호</th>
				<th>고객아이디</th>
				<th>포인트적립</th>
				<th>적립일</th>
			</tr>
			<%
				for(HashMap<String, Object> s : pointList){
			%>	
			<tr>
				<td><%=(Integer)(s.get("주문번호"))%></td>
				<td><%=(String)(s.get("고객아이디"))%></td>
				<td><%=(String)(s.get("증감"))%>&nbsp;<%=(Integer)(s.get("포인트"))%></td>
				<td><%=(String)(s.get("적립일자"))%></td>
			</tr>
			<%
				}
			%>
		</table>
	
	<div style="text-align: center;">
		<%
			if(startPage > 5){
		%>
			<a class="styled-link" href="<%=request.getContextPath()%>/point/pointHistoryList.jsp?currentPage=<%=startPage-1%>">이전</a>
		<%
			}
			for(int i = startPage; i<=endPage; i++){
		%>
			<a class="styled-link" href="<%=request.getContextPath()%>/point/pointHistoryList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
			}
			if(endPage<lastPage){
		%>
			<a class="styled-link" href="<%=request.getContextPath()%>/point/pointHistoryList.jsp?currentPage=<%=endPage+1%>">다음</a>
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