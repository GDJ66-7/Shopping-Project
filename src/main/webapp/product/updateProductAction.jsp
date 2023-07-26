<%@page import="vo.ProductImg"%>
<%@page import="java.io.File"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//프로젝트아에 upload폴더의 위치를 반환
	String dir = request.getServletContext().getRealPath("/product/productImg");
	int max = 1024 * 1024 * 100; // 파일최대사이즈 100Mbyte 
	
	// 원본 request를 객체를 cos api로 랩핑
	// new MultipartRequest(원본request, 업로드폴더, 최대파일사이즈byte, 인코딩, 중복이름정책)
	MultipartRequest mreq = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());

	// 요청값 변수지정
	int productNo = Integer.parseInt(mreq.getParameter("productNo"));
	int productImgNo = Integer.parseInt(mreq.getParameter("productImgNo"));
	String categoryName = mreq.getParameter("categoryName");
	String productName = mreq.getParameter("productName");
	int productPrice = Integer.parseInt(mreq.getParameter("productPrice"));
	String productStatus = mreq.getParameter("productStatus");
	int productStock = Integer.parseInt(mreq.getParameter("productStock"));
	String productInfo = mreq.getParameter("productInfo");
	
	System.out.println(productNo + "<-- updateProductAction productNo");
	System.out.println(productImgNo + "<-- updateProductAction productImgNo");
	System.out.println(categoryName + "<-- updateProductAction categoryName");
	System.out.println(productName + "<-- updateProductAction productName");
	System.out.println(productPrice + "<-- updateProductAction productPrice");
	System.out.println(productStatus + "<-- updateProductAction productStatus");
	System.out.println(productStock + "<-- updateProductAction productStock");
	System.out.println(productInfo + "<-- updateProductAction productInfo");
	
	
	// productDao사용하기 위해 객체생성
	ProductDao pDao = new ProductDao();
	
	Product pUpdate = new Product();
	
	// 수정할 요청값 product vo저장
	pUpdate.setCategoryName(categoryName);
	pUpdate.setProductName(productName);
	pUpdate.setProductPrice(productPrice);
	pUpdate.setProductStatus(productStatus);
	pUpdate.setProductStock(productStock);
	pUpdate.setProductInfo(productInfo);
	pUpdate.setProductNo(productNo);
	
	int Row = pDao.updateProduct(pUpdate);
	System.out.println(Row + " < --Row ");
	if(Row > 0) {
		System.out.println("product수정완료 ");
	} else {
		System.out.println("product수정실패");
		return;
	}

	if(mreq.getOriginalFileName("productFile") != null){
		System.out.println("수정할파일있음");
		// 수정할 파일이 있으면 jpeg파일인지 유효성 검사 jpeg파일이 아니면 삭제
		if(mreq.getContentType("productFile").equals("image/jpeg") == false) {
			System.out.println("jpeg파일이 아닙니다");
			String saveFilename = mreq.getOriginalFileName("productFile");
			
			File f = new File(dir + "\\" + saveFilename); // new File 경로(dir) + "/" + 저장파일이름(?)
			// f.객체 안에 dir + "\\" + saveFilename 이 없다면 삭제
			if(f.exists()) {
				f.delete();
				System.out.println(dir + "\\" + saveFilename + "파일삭제완료");
			}
		} else {
			// jpeg파일이면 이전파일은 삭제후 db수정
			String type = mreq.getContentType("productFile");
			String originFilename = mreq.getOriginalFileName("productFile");
			String saveFilename = mreq.getFilesystemName("productFile");
			
			System.out.println(type + "<-- updateProductAction type");
			System.out.println(originFilename + "<-- updateProductAction originFilename");
			System.out.println(saveFilename + "<-- updateProductAction saveFilename");
			
			// 
			ProductImg productImg = new ProductImg();
			
			productImg.setProductImgNo(productImgNo);
			productImg.setProductOriFilename(originFilename);
			productImg.setProductSaveFilename(saveFilename);
			
			HttpServletRequest req = (HttpServletRequest) pageContext.getRequest();
			
			int proImgRow = pDao.updateProductImg(req, productImg);
			
			String msg = "";
			if(proImgRow > 0) {
				System.out.println("상품 수정완료");
				response.sendRedirect(request.getContextPath()+"/product/empProductList.jsp?updateProductMsg="+msg);
				return;
			} else {
				System.out.println("상품 수정실패");
				response.sendRedirect(request.getContextPath()+"/product/empProductList.jsp?updateProductMsg2="+msg);
			}
		}
	}
	
	
%>
