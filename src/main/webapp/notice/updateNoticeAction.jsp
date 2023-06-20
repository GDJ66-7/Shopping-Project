<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%
//세션관리자만 들어올수있게
	if(session.getAttribute("loginEmpId1") == null && session.getAttribute("loginEmpId") == null){
		out.println("<script>alert('관리자만 이용가능합니다.'); location.href='"+request.getContextPath() + "/notice/noticeList.jsp';</script>");
		return;
	}
	String msg = "";
	//요청값 유효성 검사
	System.out.println(request.getParameter("noticeNo")+"<-- updateNoticeAction.jsp param noticeNo");
	System.out.println(request.getParameter("noticeTitle")+"<-- updateNoticeAction noticeTitle");
	System.out.println(request.getParameter("noticeContent")+"<-- updateNoticeAction noticeContent");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	//클래스에 요청값 담기
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	// 수정할 메서드 선언
	NoticeDao no = new NoticeDao();
	int row = no.modifyNotice(notice);
	if(row > 0){
		msg = URLEncoder.encode("수정이 완료되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo+"&msg="+msg);
		return;
	} else if(row == 0){
		msg = URLEncoder.encode("수정 불가능합니다. 기술팀에 문의 바랍니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo+"&msg="+msg);
		return;
	}
%>