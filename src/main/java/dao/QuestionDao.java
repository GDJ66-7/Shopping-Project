package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Question;

public class QuestionDao {
	
	// 상품 상세정보에서 보이는 문의 목록 -- 문의번호&작성일자 내림차순
	public ArrayList<HashMap<String, Object>> selectQuestionListByPage(int productNo, int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT q_no qNo, product_no productNo, id, q_category category, q_title title"
				+ ",q_content content, createdate FROM question"
				+ " WHERE product_no = ? ORDER BY q_no DESC, createdate DESC limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> q = new HashMap<>();
			q.put("qNo", rs.getString("qNo"));
			q.put("productNo", rs.getInt("productNo"));
			q.put("id", rs.getString("id"));
			q.put("category", rs.getString("category"));
			q.put("title", rs.getString("title"));
			q.put("content", rs.getString("content"));
			q.put("createdate", rs.getString("createdate"));
			//System.out.println(q);
			list.add(q);
		}
			return list;
		}
		
	
	// 문의 상세정보
	public Question selectQuestionOne(int qNo) throws Exception {
		Question question = null;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT q_no qNo, product_no productNo, id, q_category category, q_title questionTitle, q_content questionContent, createdate FROM question WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			question = new Question();
			question.setqNo(rs.getInt("qNo"));
			question.setProductNo(rs.getInt("productNo"));
			question.setId(rs.getString("id"));
			question.setqCategory(rs.getString("category"));
			question.setqTitle(rs.getString("questionTitle"));
			question.setqContent(rs.getString("questionContent"));
			question.setCreatedate(rs.getString("createdate"));
		}
		return question;
	}
	
	
	// 상품문의 추가(회원)
	public int insertQuestion(Question question) throws Exception {
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "INSERT into question(q_no, product_no, id, q_category, q_title, q_content, createdate, updatedate) VALUES(?,?,?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, question.getqNo());
		stmt.setInt(2, question.getProductNo());
		stmt.setString(3, question.getId());
		stmt.setString(4, question.getqCategory());
		stmt.setString(5, question.getqTitle());
		stmt.setString(6, question.getqContent());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	
	// 상품문의 삭제(회원)
	public int deleteQuestion(int qNo) throws Exception {
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "DELETE from question WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	
	// 상품문의 수정(회원)
	public int updateQuestion(Question question) throws Exception {
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "UPDATE question SET q_category = ?, q_title = ?, q_content = ? WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, question.getqCategory());
		stmt.setString(2, question.getqTitle());
		stmt.setString(3, question.getqContent());
		stmt.setInt(4, question.getqNo());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	
	// 5) 문의 전체 row (view 페이징에 사용)
	public int selectQuestionCnt() throws Exception {
		
		int totalrow = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT count(*) from question";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalrow = rs.getInt("count(*)");
		}
		return totalrow;
	}
	
	// 6) 문의사항 카테고리 (insert&update) 선택 쿼리(수정해야함)
	public ArrayList<HashMap<String, Object>> selectqCategory(String qCategory) throws Exception{
		ArrayList<HashMap<String, Object>> categorylist = new ArrayList<>();
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "SELECT q_category qCategory from question";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> c = new HashMap<>();
			c.put("qCategory", rs.getString("qCategory"));
			categorylist.add(c);
			System.out.println(c+"<----Qcategory");
		}
		return categorylist;
	}
}