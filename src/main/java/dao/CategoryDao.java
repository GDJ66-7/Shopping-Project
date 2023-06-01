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
			
		/* category추가 쿼리
		 	INSERT INTO category(category_name, createdate, updatedate) VALUES(?,now(),now())
		 */
		String sql="INSERT INTO category(category_name, createdate, updatedate) VALUES(?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 2) 카테고리 삭제 메서드
	// 쿼리 where = category_name이므로 String타입으로 매개변수 입력받아 삭제
	public int deleteCategory(String categoryName) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		/* category 삭제 쿼리
		 	DELETE FROM category where category_name = ?;
		 */
		String sql="DELETE FROM category where category_name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 3)  카테고리 이름 조회
	// 상품(product)추가시 category_name이 왜래키 설정되어있어 새로 값 추가가 안되어
	// 기존 카테고리에서 추가시켜야 하므로 product추가창에서 보여주기 위함
	public ArrayList<HashMap<String, Object>> categoryNameList() throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		/*
		  SELECT category_name FROM category
		 */
		String sql="SELECT category_name FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("categoryName", rs.getString("category_name"));
			categoryList.add(map);
		}
		
		System.out.println(stmt + "<-- CategoryDao  categoryNameList stmt");
		return categoryList;
	}
}
