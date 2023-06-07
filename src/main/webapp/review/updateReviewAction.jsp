<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%

	// enctype form -- null값 호출 해결해야함
	
	request.setCharacterEncoding("utf-8");

	String dir = request.getServletContext().getRealPath("/review/reviewImg");
	System.out.println(dir+"<----");
	int max = 10 * 1024 * 1024; // 10MB
	
	//DefaultFileRenamePolicy 중복제거 메서드
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	
	int productNo = Integer.parseInt(mRequest.getParameter("productNo"));
	int orderNo = Integer.parseInt(mRequest.getParameter("orderNo"));
	System.out.println(orderNo + "<----update review Action orderNo");
	System.out.println(productNo + "<----update review Action productNo");
	
	//문의 사항 요청값 유효성 검사(+수정시에도 공백X)
	if(mRequest.getParameter("orderNo") == null
	||mRequest.getParameter("orderNo").equals("")
	||mRequest.getParameter("productNo") == null
	||mRequest.getParameter("productNo").equals("")
	||mRequest.getParameter("reviewTitle") == null
	||mRequest.getParameter("reviewTitle").equals("")
	||mRequest.getParameter("reviewContent") == null
	||mRequest.getParameter("reviewContent").equals("")){
		/*response.sendRedirect(mRequest.getContextPath()+"/product/productOne.jsp");*/
		return;
	}
	
	//String Id = (String)session.getAttribute("Id");
	String reviewTitle = mRequest.getParameter("reviewTitle");
	String reviewImg = mRequest.getParameter("reviewImg");
	String reviewContent = mRequest.getParameter("reviewContent");
	
	System.out.println(reviewTitle + "<---update r.a title");
	System.out.println(reviewImg + "<---update r.a reviewImg");
	System.out.println(reviewContent + "<---update r.a content");

	ReviewDao review = new ReviewDao(); // dao 호출
	Review reviewText = new Review(); // vo
	
	// text 요청 값 저장
	Review reviewtext = new Review();
	reviewtext.getOrderNo();
	reviewtext.getProductNo();
	reviewtext.getReviewTitle();
	reviewtext.getReviewContent();
	
	// 이미지 요청 값 저장
	ReviewImg reviewupImg = new ReviewImg();
	reviewupImg.getReviewSaveFilename();
		
	// 수정 메서드 호출
	int row;
	
%>