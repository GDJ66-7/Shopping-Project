package dao;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Review;
import vo.ReviewImg;

public class ReviewDao {
	
	// 제품페이지에서 보이는 리뷰 목록 + 페이징 -- DB: customer id / product no 외래키 추가 - 작성일 내림차순 정렬
	//(문의 목록 페이징과 겹치지 않게 변수명 변경-rev~)
		public ArrayList<HashMap<String, Object>> selectReviewListByPage(int productNo, int revbeginRow, int revrowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> rlist = new ArrayList<>();
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT order_no orderNo, product_no productNo, id, review_title reviewTitle"
					+ ", review_content reviewContent, createdate, updatedate FROM review"
					+ " WHERE product_no = ? ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		stmt.setInt(2, revbeginRow);
		stmt.setInt(3, revrowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> r = new HashMap<>();
			r.put("orderNo", rs.getString("orderNo"));
			r.put("productNo", rs.getInt("productNo"));
			r.put("id", rs.getString("id"));
			r.put("reviewTitle", rs.getString("reviewTitle"));
			r.put("reviewContent", rs.getString("reviewContent"));
			r.put("createdate", rs.getString("createdate"));
			r.put("updatedate", rs.getString("updatedate"));
			//System.out.println(r);
			rlist.add(r);
		}
			return rlist;
		}
		
	// 리뷰 상세정보 (텍스트)
	public Review selectReviewOne(int orderNo) throws Exception {
		Review review = null;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT order_no orderNo, product_no productNo, id, review_title reviewTitle, review_content reviewContent, createdate, updatedate FROM review WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			review = new Review();
			review.setOrderNo(rs.getInt("orderNo"));
			review.setProductNo(rs.getInt("productNo"));
			review.setId(rs.getString("id"));
			review.setReviewTitle(rs.getString("reviewTitle"));
			review.setReviewContent(rs.getString("reviewContent"));
			review.setCreatedate(rs.getString("createdate"));
			review.setUpdatedate(rs.getString("updatedate"));
		}
		System.out.println(review);
		return review;
	}
		
		
	// 리뷰 추가 (텍스트)
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
	

	// 리뷰 수정
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
	
	// 리뷰 삭제
	public int deleteReview(int orderNo) throws Exception {
		
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "DELETE from review WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 리뷰 전체 row (view 페이징에 사용)
	public int selectReviewCnt() throws Exception {
		
		int totalrow = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT count(*) from review";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalrow = rs.getInt("count(*)");
		}
		return totalrow;
	}
	
	// 이미지 쿼리 ----------------------------------------------------------------------------------------
	
	// 리뷰 이미지 view (화면 출력) -- ReviewImg (vo)
	public ReviewImg selectReviewImg(int orderNo) throws Exception {
		
		ReviewImg review = new ReviewImg();
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT review_ori_fileName reviewOrifilename, review_save_filename reviewSavefilename"
					+ ",review_filetype reviewFiletype FROM review_img WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			review = new ReviewImg();
			review.setReviewOriFilename(rs.getString("reviewOrifilename"));
			review.setReviewOriFilename(rs.getString("reviewSavefilename"));
			review.setReviewOriFilename(rs.getString("reviewFiletype"));
		}
		return review;
	}
	
	
	// 리뷰 이미지 추가 쿼리
	public int insertReviewImg(ReviewImg reviewImg) throws Exception {
		
		int row = 0;
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();
        String sql = "INSERT into review_img(order_no, review_ori_filename, review_save_filename, review_filetype, createdate, updatedate) values(?,?,?,?,now(),now())";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, reviewImg.getOrderNo());
        stmt.setString(2, reviewImg.getReviewOriFilename());
        stmt.setString(3, reviewImg.getReviewSaveFilename());
        stmt.setString(4, reviewImg.getReviewFiletype());
        
        row = stmt.executeUpdate();
        return row;
	}
	
	
	// 리뷰 이미지 삭제 -- dir (파일의 실제 경로) -> savefile 최종 삭제 (select - delete)
	public int deleteReviewImg (int orderNo, String dir ) throws Exception {

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT review_save_filename FROM review_img WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // preSaveFilename : 이전에 존재하던 파일
		String preSaveFilename = rs.getString("review_save_filename");
		File f = new File(dir,preSaveFilename);
		if(f.exists()) { // 파일이 존재하는지 확인, 존재하면 delete 정상 실행
				f.delete();
			}
		}
			return 1; //실행 완료 되면 1이 반환됨 (완료1 / 실패0)
	}
	
	// 리뷰 이미지 수정
	public int updateReviewImg (ReviewImg reviewImg) throws Exception {
		
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();
        String sql = "UPDATE review_img SET review_ori_filename = ?, review_save_filename = ?, review_filetype = ? WHERE order_no =? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, reviewImg.getReviewOriFilename());
		stmt.setString(2, reviewImg.getReviewSaveFilename());
		stmt.setString(3, reviewImg.getReviewFiletype());
		stmt.setInt(4, reviewImg.getOrderNo());
		
		int row = stmt.executeUpdate();
		return row;
	}
	
}