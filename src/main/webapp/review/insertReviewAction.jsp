<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.nio.file.Path"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="vo.*" %>
<%@ page import="java.io.*" %>
<%@ page import="dao.*" %>
<%
	// sendRedirect 경로 수정 필요

	// 로그인 세션 추가 
	if(session.getAttribute("loginCstmId") == null) {
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp");
		return;
	}
	String id = (String)session.getAttribute("loginCstmId");
	System.out.println(id+"<----insert Review id");
	
	// 객체 생성 (text+img = DAO 하나)
	ReviewDao reviewdao = new ReviewDao();
	
	// 이미지 파일 추가 처리 ---------------------------------------------------------------------------------
	String dir = request.getServletContext().getRealPath("/review/reviewImg"); // 프로젝트 내 reviewImg 파일 호출
	System.out.println(dir+"<---dir"); // 실제 경로 <---dir 
	
	int max = 100 * 1024 * 1024; // 업로드 파일 크기 제한 
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	
	String msg = "";
	
	// 1) 요청값 저장
	// review 테이블에 저장 - text값(input으로 받아온 것 다 저장하기)
	String reviewTitle = mRequest.getParameter("reviewTitle");
	String reviewContent = mRequest.getParameter("reviewContent");
	int productNo = Integer.parseInt(mRequest.getParameter("productNo"));
	int historyNo = Integer.parseInt(mRequest.getParameter("historyNo"));
	
	System.out.println(mRequest.getParameter("reviewTitle")+ "<---insert Review reviewTitle");
	System.out.println(mRequest.getParameter("reviewContent")+ "<---insert Review reviewContent");
	System.out.println(historyNo+ "<---insert Review historyNo");
	
	// 객체 저장 (text) - vo
	Review reviewtext = new Review();
	reviewtext.setHistoryNo(historyNo);
	reviewtext.setProductNo(productNo);
	reviewtext.setId(id);
	reviewtext.setReviewTitle(reviewTitle);
	reviewtext.setReviewContent(reviewContent);

	// --- 이미지
	// 파일은 jpg만 업로드 가능
	if(mRequest.getContentType("reviewImg").equals("image/jpeg") == false) { // 타입이 유효하지 않은 저장된 파일 삭제
		System.out.println("jpg파일이 아닙니다");
		String saveFilename = mRequest.getFilesystemName("reviewImg");
			System.out.println(saveFilename+"<----savefilename");
			File f = new File(dir+"/"+saveFilename);
	
		if(f.exists()){ // jpg가 아닌게 존재한다면 delete()
			f.delete();
			System.out.println(saveFilename +"파일삭제");
		}
		msg =URLEncoder.encode("JPG파일만 업로드 가능합니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/review/insertReview.jsp?historyNo="+historyNo+"&productNo="+productNo+"&msg="+msg); //jsp?historyNo=..(추가)
		return;
			}
	
 	// 2) input type = "file" 값(파일 메타 정보)반환 API(원본 파일 이름, 저장된 파일 이름, 컨텐츠 타입) 받아옴
	String filetype = mRequest.getContentType("reviewImg"); // Img 받아온다. api 받는 타입 다름
	String originFilename = mRequest.getOriginalFileName("reviewImg"); // 매개변수로 받은 파라미터 값으로 업로드된 파일의 원본이름 리턴
	String saveFilename = mRequest.getFilesystemName("reviewImg"); // 파일의 고유이름 리턴
	
	System.out.println(filetype + "<--- insert review file type");
	System.out.println(originFilename + "<--- insert review originFilename");
	System.out.println(saveFilename + "<--- insert review saveFilename");
	
	// 이미지 객체 저장 - vo
	ReviewImg reviewImg = new ReviewImg();
	reviewImg.setHistoryNo(historyNo);
	reviewImg.setReviewOriFilename(originFilename);
	reviewImg.setReviewSaveFilename(saveFilename);
	reviewImg.setReviewFiletype(filetype);
	
	// text -- img파일이 유효할시에만 작성 가능 메서드 호출
	if (filetype != null || filetype.equals("image/jpeg")) {
	    int row = reviewdao.insertReview(reviewtext);
	    int imgrow = reviewdao.insertReviewImg(reviewImg);
	}
	
	// 입력 완료시 자신이 쓴 리뷰 상세보기 창으로 redirect
	response.sendRedirect(request.getContextPath() + "/review/reviewOne.jsp?productNo="+productNo+"&historyNo="+historyNo);

%>