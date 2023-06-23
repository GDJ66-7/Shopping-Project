<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//새션 확인 로그인 되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginEmpId1") != null 
		|| session.getAttribute("loginEmpId2") != null
		|| session.getAttribute("loginCstmId") != null){
		out.println("<script>alert('로그인 되어있습니다.'); location.href='"+request.getContextPath() + "/main/home.jsp';</script>");
		return;
	}
	// 요청값 디버깅
	System.out.println(request.getParameter("id")+"<-- loginAction.jsp id");
	System.out.println(request.getParameter("pw")+"<-- loginAction.jsp pw");
	//메세지 출력 변수 선언
	String msg = "";
	//요청값 유효성 검사
	if(request.getParameter("id") == null 
	|| request.getParameter("pw") == null){
		msg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/login/login.jsp?msg="+msg);
		return;
	}
	//요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	//요청값 변수 디버깅
		System.out.println(id+"<-- id");
		System.out.println(pw+"<-- pw");
	
	IdList idList = new IdList();
	idList.setId(id);
	idList.setPw(pw);
	
	//비밀번호가 맞는지 확인
	MemberDao checkPw = new MemberDao();
	int cRow = checkPw.checkPw(idList);
	if(cRow == 0){
		msg = URLEncoder.encode(" 아이디(로그인 전용 아이디) 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.","utf-8");
		response.sendRedirect(request.getContextPath()+"/login/login.jsp?msg="+msg);
		return;
	}
	
	MemberDao lg = new MemberDao();
	int row = lg.login(idList);
	
	if(row == 3){
		out.println("<script>alert('회원탈퇴한 아이디 이므로 로그인 할 수 없습니다.'); location.href='"+request.getContextPath() + "/login/login.jsp';</script>");
		return;
	}
	if(row == 0){
			msg = URLEncoder.encode("없는 아이디 이므로 로그인 할 수 없습니다.","utf-8");
			response.sendRedirect(request.getContextPath()+"/login/login.jsp?msg="+msg);
			return;
	}
	if(row == 1){
		
	//dao 사용하여 고객인지 확인
	MemberDao checkCstmId = new MemberDao();
	int cstmCnt = checkCstmId.loginCstmId(idList);
	
	// dao 사용하여 사원인지 확인
	MemberDao  checkEmpRow = new MemberDao();
	int empCnt = checkEmpRow.loginEmpId(idList);
	
	//고객도 아니고 사원도 아니라면 로그인 하면 안되므로 정보가 없는 아이디라고 메세지와 함께 되돌려보낸다
	if(cstmCnt == 0 && empCnt == 0){
		msg = URLEncoder.encode("정보가 없는 아이디 이므로 로그인 할 수 없습니다. 고객센터에 문의바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/login/login.jsp?msg="+msg);
		return;
	}
	
	if(cstmCnt > 0){
		session.setAttribute("loginCstmId", id);
		
		// 비회원 장바구니 세션에 담은 상품이 있으면 로그인한 아이디로 장바구니 옮김
		CartDao cartDao = new CartDao();
		cartDao.notLoginInsertCart(id, request);
		
		System.out.print("고객로그인 성공 새션정보 : " + session.getAttribute("loginCstmId"));
		out.println("<script>alert('로그인 되었습니다.'); location.href='"+request.getContextPath() + "/main/home.jsp';</script>");
		return;
	}
	if(empCnt > 0){
	// 사원 등급에 맞게 세션정보를 저장해야되므로분기
	// 등급 클래스에서 가져오기
	MemberDao checkEmpId = new MemberDao();
	String level = checkEmpId.loginEmpLevel(idList);
	if(level.equals("2")){
		session.setAttribute("loginEmpId2", id);
		System.out.println("최고관리자 로그인 성공 새션정보 : " + session.getAttribute("loginEmpId2"));
		out.println("<script>alert('최고관리자로 로그인 되었습니다.'); location.href='"+request.getContextPath() + "/main/home.jsp';</script>");
		return;
	}
	if(level.equals("1")){
		session.setAttribute("loginEmpId1", id);
		System.out.println("일반관리자 로그인 성공 새션정보 : " + session.getAttribute("loginEmpId1"));
		out.println("<script>alert('일반관리자로 로그인 되었습니다.'); location.href='"+request.getContextPath() + "/main/home.jsp';</script>");
		return;
			}
		}
	}

%>