<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
//세션 확인 관리자만 들어올 수 있도록
if(session.getAttribute("loginEmpId1") == null 
		|| session.getAttribute("loginEmpId2") == null
		|| session.getAttribute("loginCstmId") == null
		|| session.getAttribute("loginCstmId") != null
		|| session.getAttribute("loginCstmId").equals("")
		|| !session.getAttribute("loginCstmId").equals("")){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
	//요청값 디버깅
	System.out.println(request.getParameter("id")+"<--id");
	System.out.println(request.getParameter("startDate")+"<--id");
	System.out.println(request.getParameter("endDate")+"<--id");
	// 사용할 변수 선언
	String id = "";
	String startDate = "";
	String endDate = "";
	String msg = "";
	ArrayList<HashMap<String, Object>> allList = null;
	int totalRow = 0;
	//보여줄페이지 첫번째 행 선언
		int currentPage = 1; 
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//페이지당 보여줄 행
		int rowPerPage = 10;
		// 시작할 행 알고리즘 사용
		int beginRow = (currentPage -1) * rowPerPage;
	//유효성 검사하면 변수에 값넣기
	if(request.getParameter("id") != null){
		id = request.getParameter("id");
	}
	if(request.getParameter("startDate") != null){
		startDate = request.getParameter("startDate");
	}
	if(request.getParameter("endDate") != null ){
		endDate = request.getParameter("endDate");
	}
	if(startDate != null && endDate == null && !startDate.equals("") && endDate.equals("")){
		msg = URLEncoder.encode("날짜를 두개 다 선택해주시길 바랍니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/order/orderList.jsp?msg="+msg);
		return;
	} else if(endDate != null && startDate == null && !endDate.equals("") && startDate.equals("")){
		msg = URLEncoder.encode("날짜를 두개 다 선택해주시길 바랍니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/order/orderList.jsp?msg="+msg);
		return;
	}
	
	//검색조건별 메서드 분기
	//1- 검색도 안하고 날짜도 검색안했을때 리스트 전체를 보여줄 메서드
	if(id == null && startDate == null && endDate == null
	&& id.equals("") && startDate.equals("") && endDate.equals("")){
			
			AdminOrderDao all = new AdminOrderDao();
			allList = all.orderAllList(beginRow, rowPerPage); 
			totalRow = all.orderAllRow();
	//유저 이름만 검색했을때 리스트를 보여줄 메서드
	}else if(id != null && startDate == null && endDate == null
			&& !id.equals("") && startDate.equals("") && endDate.equals("")){
			
			AdminOrderDao idList = new AdminOrderDao();
			allList = idList.searchOrderList(id, beginRow, rowPerPage);
			totalRow = idList.searchOrderRow(id);
	//날짜만 검색했을때 리스트를 보여줄 메소드
	} else if(startDate != null && endDate != null && id == null
			&& !startDate.equals("") && !endDate.equals("") && id.equals("")){
			
			AdminOrderDao dateList = new AdminOrderDao();
			allList = dateList.dateOrderList(startDate, endDate, beginRow, rowPerPage);
			totalRow = dateList.dateOrderRow(startDate, endDate);
	//남짜와 유저 이름을 검색했을때 리스트를 보여주는 메서드
	} else if(id != null && startDate != null && endDate != null
			&& !id.equals("") && !startDate.equals("") &&  !endDate.equals("")){
		
		AdminOrderDao idDateList = new AdminOrderDao();
		 allList = idDateList.searchDateOrder(id, startDate, endDate, beginRow, rowPerPage);
		totalRow = idDateList.searchDateOrderRow(id, startDate, endDate);
	}
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>고객 구매내역</h1>
	<h1>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</h1>
	<form action="<%=request.getContextPath()%>/order/orderList.jsp" action="post">
		<input type="text" name="id" placeholder="고객 이름"><br>
		<input type="date" name="startDate">부터<input type="date" name="endDate">
	</form>
	<%
		for(HashMap<String, Object> s : allList){
	%>
		<table>
			<tr>
				<td>주문자</td>
				<td>주문번호</td>
				<td>상품이름</td>
				<td>결제상태</td>
				<td>배송상태</td>
				<td>수량</td>
				<td>주문가격</td>
				<td>주문배송지</td>
				<td>구매일</td>
			</tr>
			<tr>
				<td><%=(String)(s.get("주문자"))%></td>
				<td><%=(String)(s.get("주문번호"))%></td>
				<td><%=(String)(s.get("상품이름"))%></td>
				<td><%=(String)(s.get("결제상태"))%></td>
				<td><%=(String)(s.get("배송상태"))%></td>
				<td><%=(Integer)(s.get("수량"))%></td>
				<td><%=(Integer)(s.get("주문가격"))%></td>
				<td><%=(String)(s.get("주문배송지"))%></td>
				<td><%=(String)(s.get("구매일"))%></td>
			</tr>
		</table>
	<%
		}
	%>
	<div>
		<%
			if(startPage > 5){
		%>
			<a href="<%=request.getContextPath()%>/order/orderList.jsp?currentPage=<%=startPage-1%>">이전</a>
		<%
			}
			for(int i = startPage; i<=endPage; i++){
		%>
			<a href="<%=request.getContextPath()%>/order/orderList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
			}
			if(endPage<lastPage){
		%>
			<a href="<%=request.getContextPath()%>/order/orderList.jsp?currentPage=<%=endPage+1%>">다음</a>
		<%
			}
		%>
	</div>
</body>
</html>