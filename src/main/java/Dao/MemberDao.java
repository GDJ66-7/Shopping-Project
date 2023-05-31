package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DBUtil;
import vo.Id;

public class MemberDao {
	// 1) 로그인
	public int login(Id id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT id FROM id WHERE id = ? AND pw = PASSWORD(?)");
		stmt.setString(1, id.getId());
		stmt.setString(1, id.getPw());
		row = stmt.executeUpdate();
		return row;
	}
	// 2) 로그아웃 액션
	
}
