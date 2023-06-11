<%@page import="java.io.File"%>
<%@ page import = "com.oreilly.servlet.*" %><!-- cos.jar... -->
<%@ page import = "com.oreilly.servlet.multipart.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// sendRedirect 경로 수정 필요
	request.setCharacterEncoding("utf-8");

	// 로그인 세션 추가 test
	String id = "customer2";
	System.out.println(id);
	
	// 객체 생성 (text+img = DAO 하나)
	ReviewDao reviewdao = new ReviewDao();
	
	// 이미지 파일 추가 처리 ---------------------------------------------------------------------------------
	String dir = request.getServletContext().getRealPath("/review/reviewImg"); // 프로젝트 내 reviewImg 파일 호출
	System.out.println(dir+"<---dir"); // 실제 경로 <---dir 
	
	int max = 10 * 1024 * 1024; // 업로드 파일 크기 제한 : 10MB
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	
	// 1) 요청값 저장
	// review 테이블에 저장 - text값
	String reviewTitle = mRequest.getParameter("reviewTitle");
	String reviewContent = mRequest.getParameter("reviewContent");
	int productNo = Integer.parseInt(mRequest.getParameter("productNo"));
	int orderNo = 2;
	
	System.out.println(mRequest.getParameter("reviewTitle")+ "<---insert Review reviewTitle");
	System.out.println(mRequest.getParameter("reviewContent")+ "<---insert Review reviewContent");
	System.out.println(orderNo+ "<---insert Review orderNo");
	
	// 객체 저장 (text) - vo
	Review reviewtext = new Review();
	reviewtext.setOrderNo(orderNo);
	reviewtext.setProductNo(productNo);
	reviewtext.setId(id);
	reviewtext.setReviewTitle(reviewTitle);
	reviewtext.setReviewContent(reviewContent);
	
	int row = reviewdao.insertReview(reviewtext); //text

	// --- 이미지
	// 파일은 jpg만 업로드 가능
	if(mRequest.getContentType("reviewImg").equals("image/jpeg") == false) { // 타입이 유효하지 않은 저장된 파일 삭제
		System.out.println("jpg파일이 아닙니다");
		String saveFilename = mRequest.getFilesystemName("reviewImg");
		File f = new File(dir+"/"+saveFilename);
	
		if(f.exists()){ // jpg가 아닌게 존재한다면 delete()
			f.delete();
			System.out.println(saveFilename +"파일삭제");
		}
		response.sendRedirect(request.getContextPath()+"/review/insertReview.jsp"); //jsp?orderNo=..(추가)
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
	reviewImg.setOrderNo(orderNo);
	reviewImg.setReviewOriFilename(originFilename);
	reviewImg.setReviewSaveFilename(saveFilename);
	reviewImg.setReviewFiletype(filetype);
	
	int imgrow = reviewdao.insertReviewImg(reviewImg);
	
	response.sendRedirect(request.getContextPath() + "/review/reviewOne.jsp");

%>