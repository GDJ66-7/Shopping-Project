<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") == null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") != null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
//세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginCstmId"));
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
	//고객 포인트 리스트 메소드 사용
	PointDao li = new PointDao();
	ArrayList<HashMap<String, Object>> list = li.cstmPointList(beginRow, rowPerPage, id);
	//총 행의 수를 얻기위한 메소드 사용
	PointDao tr = new PointDao();
	int totalRow = tr.selectPointRow(id);
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
	<h1>포인트 내역 목록</h1>
	<%
		for(HashMap<String, Object> s : list){
	%>
		<table>
			<tr>
				<td>주문번호</td>
				<td>포인트 추가 또는 감소</td>
				<td>적립일자</td>
			</tr>
			<tr>
				<td><%=(Integer)(s.get("주문번호"))%></td>
				<td><%=(String)(s.get("증감"))%><%=(Integer)(s.get("포인트"))%></td>
				<td><%=(String)(s.get("적립일자"))%></td>
			</tr>
		</table>
	<%
		}
	%>
	<div>
		<%
			if(startPage > 5){
		%>
			<a href="<%=request.getContextPath()%>/customer/coustomerPointList.jsp?currentPage=<%=startPage-1%>">이전</a>
		<%
			}
			for(int i = startPage; i<=endPage; i++){
		%>
			<a href="<%=request.getContextPath()%>/customer/coustomerPointList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
			}
			if(endPage<lastPage){
		%>
			<a href="<%=request.getContextPath()%>/customer/coustomerPointList.jsp?currentPage=<%=endPage+1%>">다음</a>
		<%
			}
		%>
	</div>
</body>
</html>