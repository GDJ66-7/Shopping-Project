package dao;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class MainDao {
	
	// 상품리스트 조회
	public ArrayList<HashMap<String, Object>> productList(int beginRow, int rowPerPage) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		/* 상품 리스트 조회
		  
		 */
		return null;
	}
}
