<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") == null){
		out.println("<script>alert('로그인 후 이용가능합니다.'); location.href='"+request.getContextPath() + "/main/home.jsp';</script>");
		return;
	}
	System.out.println(request.getParameter("orderNo")+"<-- deleteOrder.jsp orderNo");
	//메세지 출력 변수 선언
	String msg = "";
	if(request.getParameter("orderNo") == null || request.getParameter("orderNo").equals("")){
		msg = URLEncoder.encode("취소할 주문을 선택해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/order/customerOrderHistory.jsp?msg="+msg);
		return;
	}
	//요청값 변수에 저장
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	OrderDao del = new OrderDao();
	int row = del.cancelOrder(orderNo);
	if(row > 0){
			OrderDao pointCancle = new OrderDao();
			int pRow = pointCancle.cancelPoint(orderNo);
		if(pRow > 0){
			out.println("<script>alert('취소가 완료되었습니다.'); location.href='"+request.getContextPath() + "/order/customerOrderHistory.jsp';</script>");
			return;
		}else{ 
			msg = URLEncoder.encode("현재 주문이 취소 불가능하므로 고객센터에 문의 바랍니다","utf-8");
			response.sendRedirect(request.getContextPath()+"/order/customerOrderHistory.jsp?msg="+msg);
			System.out.println("point 취소 실패");
			return;	
		}
	}else if(row == 0){
		msg = URLEncoder.encode("현재 주문이 취소 불가능하므로 고객센터에 문의 바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/order/customerOrderHistory.jsp?msg="+msg);
		return;
	}
%>