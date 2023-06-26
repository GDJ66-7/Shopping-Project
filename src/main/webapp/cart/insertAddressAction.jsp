<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	// 유효성검사
	if(request.getParameter("id")==null
		|| request.getParameter("addressName")==null		
		|| request.getParameter("address")==null
		|| request.getParameter("id").equals("")
		|| request.getParameter("addressName").equals("")
		|| request.getParameter("address").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cart/insertAddress.jsp");
		return;
	}

	// 받아온 값 변수에 저장
	String id = request.getParameter("id");
	String addressName = request.getParameter("addressName");
	String address = request.getParameter("address");
	System.out.println(id + " <-- insertAddressAction id");
	System.out.println(addressName + " <-- insertAddressAction addressName");
	System.out.println(address + " <-- insertAddressAction address");
	
	//  Address 객체를 사용
	Address voAddress = new Address();
	voAddress.setId(id);
	voAddress.setAddressName(addressName);
	voAddress.setAddress(address);
	
	// 11. 주소 내역에 주소 추가
	CartDao cartDao = new CartDao();
	int row = cartDao.insertAddress(voAddress);
%>


<%	
	if(row==1){
		System.out.println("추가 완료");
%>
		<script>
			// 팝업 창 닫기
			window.close();
			
			// 부모 창으로 이동
			window.opener.location.href = '<%= request.getContextPath() %>/cart/cartOrder.jsp';
		</script>
<%		
	}else{
		System.out.println("추가 실패");
		response.sendRedirect(request.getContextPath() + "/cart/insertAddress.jsp");
		return;
	}
%>

