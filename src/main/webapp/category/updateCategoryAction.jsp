<%@page import="vo.Category"%>
<%@page import="dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("categoryName") == null
		|| request.getParameter("categoryNo") == null) {
		response.sendRedirect(request.getContextPath() + "/category/updateCategory.jsp");
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
	
	if(row > 0 ) {
		System.out.println("카테고리 변경 성공");
		response.sendRedirect(request.getContextPath() + "/main/empMain.jsp");
	} else {
		System.out.println("카테고리 변경 실패");
		response.sendRedirect(request.getContextPath() + "/category/updateCategory.jsp");
	}
%>
