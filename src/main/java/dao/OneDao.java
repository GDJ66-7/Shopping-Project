package dao;
import java.sql.*;
import java.util.HashMap;
import util.DBUtil;

public class OneDao { 
	
	// 상품 상세페이지 - productOne(번호,카테고리,상품이름,가격,상태,설명) + img(savefilename/filetype)
	public HashMap<String, Object> selectProductOne(int productNo) throws Exception {
		
		HashMap<String, Object> p = new HashMap<>(); //hashMap선언
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT p.product_no productNo, p.category_name categoryName, p.product_name productName, p.product_price productPrice, p.product_status productStatus, p.product_stock productStock, p.product_info productInfo, p.updatedate updatedate, img.product_save_filename productSaveFilename, img.product_filetype productFiletype"
					+ " FROM product p INNER JOIN product_img img"
					+ " ON p.product_no = img.product_no"
					+ " WHERE p.product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // 보여줄 정보가 하나니까 if문으로 수정
			p.put("productNo", rs.getInt("productNo"));
			p.put("categoryName", rs.getString("categoryName"));
			p.put("productName", rs.getString("productName"));
			p.put("productPrice", rs.getInt("productPrice"));
			p.put("productStatus", rs.getString("productStatus"));
			p.put("productStock", rs.getInt("productStock"));
			p.put("productInfo", rs.getString("productInfo"));
			p.put("productSaveFilename", rs.getString("productSaveFilename"));
			p.put("productFiletype", rs.getString("productFiletype"));
			p.put("updatedate", rs.getString("updatedate"));
			System.out.println(p);
		}
		return p; //값 반환 - 결과값 저장
	}
}