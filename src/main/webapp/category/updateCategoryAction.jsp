<%@page import="vo.Category"%>
<%@page import="dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	System.out.println(request.getParameter("categoryName") + "<-- updateCategoryAction 요청값 유효성 categoryName");
	System.out.println(request.getParameter("categoryNo") + "<-- updateCategoryAction 요청값 유효성 categoryNo");
	
	if(request.getParameter("categoryName") == null
		|| request.getParameter("categoryName").equals("")
		|| request.getParameter("categoryNo") == null) {
		response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp");
		return;
	}

	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryName = request.getParameter("categoryName");
	
	System.out.println(categoryNo + "<-- updateCategoryAction categoryNo");
	System.out.println(categoryName + "<-- updateCategoryAction categoryName");
	
	CategoryDao cDao = new CategoryDao();
	
	Category c = new Category();
	c.setCategoryName(categoryName);
	c.setCategoryNo(categoryNo);
	
	int row = cDao.updateCategory(c);
	
	String msg = "";
	if(row > 0 ) {
		System.out.println("카테고리 변경 성공");
		response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp?updateCategoryMsg="+msg);
	} else {
		System.out.println("카테고리 변경 실패");
		response.sendRedirect(request.getContextPath() + "/category/categoryList.jsp?updateCategoryMsg2="+msg);
	}
%>
