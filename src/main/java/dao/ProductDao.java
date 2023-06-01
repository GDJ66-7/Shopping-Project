package dao;
import java.sql.*;
import util.DBUtil;
import vo.Product;
import vo.ProductImg;

public class ProductDao {
	
	// 1) 상품추가
	public void insertProduct(Product product, ProductImg productImg) throws Exception {
		
		int row = 0;
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
		row = productImgStmt.executeUpdate();
		
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
		String sql = "UPDATE product SET category_name = ?, product_name = ?, product_price = ?, product_status = ?, product_stock = ?, product_info = ?, createdate = now(), updatedate = now() WHERE product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, product.getCategoryName());
		stmt.setString(2, product.getProductName());
		stmt.setInt(3, product.getProductPrice());
		stmt.setString(4, product.getProductStatus());
		stmt.setInt(5, product.getProductStock());
		stmt.setString(6, product.getProductInfo());
		stmt.setInt(7, product.getProductNo());
		row = stmt.executeUpdate();
		return row;
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
	
}