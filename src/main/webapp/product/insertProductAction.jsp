<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.nio.file.Path"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="vo.*" %>
<%@ page import="java.io.*" %>

<%
	// 유효성검사
	if(request.getParameter("categoryName") == null
		|| request.getParameter("productName") == null 
		|| request.getParameter("productPrice") == null
		|| request.getParameter("productStatus") == null 
		|| request.getParameter("productStock") == null 
		|| request.getParameter("productInfo") == null 
		|| request.getParameter("productFile") == null 
		|| request.getParameter("categoryName").equals("")
		|| request.getParameter("productName").equals("")
		|| request.getParameter("productPrice").equals("")
		|| request.getParameter("productStatus").equals("")
		|| request.getParameter("productStock").equals("")
		|| request.getParameter("productInfo").equals("")
		|| request.getParameter("productFile").equals("")){
		
		response.sendRedirect(request.getContextPath()+"/product/insertProduct.jsp");
		return;
	}

	//프로젝트안에 product폴더안에 productImg폴더의 위치를 반환
	String dir = request.getServletContext().getRealPath("/product/prodcutImg");
	int max = 1024 * 1024 * 100; // 파일최대사이즈 100Mbyte 
	
	// new MultipartRequest(원본request, 업로드폴더, 최대파일사이즈byte, 인코딩, 중복이름정책)
	MultipartRequest mreq = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	
	// 업로드 파일의 type이 jsp파일이 아니면 return
		if(mreq.getContentType("productFile").equals("application/jsp") == false) {
			// 이미 저장된 파일을 삭제
			System.out.println("jsp파일이 아닙니다");
			String saveFilename = mreq.getOriginalFileName("productFile");
			File f = new File(dir + "\\" + saveFilename); // new File 경로(dir) + "/" + 저장파일이름(?)
			
			// f.객체 안에 dir + "\\" + saveFilename 이 없다면 삭제
			if(f.exists()) {
				f.delete();
				System.out.println(dir + "\\" + saveFilename + "파일삭제완료");
			}
			response.sendRedirect(request.getContextPath() +"/product/insertProduct.jsp");
			return;
		}
	
	// 요청값 변수 저장
	String categoryName = mreq.getParameter("categoryName");
	String productName = mreq.getParameter("productName");
	int productPrice = Integer.parseInt(mreq.getParameter("productPrice"));
	String productStatus = mreq.getParameter("productStatus");
	int productStock = Integer.parseInt(mreq.getParameter("productStock"));
	String productInfo = mreq.getParameter("productInfo");
	String productFile = mreq.getParameter("productFile");
	
	// 파일 정보 저장
	String proType = mreq.getContentType("productFile");
	String proOriginFilename = mreq.getParameter("productFile");
	String proSaveFilename = mreq.getFilesystemName("productFile");
	
	System.out.println(productFile + "<-- insertProductAction productFile");
	System.out.println(proSaveFilename + "<-- insertProductAction proSaveFilename");
	
	// 상품 및 상품 이미지 객체 생성
	ProductDao pDao = new ProductDao();
	
	Product insertP = new Product();
	insertP.setCategoryName(categoryName);
	insertP.setProductName(productName);
	insertP.setProductPrice(productPrice);
	insertP.setProductStatus(productStatus);
	insertP.setProductStock(productStock);
	insertP.setProductInfo(productInfo);
	
	ProductImg insertImgP = new ProductImg();
	insertImgP.setProductOriFilename(proOriginFilename);
	insertImgP.setProductSaveFilename(proSaveFilename);
	insertImgP.setProductFiletype(proType);
	
	int row = pDao.insertProduct(insertP, insertImgP);
	System.out.println(row + "<-- insertProductAction row");
	
	if(row > 0) {
		System.out.println("상품추가성공");
	} else {
		System.out.println("상품추가실패");
	}
%>
