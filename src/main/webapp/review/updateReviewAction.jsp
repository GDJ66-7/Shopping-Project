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
	
	// 리뷰 요청값 유효성 검사
	if(mRequest.getParameter("orderNo") != null
	||mRequest.getParameter("productNo") != null
	||mRequest.getParameter("reviewTitle") != null
	||mRequest.getParameter("reviewContent") != null) {
	
	// 받아온 값 저장
	int productNo = Integer.parseInt(mRequest.getParameter("productNo"));
	int orderNo = Integer.parseInt(mRequest.getParameter("orderNo"));
	String reviewTitle = mRequest.getParameter("reviewTitle");
	String reviewContent = mRequest.getParameter("reviewContent");
	
	System.out.println(productNo + "<---update r.a no");
	System.out.println(orderNo + "<---update r.a no");
	System.out.println(reviewTitle + "<---update r.a title");
	System.out.println(reviewContent + "<---update r.a content");

	ReviewDao reviewdao = new ReviewDao(); // dao 호출
	
	//vo 객체 생성(텍스트)
    Review reviewtext = new Review();
    reviewtext.setOrderNo(orderNo);
    reviewtext.setProductNo(productNo);
    reviewtext.setReviewTitle(reviewTitle);
    reviewtext.setReviewContent(reviewContent);
    
    // 텍스트 수정 메서드 호출
    int row = reviewdao.updateReview(reviewtext);
    
    // 이전 파일 삭제
    int delPreImg = reviewdao.deleteReviewImg(orderNo,dir);
    if (delPreImg ==1){
    	System.out.println("이전 파일 삭제 성공");
    }
    
    // 리뷰 이미지 수정 메서드 호출 & vo 객체 생성
    if(mRequest.getFilesystemName("reviewImg") != null){
    	String type = mRequest.getContentType("reviewImg");
    	String oriFilename = mRequest.getOriginalFileName("reviewImg");
    	String saveFilename = mRequest.getFilesystemName("reviewImg");
    	
    	ReviewImg reviewImg = new ReviewImg(); //vo
    	reviewImg.setOrderNo(orderNo);
    	reviewImg.setReviewOriFilename("reviewOriFilename");
    	reviewImg.setReviewSaveFilename("reviewSaveFilename");
    	reviewImg.setReviewFiletype("reviewFiletype");
    	
    	int imgrow = reviewdao.updateReviewImg(reviewImg);
    	if( row == 1 ){
    		System.out.println("이미지 수정 완료");
    	}else{
    		System.out.println("이미지 수정 실패");
    	}
    }
	
	response.sendRedirect(request.getContextPath() + "/review/reviewOne.jsp?orderNo="+orderNo+"&productNo="+productNo);}

%>