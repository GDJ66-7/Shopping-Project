<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%
//세션관리자만 들어올수있게
	if(session.getAttribute("loginEmpId1") == null && session.getAttribute("loginEmpId") == null){
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
		return;
	}
	String msg = "";
	//요청값 유효성 검사
	System.out.println(request.getParameter("noticeTitle")+"<--  noticeTitle");
	System.out.println(request.getParameter("noticeContent")+"<--  noticeContent");	
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	//클래스에 요청값 담기
		Notice notice = new Notice();
		notice.setNoticeTitle(noticeTitle);
		notice.setNoticeContent(noticeContent);
	//추가하는 메서드 선언
	NoticeDao no = new NoticeDao();
	int row = no.insertNotice(notice);
		
	if(row > 0){
		msg = URLEncoder.encode("공지사항이 추가 완료되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp?msg="+msg);
		return;
	} else if(row == 0){
		msg = URLEncoder.encode("공지사항 추가가 불가합니다. 기술팀에 문의 바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp?msg="+msg);
		return;
	}
%>