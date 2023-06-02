package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Question;

public class QuestionDao {
	
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
		String sql = "INSERT into question(q_no, product_no, id, q_category category, q_title, q_content, createdate, updatedate) VALUES(?,?,?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, question.getqNo());
		stmt.setInt(2, question.getProductNo());
		stmt.setString(3, question.getqCategory());
		stmt.setString(4, question.getqTitle());
		stmt.setString(5, question.getqContent());
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
		stmt.setString(1,question.getqCategory());
		stmt.setString(2,question.getqTitle());
		stmt.setString(3,question.getqContent());
		stmt.setInt(4,question.getqNo());
		
		return row;
	}
}
