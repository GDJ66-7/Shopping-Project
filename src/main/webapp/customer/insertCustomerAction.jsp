<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//입력값 한글 깨지지 않기 위해 인코딩
	request.setCharacterEncoding("utf-8");
	//새션 확인 로그인 되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") != null){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
	//요청값 디버깅
	System.out.println(request.getParameter("id")+"<-- insertCustomerAction.jsp id");
	System.out.println(request.getParameter("pw")+"<-- insertCustomerAction.jsp pw");
	System.out.println(request.getParameter("checkPw")+"<-- insertCustomerAction.jsp checkPw");
	System.out.println(request.getParameter("cstmName")+"<-- insertCustomerAction.jsp cstmName");
	System.out.println(request.getParameter("cstmAddress")+"<-- insertCustomerAction.jsp cstmAddress");
	System.out.println(request.getParameter("cstmEmail")+"<-- insertCustomerAction.jsp cstmEmail");
	System.out.println(request.getParameter("cstmBirth")+"<-- insertCustomerAction.jsp cstmBirth");
	System.out.println(request.getParameter("cstmPhone")+"<-- insertCustomerAction.jsp cstmPhone");
	System.out.println(request.getParameter("cstmQuestion")+"<-- insertCustomerAction.jsp cstmQuestion");
	System.out.println(request.getParameter("cstmGender")+"<-- insertCustomerAction.jsp cstmGender");
	System.out.println(request.getParameter("cstmAgree")+"<-- insertCustomerAction.jsp cstmAgree");

	
	//메세지 출력 변수 선언
		String msg = "";
		//요청값 유효성 검사
		if(request.getParameter("id") == null 
		|| request.getParameter("pw") == null
		|| request.getParameter("checkPw") == null
		|| request.getParameter("cstmName") == null
		|| request.getParameter("cstmAddress") == null
		|| request.getParameter("cstmEmail") == null
		|| request.getParameter("cstmBirth") == null
		|| request.getParameter("cstmPhone") == null
		|| request.getParameter("cstmGender") == null
		|| request.getParameter("cstmAgree") == null
		|| request.getParameter("id").equals("")
		|| request.getParameter("pw").equals("")
		|| request.getParameter("checkPw").equals("")
		|| request.getParameter("cstmName").equals("")
		|| request.getParameter("cstmAddress").equals("")
		|| request.getParameter("cstmEmail").equals("")
		|| request.getParameter("cstmBirth").equals("")
		|| request.getParameter("cstmPhone").equals("")
		|| request.getParameter("cstmGender").equals("")
		|| request.getParameter("cstmAgree").equals("")){
			msg = URLEncoder.encode("모두입력해주시길 바랍니다.","utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/insertCustomer.jsp?msg="+msg);
			return;
		}
		//비밀번호 확인 같은지 체크
		if(!request.getParameter("pw").equals(request.getParameter("checkPw"))){
			msg = URLEncoder.encode("비밀번호가 서로 다릅니다.","utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/insertCustomer.jsp?msg="+msg);
			return;
		}
		
		//요청값 변수에 저장
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String cstmName = request.getParameter("cstmName");
		String cstmAddress = request.getParameter("cstmAddress");
		String cstmEmail = request.getParameter("cstmEmail");
		String cstmBirth = request.getParameter("cstmBirth");
		String cstmPhone = request.getParameter("cstmPhone");
		String cstmGender = request.getParameter("cstmGender");
		String cstmAgree = request.getParameter("cstmAgree");
		String cstmQuestion = request.getParameter("cstmQuestion");
		//IdList 클래스에 변수값저장
		IdList idList = new IdList();
		idList.setId(id);
		idList.setPw(pw);
		//MemberDao 메소드 사용 선언
		MemberDao insertId = new MemberDao();
		int row = insertId.insertId(idList);
		// Method 받아오는 값에 따라 상황별 분기
		if(row == 3){
			msg = URLEncoder.encode("이미 있는 아이디입니다. 다른아이디로 바꿔주시길바랍니다.","utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/insertCustomer.jsp?msg="+msg);
			return;
		}
		if(row == 0){
			msg = URLEncoder.encode("잘못된정보입니다. 다시입력해주시길바랍니다.","utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/insertCustomer.jsp?msg="+msg);
			return;
		}
		//클래스에 회원정보 담기
		Customer customer = new Customer();
		customer.setId(id);
		customer.setCstmName(cstmName);
		customer.setCstmAddress(cstmAddress);
		customer.setCstmEmail(cstmEmail);
		customer.setCstmBirth(cstmBirth);
		customer.setCstmPhone(cstmPhone);
		customer.setCstmGender(cstmGender);
		customer.setCstmAgree(cstmAgree);
		customer.setCstmQuestion(cstmQuestion);
		
		MemberDao insertCstm = new MemberDao();
		int inRow = insertCstm.insertCustomer(customer);
		if(inRow > 0){
			msg = URLEncoder.encode("회원가입 완료되었습니다..","utf-8");
			response.sendRedirect(request.getContextPath()+"/login/login.jsp?msg="+msg);
			return;
		}
%>