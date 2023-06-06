package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Answer;

public class AnswerDao {

	// 문의사항 관리자 답변 추가 (insertAnswer.jsp) -- 게시판 댓글 형식 답변
	public int insertAnswer(Answer answer) throws Exception {
		
		DBUtil DButil = new DBUtil();
		Connection conn = DButil.getConnection();
		String sql = "INSERT into answer(q_no,id,a_content,createdate,updatedate) values(?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, answer.getqNo());
		stmt.setString(2, answer.getId());
		stmt.setString(3, answer.getaContent());
		int row = stmt.executeUpdate();
		
		return row;
	}
	
	// 문의사항 관리자 답변 수정
	public int updateAnswer(int aNo, String aContent) throws Exception {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE answer SET a_content = ? WHERE a_no= ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, aContent);
	    stmt.setInt(2, aNo);
		int row = stmt.executeUpdate();

		return row;
	}
	
	
	// 문의사항 관리자 답변 삭제
	public int deleteAnswer(int aNo) throws Exception {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
	    String sql = "DELETE from answer WHERE a_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, aNo);
	    int row =stmt.executeUpdate();
		
		return row;
	}
	
	// 답변 리스트 (view)
	public Answer answerOne(int qNo) throws Exception {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="select a_no, q_no, id, a_content, createdate, updatedate from answer where q_no= ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, qNo);
	    
	    ResultSet rs = stmt.executeQuery();
	    Answer answer = null;
	    if(rs.next()) {
		   answer = new Answer();
		   answer.setaNo(rs.getInt("a_no"));;
		   answer.setqNo(rs.getInt("q_no"));
		   answer.setId(rs.getString("id"));
	       answer.setaContent(rs.getString("a_content"));
	       answer.setUpdatedate(rs.getString("updatedate"));
	       answer.setCreatedate(rs.getString("createdate"));
    	}
	    //System.out.println(answer);
	    return answer;
	}
}
