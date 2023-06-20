<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//입력값 한글 깨지지 않기 위해 인코딩
	request.setCharacterEncoding("utf-8");
//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") == null){
		out.println("<script>alert('로그인 후 이용가능합니다'); location.href='"+request.getContextPath() + "/main/home.jsp';</script>");
		return;
	}
//요청값 디버깅
	System.out.println(request.getParameter("id")+"<-- updateCustomerAction.jsp id");
	System.out.println(request.getParameter("pw")+"<-- updateCustomerAction.jsp pw");
	System.out.println(request.getParameter("cstmAddress")+"<-- updateCustomerAction.jsp cstmAddress");
	System.out.println(request.getParameter("cstmEmail")+"<-- updateCustomerAction.jsp cstmEmail");
	System.out.println(request.getParameter("cstmPhone")+"<-- updateCustomerAction.jsp cstmPhone");
	
	//메세지 출력 변수 선언
			String msg = "";
			//요청값 유효성 검사
			if(request.getParameter("id") == null
					|| request.getParameter("pw") == null
					|| request.getParameter("cstmAddress") == null
					|| request.getParameter("cstmEmail") == null
					|| request.getParameter("cstmPhone") == null
					|| request.getParameter("id").equals("")
					|| request.getParameter("pw").equals("")
					|| request.getParameter("cstmAddress").equals("")
					|| request.getParameter("cstmEmail").equals("")
					|| request.getParameter("cstmPhone").equals("")){
				msg = URLEncoder.encode("모두입력해주시길 바랍니다.","utf-8");
				response.sendRedirect(request.getContextPath()+"/customer/updateCustomer.jsp?msg="+msg);
				return;
			}
		//요청값 변수에 저장
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String cstmAddress = request.getParameter("cstmAddress");
		String cstmEmail = request.getParameter("cstmEmail");
		String cstmPhone = request.getParameter("cstmPhone");
		//비밀번호 확인에 필요한 클래스 선언
		IdList onePw = new IdList();
		onePw.setId(id);
		onePw.setPw(pw);
		
		// 비밀번호가 맞는 확인하는 메소드 선언하고 실행
		MemberDao checkPw = new MemberDao();
			int checkRow = checkPw.checkPw(onePw);
			// 실행값에 따라 분기 0이상이면 비밀번호 맞고 0이면 비밀번호가 틀립니다.
			if(checkRow == 0){
				msg = URLEncoder.encode("비밀번호가 맞지 않으므로 다시 입력 바랍니다.","utf-8");
				response.sendRedirect(request.getContextPath()+"/customer/updateCustomer.jsp?msg="+msg);
				return;
			}
		//클래스에 값 저장
		Customer customer = new Customer();
		customer.setId(id);
		customer.setCstmAddress(cstmAddress);
		customer.setCstmEmail(cstmEmail);
		customer.setCstmPhone(cstmPhone);
		
		//수정메소드 실행 선언
		MemberDao updateCstm = new MemberDao();
		int row = updateCstm.modifyCustomer(customer);
		
		if(row > 0){
			msg = URLEncoder.encode("수정이 완료되었습니다","utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
			return;
		} else if(row == 0){
			msg = URLEncoder.encode("수정 불가능합니다. 고객센터에 문의 바랍니다","utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/customerInfo.jsp?msg="+msg);
			return;
		}
		
%>