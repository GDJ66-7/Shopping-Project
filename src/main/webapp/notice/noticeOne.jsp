<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	String loginEmpId1 = (String)(session.getAttribute("loginEmpId1"));
	String loginEmpId2 = (String)(session.getAttribute("loginEmpId2"));
	// 요청값 유효성 검사
	System.out.println(request.getParameter("noticeNo")+"<-- noticeOne.jsp param noticeNo");
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
		return;
	}
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo + "<-- noticeOne.jsp noticeNo");
	// 보여줄 상세보기 메서드 선언
	NoticeDao no = new NoticeDao();
	ArrayList<HashMap<String, Object>> noticeList = no.noticeOne(noticeNo);
	
%>
<!doctype html>
<html lang="zxx">

<head>
<style>
.table {
  width: 100%;
  border-collapse: collapse;
}

.table th{
  padding: 8px;
  
}
.table td {
  padding: 8px;
  
}

.resize-handle {
  width: 8px;
  cursor: col-resize;
  background-color: #f2f2f2;
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
    <br><div class="col-12">
         	 <h2 class="contact-title">공지사항 상세보기</h2>
        </div>
  		<h2>
  			<%
  				if(request.getParameter("msg") != null){
  			%>
  				<%=request.getParameter("msg")%>
  			<%
  				}
  			%>
		 </h2>
		<table class="table">
		  <colgroup>
		    <col style="width: 10%">
		    <col style="width: 90%">
		  </colgroup>
		  <% for(HashMap<String, Object> s : noticeList) { %>
		    <tr>
		      <th>공지번호</th>
		      <td><%= (Integer)(s.get("번호")) %></td>
		    </tr>
		    <tr>
		      <th>작성일</th>
		      <td><%= (String)(s.get("작성일")) %></td>
		    </tr>
		    <tr>
		      <th>수정일</th>
		      <td><%= (String)(s.get("수정일")) %></td>
		    </tr>
		    <tr>
		      <th>제목</th>
		      <td><%= (String)(s.get("제목")) %></td>
		    </tr>
		    <tr>
		      <th>내용</th>
		      <td><%= (String)(s.get("내용")) %></td>
		    </tr>
		</table>


			<%
				if(loginEmpId1 != null || loginEmpId2 != null){
			%>
					<a href="<%=request.getContextPath()%>/notice/updateNotice.jsp?noticeNo=<%=(Integer)(s.get("번호"))%>" class="genric-btn primary-border circle">수정하기</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=(Integer)(s.get("번호"))%>" class="genric-btn primary-border circle">삭제하기</a>
			<%
					}	
		  }
			%>
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