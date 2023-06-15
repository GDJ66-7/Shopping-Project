package dao;

import java.sql.*;
import java.util.*;
import util.*;
import vo.Cart;
import vo.Product;

public class DiscountDao {
	
	// 1. 상품 할인 리스트 조회
	public ArrayList<HashMap<String, Object>> discountList() throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT discount_no 할인번호, "
				+ "product_no 상품번호, "
				+ "discount_start 시작날짜,"
				+ "discount_end 종료날짜, "
				+ "discount_rate 할인율, "
				+ "createdate 생성날짜, "
				+ "updatedate 수정날짜 "
				+ "FROM discount;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();	
		ArrayList<HashMap<String, Object>> list = new ArrayList<>(); 
		while(rs.next()) {
			HashMap<String, Object> d = new HashMap<>();
			d.put("할인번호", rs.getInt("할인번호"));
			d.put("상품번호", rs.getInt("상품번호"));
			d.put("시작날짜",rs.getString("시작날짜"));
			d.put("종료날짜",rs.getString("종료날짜"));
			d.put("할인율",rs.getDouble("할인율"));
			d.put("생성날짜",rs.getString("생성날짜"));		
			d.put("수정날짜",rs.getString("수정날짜"));
			list.add(d);
		}
		return list;
	}
	
	// 2. 상품 번호와 상품 이름 조회하기
	public ArrayList<Product> selectCart() throws Exception{
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT product_no, product_name "
				+ "FROM product ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Product> list = new ArrayList<>();
		while(rs.next()) {
			Product p = new Product();
			p.setProductNo(rs.getInt("product_no"));
			p.setProductName(rs.getString("product_name"));
			list.add(p);
		}
		return list;
	}
	
	
	
	// 할인 상품 추가
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
