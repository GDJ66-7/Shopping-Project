package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
	
	// 1) 카테고리 추가 메서드
	public int insertCategory(Category category) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		// 카테고리 중복 체크 쿼리
	    String checkCategorySql = "SELECT COUNT(*) FROM category WHERE category_name = ?";
	    PreparedStatement checkCategoryStmt = conn.prepareStatement(checkCategorySql);
	    checkCategoryStmt.setString(1, category.getCategoryName());
	    ResultSet checkCategoryRs = checkCategoryStmt.executeQuery();

	    int cnt = 0;
	    if (checkCategoryRs.next()) {
	    	cnt = checkCategoryRs.getInt(1);
	    }
	    if (cnt > 0) {
	    	System.out.println("이미 같은 이름의 카테고리가 존재합니다.");
	    	return row;
	    }
	    
		
		/* category추가 쿼리
		 	INSERT INTO category(category_name, createdate, updatedate) VALUES(?,now(),now())
		 */
		String sql="INSERT INTO category(category_name, createdate, updatedate) VALUES(?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	/*
	// 2) 카테고리 삭제 메서드
	// 쿼리 where = category_name이므로 String타입으로 매개변수 입력받아 삭제
	public int deleteCategory(String categoryName) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		category 삭제 쿼리
		 	DELETE FROM category where category_name = ?;
		 
		String sql="DELETE FROM category where category_name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		row = stmt.executeUpdate();
		return row;
	}
	*/
	
	// 3)  카테고리 이름 조회
	// 상품(product)추가시 category_name이 왜래키 설정되어있어 새로 값 추가가 안되어
	// 기존 카테고리에서 추가시켜야 하므로 product추가창에서 보여주기 위함
	public ArrayList<HashMap<String, Object>> categoryNameList() throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		/*
		  SELECT category_name FROM category
		 */
		String sql="SELECT category_no, category_name FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("categoryNo", rs.getInt("category_no"));
			map.put("categoryName", rs.getString("category_name"));
			categoryList.add(map);
		}
		
		System.out.println(stmt + "<-- CategoryDao  categoryNameList stmt");
		return categoryList;
	}
	
	

	// 4) 카테고리 수정
	public int updateCategory(Category category) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		// 카테고리 중복 체크 쿼리
	    String checkCategorySql = "SELECT COUNT(*) FROM category WHERE category_name = ?";
	    PreparedStatement checkCategoryStmt = conn.prepareStatement(checkCategorySql);
	    checkCategoryStmt.setString(1, category.getCategoryName());
	    ResultSet checkCategoryRs = checkCategoryStmt.executeQuery();

	    int cnt = 0;
	    if (checkCategoryRs.next()) {
	    	cnt = checkCategoryRs.getInt(1);
	    }
	    if (cnt > 0) {
	    	System.out.println("이미 같은 이름의 카테고리가 존재합니다.");
	    	return row;
	    }
		
		/*
		 	UPDATE category SET category_name = ? WHERE category_name = ?
		 */
		String sql="UPDATE category SET category_name = ? WHERE category_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setInt(2, category.getCategoryNo());
		row = stmt.executeUpdate();
		System.out.println(stmt + "<--- category updateStmt");
		return row;
	}
	
	
}
