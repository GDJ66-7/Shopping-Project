package dao;
import java.sql.*;
import java.util.HashMap;
import util.DBUtil;

public class OneDao { 
	
	// 상품 상세페이지 - productOne(번호,카테고리,이름,가격,상태,설명) + img - INNER JOIN
	public HashMap<String, Object> selectProductOne(int productNo) throws Exception {
		
		HashMap<String, Object> one = null;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT p.product_no productNo, p.category_name categoryName, p.product_name productName, p.product_price productPrice, p.product_status productStatus, p.product_stock productStock, p.product_info productInfo, p.updatedate updatedate, img.product_save_filename productSavefilename"
					+ " FROM product p INNER JOIN product_img img"
					+ " ON p.product_no = img.product_no"
					+ " WHERE p.product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) { // 상품 정보가 유효하면 출력
			HashMap<String, Object> p = new HashMap<>();
			p.put("productNo", rs.getInt("productNo"));
			p.put("categoryName", rs.getString("categoryName"));
			p.put("productName", rs.getString("productName"));
			p.put("productPrice", rs.getInt("productPrice"));
			p.put("productStatus", rs.getString("productStatus"));
			p.put("productStock", rs.getInt("productStock"));
			p.put("productInfo", rs.getString("productInfo"));
			p.put("productSavefilename", rs.getString("productSavefilename"));
			p.put("updatedate", rs.getString("updatedate"));
		}
			return one;
	}
}