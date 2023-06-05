package dao;

import java.io.File;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest; 
import util.DBUtil;
import vo.Product;
import vo.ProductImg;

public class ProductDao {
	
	// 1) 상품추가
	public void insertProduct(Product product, ProductImg productImg) throws Exception {
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			
		/* product 추가 쿼리
		 	INSERT INTO product(category_name, product_name, product_price, product_status, product_stock, product_info, createdate, updatedate) VALUES(?, ?, ?, ?, ?, ?, now(),now())
		
		 */
		String productSql="INSERT INTO product(category_name, product_name, product_price, product_status, product_stock, product_info, createdate, updatedate) VALUES(?, ?, ?, ?, ?, ?, now(),now())";
		PreparedStatement productStmt = conn.prepareStatement(productSql, PreparedStatement.RETURN_GENERATED_KEYS);
		productStmt.setString(1, product.getCategoryName());
		productStmt.setString(2, product.getProductName());
		productStmt.setInt(3, product.getProductPrice());
		productStmt.setString(4, product.getProductStatus());
		productStmt.setInt(5, product.getProductStock());
		productStmt.setString(6, product.getProductInfo());
		productStmt.executeUpdate();
		// 생성된 키값 자동으로받아옴
		ResultSet keyRs = productStmt.getGeneratedKeys();
		int productNo = 0;
		if(keyRs.next()) {
			productNo = keyRs.getInt(1);
		}
		
		System.out.println(productStmt + "<-- ProductDao productStmt");
		
		/* productImg 추가 쿼리
		  INSERT INTO product_img(product_no, product_ori_filename, product_save_filename, product_filetype, createdate, updatedate)
		  VALUES(?, ?, ?, ?, now(), now())
		 */
		String productImgSql="INSERT INTO product_img(product_no, product_ori_filename, product_save_filename, product_filetype, createdate, updatedate) VALUES(?, ?, ?, ?, now(), now())";
		PreparedStatement productImgStmt = conn.prepareStatement(productImgSql);
		productImgStmt.setInt(1, productNo);
		productImgStmt.setString(2, productImg.getProductOriFilename());
		productImgStmt.setString(3, productImg.getProductSaveFilename());
		productImgStmt.setString(4, productImg.getProductFiletype());
		productImgStmt.executeUpdate();
		
		System.out.println(productImgStmt + "<-- ProductDao productImgStmt");
		
	}
	
