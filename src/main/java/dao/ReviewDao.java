package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Review;

public class ReviewDao {
	
	// 1) 제품페이지에서 보이는 리뷰 목록 + 페이징 (제목,내용,사진,작성일자(내림차순)) -- DB: customer id / product no 외래키 추가
		public ArrayList<HashMap<String, Object>> selectReviewListByPage(int productNo, int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT p.product_no productNo, p.id id, r.order_no orderNo, r.review_title reviewTitle, r.review_content reviewContent"
				+ ",r.createdate createdate, r.updatedate updatedate"
				+ ",img.review_ori_filename reviewOriFilename, img.review_save_filename reviewSaveFilename"
				+ ",img.review_filetype reviewFiletype"
				+ " FROM review r INNER JOIN review_img img ON r.order_no = img.order_no"
				+ " INNER JOIN product p ON p.product_no = r.order_no"
				+ " ORDER BY r.createdate DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> r = new HashMap<>();
			r.put("reviewTitle", rs.getString("reviewTitle"));
			r.put("reviewContent", rs.getString("reviewContent"));
			r.put("reviewSaveFilename", rs.getString("reviewSaveFilename"));
			r.put("createdate", rs.getString("createdate"));
			list.add(r);
		}
			return list;
		}
		
		
	// 2) 리뷰 추가
	public int insertReview(Review review) throws Exception { // 리뷰 이미지 추가예정
		
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "INSERT into review(order_no, product_no, id, review_title, review_content, createdate, updatedate) values(?,?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, review.getOrderNo());
		stmt.setInt(2, review.getProductNo());
		stmt.setString(3, review.getId());
		stmt.setString(4, review.getReviewTitle());
		stmt.setString(5, review.getReviewContent());
		row = stmt.executeUpdate();
		
		return row;
	}
	

	// 3) 리뷰 수정
	public int updateReview(Review review) throws Exception {
		
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "UPDATE review SET review_title = ?, review_content = ? WHERE order_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,review.getReviewTitle());
		stmt.setString(2,review.getReviewContent());
		stmt.setInt(3, review.getOrderNo());
		row = stmt.executeUpdate();
		
		return row;
		
	}
	
	// 4) 리뷰 삭제
	public int deleteReview(Review review) throws Exception {
		
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "DELETE from review WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, review.getOrderNo());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 5) 리뷰 전체 row (view 페이징에 사용)
	public int selectReviewCnt() throws Exception {
		
		int totalrow = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELETE count(*) from review";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalrow = rs.getInt("count(*)");
		}
		return totalrow;
	}
	
}