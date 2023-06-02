<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
// 세션 확인 관리자만 들어올 수 있도록
if(session.getAttribute("loginEmpId1") == null 
		|| session.getAttribute("loginEmpId2") == null
		|| session.getAttribute("loginCstmId") == null
		|| session.getAttribute("loginCstmId") != null
		|| session.getAttribute("loginCstmId").equals("")
		|| !session.getAttribute("loginCstmId").equals("")){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
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
	//모든 고객 포인트 리스트 메소드 사용
	PointDao li = new PointDao();
	ArrayList<HashMap<String, Object>> pointList = li.pointList(beginRow, rowPerPage);
	//총 행의 수를 얻기위한 메소드 사용
		PointDao tr = new PointDao();
		int totalRow = tr.pointRow();
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
	<h1>고객포인트 목록</h1>
	<%
		for(HashMap<String, Object> s : pointList){
	%>
		<table>
			<tr>
				<td>고객아이디</td>
				<td>포인트</td>
			</tr>
			<tr>
				<td><%=(String)(s.get("고객아이디"))%></td>
				<td><%=(Integer)(s.get("포인트"))%></td>
			</tr>
		</table>
	<%
		}
	%>
	<div>
		<%
			if(startPage > 5){
		%>
			<a href="<%=request.getContextPath()%>/point/pointHistoryList.jsp?currentPage=<%=startPage-1%>">이전</a>
		<%
			}
			for(int i = startPage; i<=endPage; i++){
		%>
			<a href="<%=request.getContextPath()%>/point/pointHistoryList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
			}
			if(endPage<lastPage){
		%>
			<a href="<%=request.getContextPath()%>/point/pointHistoryList.jsp?currentPage=<%=endPage+1%>">다음</a>
		<%
			}
		%>
	</div>
</body>
</html>