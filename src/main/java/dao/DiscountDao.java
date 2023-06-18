package dao;

import java.sql.*;
import java.util.*;
import util.*;
import vo.Discount;

public class DiscountDao {
	
	// 1. 상품 할인 리스트 조회
	public ArrayList<HashMap<String, Object>> discountList(String productName, String categoryName, int beginRow, int rowPerPage) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		/*
		 	SELECT d.discount_no 할인번호, d.product_no 상품번호, p.product_name 상품이름, p.product_price 상품가격, p.product_price*(1- d.discount_rate) 상품할인가, d.discount_start 시작날짜, d.discount_end 종료날짜, d.discount_rate 할인율, d.createdate 생성날짜,  d.updatedate 수정날짜 
				FROM discount d INNER JOIN product p ON d.product_no = p.product_no
		 */
		String sql = "SELECT d.discount_no 할인번호, d.product_no 상품번호, p.product_name 상품이름, p.product_price 상품가격, p.product_price*(1- d.discount_rate) 상품할인가, d.discount_start 시작날짜, d.discount_end 종료날짜, d.discount_rate 할인율, d.createdate 생성날짜,  d.updatedate 수정날짜 \r\n"
				+ "				FROM discount d INNER JOIN product p\r\n"
				+ "				ON d.product_no = p.product_no";
		// 검색어만 있을때
		if(!productName.equals("")) {
			sql += " WHERE p.product_name LIKE '%" + productName + "%'";
		} 
		// 카테고리만 있을때
		else if(!categoryName.equals("")) {
			sql += " AND p.category_name = '" + categoryName + "'";
		}
		// 검색어 카테고리 둘다 있을때
		else if (!productName.equals("") && !categoryName.equals("")) {
	        sql += " AND p.product_name LIKE '%" + productName + "%' AND p.category_name = '" + categoryName + "'";
	    }
			
		sql += " LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();	
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>(); 
		while(rs.next()) {
			HashMap<String, Object> d = new HashMap<>();
			d.put("discountNo", rs.getInt("할인번호"));
			d.put("productNo", rs.getInt("상품번호"));
			d.put("productName",rs.getString("상품이름"));
			d.put("productPrice",rs.getInt("상품가격"));
			d.put("productDiscountPrice",rs.getInt("상품할인가"));
			d.put("discountStart",rs.getString("시작날짜"));
			d.put("discountEnd",rs.getString("종료날짜"));
			d.put("discountRate",rs.getDouble("할인율"));
			d.put("createdate",rs.getString("생성날짜"));		
			d.put("updatedate",rs.getString("수정날짜"));
			list.add(d);
		}
		
		return list;
	}
	
	// 1-1) 상품할인리스트 전체행 개수
	public int productListCnt1(String productName, String categoryName) throws Exception {
		int totalRow = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		/*
		  	SELECT COUNT(*) 
			FROM discount d INNER JOIN product p ON d.product_no = p.product_no 
		*/
		
		String sql = "SELECT COUNT(*) FROM discount d INNER JOIN product p ON d.product_no = p.product_no";
		
		// 검색어 있을대
		if(!productName.equals("")) {
			sql += " WHERE p.product_name LIKE '%" + productName + "%'";
		} 
		// 카테고리 있을때
		else if(!categoryName.equals("")) {
			sql += " AND p.category_name = '" + categoryName + "'";
		} 
		// 검색어 카테고리 둘다 있을때
		else if (!productName.equals("") && !categoryName.equals("")) {
	        sql += " AND p.product_name LIKE '%" + productName + "%' AND p.category_name = '" + categoryName + "'";
	    }
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		rs = stmt.executeQuery();
		if(rs.next()) {
			totalRow = rs.getInt(1);
		}
		
		System.out.println(totalRow + "<-- DiscountDao 상품할인리스트 전체 행 개수 totalRow");
			return totalRow;
			
	}
	
	// 2)할인 상품 추가
	public int insertDiscount(Discount discount) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		/*
		  	INSERT INTO discount(product_no, discount_start, discount_end, discount_rate, createdate, updatedate) 
			VALUES(?, ?, ?, ?, NOW(), NOW());
		 */
		String sql ="INSERT INTO discount(product_no, discount_start, discount_end, discount_rate, createdate, updatedate) \r\n"
				+ "			VALUES(?, ?, ?, ?, NOW(), NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, discount.getProductNo());
		stmt.setString(2, discount.getDiscountStart());
		stmt.setString(3, discount.getDiscountEnd());
		stmt.setDouble(4, discount.getDiscountRate());
		
		row = stmt.executeUpdate();
		
		System.out.println(stmt + "<-- DiscountDao insertDiscount stmt");
		return row;
	}
	
	// 3)할인 상품 수정
	public int updateDiscount(Discount discount) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		/*
		 	UPDATE discout SET discount_start =?, discount_end=? , discount_rate=?, updatedate = NOW() 
			WHERE discount_no = ?;
		*/
		String sql="UPDATE discount SET discount_start =?, discount_end=? , discount_rate=?, updatedate = NOW() \r\n"
				+ "WHERE discount_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, discount.getDiscountStart());
		stmt.setString(2, discount.getDiscountEnd());
		stmt.setDouble(3, discount.getDiscountRate());
		stmt.setInt(4, discount.getDiscountNo());
		
		row = stmt.executeUpdate();
		System.out.println(stmt + "<-- DiscountDao updateDiscount stmt");
		
		return row;
	}
	
	// 4)할인 상품 개별 삭제
	public int deleteDiscount(int discountNo) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		/*
		 	DELETE FROM discount WHERE discount_no = ?
		*/
		String sql="DELETE FROM discount WHERE discount_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, discountNo);
		
		row = stmt.executeUpdate();
		System.out.println(stmt + "<-- DiscountDao deleteDiscount stmt");
		
		return row;
	}
	
	public int allDeleteDiscount() throws Exception {
		int allRow = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		/* discount_end가 지난 데이터는 전부 삭제.
		  	DELETE
			FROM discount
			WHERE SYSDATE() > discount_end 
		 */
		
		String sql = "DELETE\r\n"
					+ "	FROM discount\r\n"
					+ "	WHERE SYSDATE() > discount_end";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		allRow = stmt.executeUpdate();
		System.out.println(stmt + "<-- DiscountDao allDeleteDiscount stmt");
		
		return allRow;
	}
	
	
		

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
