<%@page import="java.net.URLEncoder"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
		
	String dir = request.getServletContext().getRealPath("/review/reviewImg");
	System.out.println(dir+"<----");
	int max = 10 * 1024 * 1024; // 10MB
	
	// DefaultFileRenamePolicy 중복제거 메서드
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	//mRequest.getOriginalFileName("reviewImg") 값이 null이면 리뷰테이블 text만 수정
	
	// 받아온 값 저장 (text) 전부 mRequest로 받고 저장해야 한다
	String msg="";
	int historyNo = Integer.parseInt(mRequest.getParameter("historyNo"));
	int productNo = Integer.parseInt(mRequest.getParameter("productNo"));
	String reviewTitle = mRequest.getParameter("reviewTitle");
	String reviewContent = mRequest.getParameter("reviewContent");
	
	System.out.println(historyNo+"<---update review action historyno");
	System.out.println(productNo+"<---update review action pno");
	System.out.println(reviewContent+"<---update review action content");
	System.out.println(reviewTitle+"<---update review action title");
	
	//리뷰 요청값 유효성 검사 (+수정시에도 공백X)
	if(("historyNo") == null||("historyNo").equals("")
	||("productNo") == null ||("productNo").equals("")
	||("reviewContent") == null ||("reviewContent").equals("")
	||("reviewTitle") == null ||("reviewTitle").equals("")){
		response.sendRedirect(request.getContextPath()+"/review/reviewOne.jsp");
		return;
	}
	
	//review text만 수정 (이미지 새로 업로드 안 할 시)---------------------------------------------------------
	
	ReviewDao reviewdao = new ReviewDao(); // dao 호출
	Review reviewtext = new Review(); // 객체 저장
	reviewtext.setHistoryNo(historyNo);
	reviewtext.setProductNo(productNo);
	reviewtext.setReviewTitle(reviewTitle);
	reviewtext.setReviewContent(reviewContent);
	 
    // 텍스트 수정 메서드 호출
    int row = reviewdao.updateReview(reviewtext);
   
   // review img 수정 -----------------------------------------------------------------------------------
   // 리뷰 이미지 수정 메서드 호출 & vo 객체 생성
    if(mRequest.getOriginalFileName("reviewImg") != null) { 
    	// 수정하는 파일이 존재하나 파일타입이 유효하지 않을 때
    	if(mRequest.getContentType("reviewImg").equals("image/jpeg") == false) { // 파일 유효성 검사
    	System.out.println("JPG파일이 아닙니다");
    	String saveFilename = mRequest.getFilesystemName("reviewImg");
		File f = new File(dir+"/"+saveFilename);
		if(f.exists()) {
			f.delete();
			System.out.println(saveFilename+"파일삭제");
			msg = URLEncoder.encode("JPG파일만 업로드 가능합니다.","utf-8");
			response.sendRedirect(request.getContextPath()+"/review/updateReview.jsp?historyNo="+historyNo+"&productNo="+productNo+"&msg="+msg);
		return;}
    } else {
    	// 수정 파일이 유효할 시
		// 1) 이전 파일(saveFilename) 삭제
		// 2) db수정(update)
		String type = mRequest.getContentType("reviewImg");
    	String originFilename = mRequest.getOriginalFileName("reviewImg");
    	String saveFilename = mRequest.getFilesystemName("reviewImg");
		
    	ReviewImg reviewImg = new ReviewImg(); //vo
    	reviewImg.setHistoryNo(historyNo); //객체 저장
    	reviewImg.setReviewOriFilename(originFilename);
    	reviewImg.setReviewSaveFilename(saveFilename);
    	reviewImg.setReviewFiletype(type);
    	
    	reviewdao.deleteReviewImg(historyNo, dir);  // 1) 이전 파일 삭제 메서드 호출
		reviewdao.updateReviewImg(reviewImg); // 2) 이미지 db수정 메서드 호출
		}
    }
	response.sendRedirect(request.getContextPath() + "/review/reviewOne.jsp?historyNo="+historyNo+"&productNo="+productNo);

%>