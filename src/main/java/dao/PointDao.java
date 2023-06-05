package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class PointDao {
	//관리자가 모든 고객 포인트 내역 조회 
	public ArrayList<HashMap<String, Object>> pointList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT c.id 고객아이디,p.order_no 주문번호, p.point_pm 증감, p.point 포인트, p.createdate 적립일자 FROM customer c INNER JOIN orders o ON  c.id = o.id INNER JOIN point_history p ON o.order_no = p.order_no ORDER BY p.createdate DESC  LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("고객아이디", rs.getString("고객아이디"));
			m.put("주문번호", rs.getInt("주문번호"));
			m.put("증감", rs.getString("증감"));
			m.put("포인트", rs.getInt("포인트"));
			m.put("적립일자", rs.getString("적립일자"));
			list.add(m);
		}
		return list;
	}
	//고객 포인트 내역조회
	public ArrayList<HashMap<String, Object>> cstmPointList(int beginRow, int rowPerPage, String id) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT p.order_no 주문번호, p.point_pm 증감, p.point 포인트, p.createdate 적립일자 FROM customer c INNER JOIN orders o ON  c.id = o.id INNER JOIN point_history p ON o.order_no = p.order_no WHERE c.id = ? ORDER BY p.createdate DESC LIMIT ?,? ";
		PreparedStatement stmt =conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("주문번호",rs.getInt("주문번호"));
			m.put("증감", rs.getString("증감"));
			m.put("포인트", rs.getInt("포인트"));
			m.put("적립일자", rs.getString("적립일자"));
			list.add(m);
		}
		return list;
	}
	//고객당 포인트리스트 행 총 갯수 조회
	public int selectPointRow(String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM customer c INNER JOIN orders o ON  c.id = o.id INNER JOIN point_history p ON o.order_no = p.order_no WHERE c.id = ? ORDER BY p.createdate DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("count(*)");
		}
		return row;
	}
	//모든 고객의 리스트 행의 수 조회
	public int pointRow() throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM customer";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		return row;
	}
}