	// 2) 상품수정
	public int updateProduct(Product product) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		/* product 수정 쿼리
		 	UPDATE product SET category_name = ?, product_name = ?, product_price = ?, product_status = ?, product_stock = ?, product_info = ?, createdate = now(), updatedate = now() WHERE product_no = ?
		 */
		String sql = "UPDATE product SET category_name = ?, product_name = ?, product_price = ?, product_status = ?, product_stock = ?, product_info = ?, updatedate = now() WHERE product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, product.getCategoryName());
		stmt.setString(2, product.getProductName());
		stmt.setInt(3, product.getProductPrice());
		stmt.setString(4, product.getProductStatus());
		stmt.setInt(5, product.getProductStock());
		stmt.setString(6, product.getProductInfo());
		stmt.setInt(7, product.getProductNo());
		row = stmt.executeUpdate();
		System.out.println(stmt + "<--- productDao productUpdateStmt");
		return row;
	}
	
	// 2-1)기존상품이미지 삭제후 새로수정;
	public int updateProductImg(HttpServletRequest request, ProductImg productImg) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		// 이전파일 경로 조회후 삭제
		/* 이전파일 삭제를 위한 쿼리문 불러와서 삭제 File 클래스를 통해 삭제
		 	SELECT product_save_filename FROM product_img WHERE product_no = ?
		 */
		String saveFileSql = "SELECT product_save_filename FROM product_img WHERE product_img_no = ?";
		PreparedStatement saveFileStmt = conn.prepareStatement(saveFileSql);
		saveFileStmt.setInt(1, productImg.getProductImgNo());
		ResultSet saveFileRs = saveFileStmt.executeQuery();
		// request객체를 사용하여 파일주소를 dir에 저장
		String dir = request.getServletContext().getRealPath("/product/productImg");
		String preSaveFilename = "";
		if(saveFileRs.next()){
			preSaveFilename = saveFileRs.getString("product_save_filename");
		}
		File f = new File(dir + "/" + preSaveFilename);
		if(f.exists()) {
			f.delete();
		}
		
		// 수정모델
		// 새로 들어온 이미지 파일의 정보로 db수정
		/*
		 	UPDATE product_img SET product_ori_filename = ?, product_save_filename = ?, updatedate = NOW() 
		 	WHERE product_no = ?
		 */
		String productFileSql = "UPDATE product_img SET product_ori_filename = ?, product_save_filename = ?, updatedate = NOW() WHERE product_img_no = ?";
		PreparedStatement boardFileStmt = conn.prepareStatement(productFileSql);
		boardFileStmt.setString(1, productImg.getProductOriFilename());
		boardFileStmt.setString(2, productImg.getProductSaveFilename());
		boardFileStmt.setInt(3, productImg.getProductImgNo());
		row = boardFileStmt.executeUpdate();
	
		return row;
	}
	
	// 2-2) 수정할 데이터들 입력 폼을위한 출력모델
	public HashMap<String, Object> productOne(int productNo, int productImgNo) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		/*
		 	SELECT p.product_no, p.category_name, p.product_name, p.product_price, p.product_status, p.product_stock, p.product_info, i.product_no, i.product_ori_filename
			from
				product p INNER JOIN product_img i ON p.product_no = i.product_no
			WHERE p.product_no = 9 AND i.product_no = 9;
		 */
		String sql ="SELECT p.product_no, p.category_name, p.product_name, p.product_price, p.product_status, p.product_stock, p.product_info, i.product_img_no, i.product_ori_filename\r\n"
				+ "	 from\r\n"
				+ "			product p INNER JOIN product_img i ON p.product_no = i.product_no\r\n"
				+ "	 WHERE p.product_no = ? AND i.product_img_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		stmt.setInt(2, productImgNo);
		ResultSet rs = stmt.executeQuery();
		HashMap<String, Object> map = new HashMap<>();
		
		if(rs.next()) {
			map.put("productNo", rs.getInt("product_no"));
			map.put("productImgNo", rs.getInt("product_img_no"));
			map.put("categoryName", rs.getString("category_name"));
			map.put("productName", rs.getString("product_name"));
			map.put("productPrice", rs.getInt("product_price"));
			map.put("productStatus", rs.getString("product_status"));
			map.put("productStock", rs.getInt("product_stock"));
			map.put("productInfo", rs.getString("product_info"));
			map.put("productOriFilename", rs.getString("product_ori_filename"));
		}
		return map;
	}
	/*
	 	// 3) 상품삭제
	 	 
	public int deleteProduct(int productNo) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		int row = 0;
		
		 // DELETE FROM product WHERE product_no = ?
		
		String sql = "DELETE FROM product WHERE product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	*/
	
	// 4) 상품리스트 product inner join product_img
	public ArrayList<HashMap<String, Object>> productList(int beginRow, int rowPerPage) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		/* 상품 리스트 쿼리
		SELECT p.product_name, p.product_price, p.product_status, PI.product_save_filename
		FROM product p INNER JOIN product_img PI ON p.product_no = PI.product_no
		ORDER BY p.createdate DESC  LIMIT ? , ?;
		 */
		
		String sql = "SELECT p.product_no, p.product_name, p.product_price, p.product_status, pi.product_img_no, pi.product_save_filename\r\n"
				+ "		FROM product p INNER JOIN product_img pi ON p.product_no = pi.product_no\r\n"
				+ "		ORDER BY p.createdate DESC  LIMIT ? , ?";
		ArrayList<HashMap<String, Object>> productList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		System.out.println(stmt + "<-- productDao productList stmt");
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("productNo", rs.getInt("product_no"));
			map.put("productName", rs.getString("product_name"));
			map.put("productPrice", rs.getInt("product_price"));
			map.put("productStatus", rs.getString("product_status"));
			map.put("productImgNo", rs.getInt("product_img_no"));
			map.put("productSaveFilename", rs.getString("product_save_filename"));
			productList.add(map);
		}
		return productList;
	}
}
