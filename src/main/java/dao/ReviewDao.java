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
	// orderNo ---> historyNo (vo수정)
		public ArrayList<HashMap<String, Object>> selectReviewListByPage(int productNo, int revbeginRow, int revrowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> rlist = new ArrayList<>();
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT history_no historyNo, product_no productNo, id, review_title reviewTitle"
					+ ", review_content reviewContent, createdate, updatedate FROM review"
					+ " WHERE product_no = ? ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		stmt.setInt(2, revbeginRow);
		stmt.setInt(3, revrowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> r = new HashMap<>();
			r.put("historyNo", rs.getString("historyNo"));
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
	public Review selectReviewOne(int historyNo) throws Exception {
		Review review = null;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT history_no historyNo, product_no productNo, id, review_title reviewTitle, review_content reviewContent, createdate, updatedate FROM review WHERE history_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,historyNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			review = new Review();
			review.setHistoryNo(rs.getInt("historyNo"));
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
	public int insertReview(Review review) throws Exception {
		
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "INSERT into review(history_no, product_no, id, review_title, review_content, createdate, updatedate) values(?,?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, review.getHistoryNo());
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
		String sql = "UPDATE review SET review_title = ?, review_content = ? WHERE history_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,review.getReviewTitle());
		stmt.setString(2,review.getReviewContent());
		stmt.setInt(3, review.getHistoryNo());
		row = stmt.executeUpdate();
		
		return row;
		
	}
	
	// 리뷰 삭제 (텍스트+이미지 전체 삭제 테이블 join)
	public int deleteReview(int historyNo) throws Exception {
		
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "DELETE r,ri from review r "
					+"INNER JOIN review_img ri ON r.history_no = ri.history_no "
					+ "WHERE r.history_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, historyNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 리뷰 전체 row (view 페이징에 사용)
	public int selectReviewCnt(int productNo) throws Exception {
		
		int totalrow = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT count(*) from review where product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalrow = rs.getInt("count(*)");
		}
		return totalrow;
	}
	
	// 이미지 쿼리 ----------------------------------------------------------------------------------------
	
	// 리뷰 이미지 view (화면 출력) -- ReviewImg (vo)
	public ReviewImg selectReviewImg(int historyNo) throws Exception {
		
		ReviewImg review = new ReviewImg();
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT review_ori_fileName reviewOrifilename, review_save_filename reviewSavefilename"
					+ ",review_filetype reviewFiletype FROM review_img WHERE history_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, historyNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			review = new ReviewImg();
			review.setReviewOriFilename(rs.getString("reviewOrifilename"));
			review.setReviewSaveFilename(rs.getString("reviewSavefilename"));
			review.setReviewFiletype(rs.getString("reviewFiletype"));
		}
		return review;
	}
	
	
	// 리뷰 이미지 추가 쿼리
	public int insertReviewImg(ReviewImg reviewImg) throws Exception {
		
		int row = 0;
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();
        String sql = "INSERT into review_img(history_no, review_ori_filename, review_save_filename, review_filetype, createdate, updatedate) values(?,?,?,?,now(),now())";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, reviewImg.getHistoryNo());
        stmt.setString(2, reviewImg.getReviewOriFilename());
        stmt.setString(3, reviewImg.getReviewSaveFilename());
        stmt.setString(4, reviewImg.getReviewFiletype());
        
        row = stmt.executeUpdate();
        return row;
	}
	
	// 리뷰 이미지 삭제
	public int deleteReviewImg (int historyNo, String dir) throws Exception {

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT review_save_filename FROM review_img WHERE history_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, historyNo);
		ResultSet rs = stmt.executeQuery();
		String preSaveFilename = "";
		if(rs.next()) { // preSaveFilename : 이전에 존재하던 파일
			preSaveFilename = rs.getString("review_save_filename");
		}
		File f = new File(dir+"/"+preSaveFilename);
		if(f.exists()) { // 파일이 존재하는지 확인, 존재하면 delete 정상 실행
			f.delete();
			}
			return 1; //실행 완료 되면 1이 반환됨 (완료1 / 실패0)
		}
	
	// 리뷰 이미지 수정
	public int updateReviewImg (ReviewImg reviewImg) throws Exception {
		
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();
        String sql = "UPDATE review_img SET review_ori_filename = ?, review_save_filename = ?, review_filetype = ? WHERE history_no =? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, reviewImg.getReviewOriFilename());
		stmt.setString(2, reviewImg.getReviewSaveFilename());
		stmt.setString(3, reviewImg.getReviewFiletype());
		stmt.setInt(4, reviewImg.getHistoryNo());
		
		int row = stmt.executeUpdate();
		return row;
	}
}