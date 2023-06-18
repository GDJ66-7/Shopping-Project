<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="vo.Category"%>
<%@page import="dao.CategoryDao"%>
<%
	request.setCharacterEncoding("utf-8");
	
	// 요청값 검사
	
	if(request.getParameter("categoryName") == null
		||request.getParameter("categoryName").equals("")) {
		response.sendRedirect(request.getContextPath()+"/category/insertCategory.jsp");
		return;
	}	
	
	// 요청값 변수
	String categoryName = request.getParameter("categoryName");
	System.out.println(categoryName + "<--- insertCategoryAction categoryName");
	
	// dao사용위한 객체
	CategoryDao cDao = new CategoryDao();
	
	// 변수값 담을 categoryVo
	Category category = new Category();
	// 요청값 vo에 입력
	category.setCategoryName(categoryName);
	int row = cDao.insertCategory(category);
	
	String msg = "";
	if(row > 0) {
		System.out.println("카테고리 추가성공");
		response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp?insertCategoryMsg="+msg);
		return;
	}
		System.out.println("카테고리 추가실패");
		response.sendRedirect(request.getContextPath()+"/category/insertCategory.jsp?insertCategoryMsg2="+msg);
		
%>
