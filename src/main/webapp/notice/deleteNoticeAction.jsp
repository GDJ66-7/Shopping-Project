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
//요청값 디버깅 
	System.out.println(request.getParameter("noticeNo")+"<-- updateNoticeAction.jsp param noticeNo");
//요청값 변수에 저장	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
//메세지출력 변수선언
	String msg = "";
	//메서드 실행 선언
	NoticeDao no = new NoticeDao();
	int row = no.removeNotice(noticeNo);
	if(row > 0){
		msg = URLEncoder.encode("공지사항이 삭제 완료되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp?msg="+msg);
		return;
	} else if(row == 0){
		msg = URLEncoder.encode("공지사항 삭제가 불가합니다. 기술팀에 문의 바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp?msg="+msg);
		return;
	}
%>