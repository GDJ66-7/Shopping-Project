package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DBUtil;
import vo.Answer;

public class AnswerDao {

	// 문의사항 관리자 답변 추가 (insertAnswer.jsp) -- productNo와 join..?
	public int insertAnswer(Answer answer) throws Exception {
		
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "INSERT into answer(a_no,q_no,id,a_content,createdate,updatedate) values(?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, answer.getaNo());
		stmt.setInt(2, answer.getqNo());
		stmt.setString(3, answer.getId());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 문의사항 관리자 답변 수정
	
	// 문의사항 관리자 답변 삭제
	public int deleteAnswer(Answer answer) throws Exception {
		
		int row = 0;
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "DELETE from answer WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, answer.getaNo());
		row = stmt.executeUpdate();
		
		return row;
	}
}
