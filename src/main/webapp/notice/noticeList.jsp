<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//요청값 유효성 검사
String search = "";
if(request.getParameter("search") != null){
	search = request.getParameter("search");
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
	// 검색을 했을때와 안했을때의 리스트 분기
	// 사용할 변수 미리 선언
	ArrayList<HashMap<String, Object>> noticeList = null;
	int totalRow = 0;
	
	//메서드 선언 과 변수 선언
	NoticeDao li = new NoticeDao();
	noticeList = li.selectNoticeList(beginRow, rowPerPage, search);
	totalRow = li.selectNoticeRow(search);
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
                        <h2>공지사항</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

  <!-- ================ contact section start ================= -->
    <div class="container">
    <br>
  		<form action="<%=request.getContextPath()%>/notice/noticeList.jsp" method="get">
		 	<input type="text" name="search" placeholder="공지사항 검색(Enter)" class="single-input"><br>
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
						<th>번호</th>
						<th>타이틀</th>
						<th>작성일</th>
						<th>수정일</th>
					</tr>
					<%
						for(HashMap<String, Object> s : noticeList){
					%>	
					<tr>
						<td><%=(Integer)(s.get("번호"))%></td>
						<th><a style="color: #DBB5D6;" href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=(Integer)(s.get("번호"))%>"><%=(String)(s.get("타이틀"))%></a></th>
						<td><%=(String)(s.get("작성일"))%></td>
						<td><%=(String)(s.get("수정일"))%></td>
					</tr>
					<%
						}
					%>
				</table>
				<div style="text-align: center;">
			<%
				if(startPage > 5){
			%>
				<a class="styled-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=startPage-1%>">이전</a>
			<%
				}
				for(int i = startPage; i<=endPage; i++){
			%>
				<a class="styled-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=i%>"><%=i%></a>
			<%
				}
				if(endPage<lastPage){
			%>
				<a class="styled-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=endPage+1%>">다음</a>
			<%
				}
			%>
		</div>
    </div><br>
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
                                <%	// 관리자는 관리자회원정보
                                	if(session.getAttribute("loginEmpId2") != null || session.getAttribute("loginEmpId1") != null) {
                                %>
                                		<a href="<%=request.getContextPath()%>/employee/employeeInfo.jsp">관리자정보</a>
                                <% 
                                	// 고객은 고객회원정보
                                	} else {
                                %>
                                		<a href="<%=request.getContextPath()%>/customer/customerInfo.jsp">마이페이지</a>
                                <% 
                                	}
                                %>
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