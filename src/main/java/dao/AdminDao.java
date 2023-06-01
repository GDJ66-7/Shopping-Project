package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class AdminDao {
	//관리자 마이페이지 리스트
	public ArrayList<HashMap<String, Object>> selectEmpList(String id) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT emp_name 사원이름, emp_level 사원등급, createdate 가입일, updatedate 수정일 FROM employees WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("사원이름", rs.getString("사원이름"));
			m.put("사원등급", rs.getString("사원등급"));
			m.put("가입일", rs.getString("가입일"));
			m.put("수정일", rs.getString("수정일"));
			list.add(m);
		}
		return list;
	}
}
