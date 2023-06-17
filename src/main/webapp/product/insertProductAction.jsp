 <%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.nio.file.Path"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="vo.*" %>
<%@ page import="java.io.*" %>

<%
	request.setCharacterEncoding("utf-8");
	// 요청값 디버깅
	System.out.println(request.getParameter("categoryName") + "categoryName");
	System.out.println(request.getParameter("productName") + "productName");
	System.out.println(request.getParameter("productPrice") + "productPrice");
	System.out.println(request.getParameter("productStatus") + "productStatus");
	System.out.println(request.getParameter("productStock") + "productStock");
	System.out.println(request.getParameter("productInfo") + "productInfo");

	
	/*
	// 유효성검사
	if(request.getParameter("categoryName") == null
		|| request.getParameter("productName") == null 
		|| request.getParameter("productPrice") == null
		|| request.getParameter("productStatus") == null 
		|| request.getParameter("productStock") == null 
		|| request.getParameter("productInfo") == null 
		|| request.getParameter("categoryName").equals("")
		|| request.getParameter("productName").equals("")
		|| request.getParameter("productPrice").equals("")
		|| request.getParameter("productStatus").equals("")
		|| request.getParameter("productStock").equals("")
		|| request.getParameter("productInfo").equals("")){
		
		System.out.println("null또는 공백있음");
		response.sendRedirect(request.getContextPath()+"/product/insertProduct.jsp");
		return;
	}
	*/
		System.out.println("null또는 공백없음");
		
	//프로젝트안에 product폴더안에 productImg폴더의 위치를 반환
	String dir = request.getServletContext().getRealPath("/product/productImg");
	System.out.println(dir + " dir경로 확인");
	int max = 1024 * 1024 * 100; // 파일최대사이즈 100Mbyte 
	
	// new MultipartRequest(원본request, 업로드폴더, 최대파일사이즈byte, 인코딩, 중복이름정책)
	MultipartRequest mreq = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	
	
	// 업로드 파일의 type이 jpep파일이 아니면 return
		if(mreq.getContentType("productFile").equals("image/jpeg") == false) {
			// 이미 저장된 파일을 삭제
			System.out.println("jpeg파일이 아닙니다");
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
	
    // 요청값 유효성 검사 
    // multipart/form-data로값을 보내면 getParameter로는 값이 넘어오지 않아 요청값을 저장후 검사한다.
    if (categoryName == null || categoryName.equals("")
            || productName == null || productName.equals("")
            || productStatus == null || productStatus.equals("")
            || productInfo == null || productInfo.equals("")) {

        System.out.println("null 또는 공백이 있음");
        response.sendRedirect(request.getContextPath() + "/product/insertProduct.jsp");
        return;
    }

	// 파일 정보 저장
	String proType = mreq.getContentType("productFile");
	String proOriginFilename = mreq.getOriginalFileName("productFile");
	String proSaveFilename = mreq.getFilesystemName("productFile");
	
	// 상품 디버깅코드
	System.out.println(categoryName + "<-- insertProductAction categoryName");
	System.out.println(productName + "<-- insertProductAction productName");
	System.out.println(productPrice + "<-- insertProductAction productPrice");
	System.out.println(productStatus + "<-- insertProductAction productStatus");
	System.out.println(productStock + "<-- insertProductAction productStock");
	System.out.println(productInfo + "<-- insertProductAction productInfo");
	
	// 사진파일 디버깅코드
	System.out.println(proType + "<-- insertProductAction proType");
	System.out.println(proOriginFilename + "<-- insertProductAction proOriginFilename");
	System.out.println(proSaveFilename + "<-- insertProductAction proSaveFilename");
	
	// 메서드 객체
	ProductDao pDao = new ProductDao();
	// 상품 객체 
	Product insertP = new Product();
	insertP.setCategoryName(categoryName);
	insertP.setProductName(productName);
	insertP.setProductPrice(productPrice);
	insertP.setProductStatus(productStatus);
	insertP.setProductStock(productStock);
	insertP.setProductInfo(productInfo);
	
	
	System.out.println(insertP.getCategoryName() + "<-- insertProductAction insertP.getCategoryName()");
	if(insertP.getCategoryName() == null) {
		response.sendRedirect(request.getContextPath() +"/main/empMain.jsp");
		return;
	}
	
	
	// 상품 이미지 객체
	ProductImg insertImgP = new ProductImg();
	insertImgP.setProductOriFilename(proOriginFilename);
	insertImgP.setProductSaveFilename(proSaveFilename);
	insertImgP.setProductFiletype(proType);
	
	// 메소드 호출
	pDao.insertProduct(insertP, insertImgP);
	
	System.out.println("<-- insertProductAction 상품추가완료");
	response.sendRedirect(request.getContextPath() +"/main/empMain.jsp");
%>
