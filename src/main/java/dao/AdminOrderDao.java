package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class AdminOrderDao {
	// 관리자 고객 전체 구매내역
	public ArrayList<HashMap<String, Object>> orderAllList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT c.id 주문자,o.order_no 주문번호, p.product_name 상품이름, o.payment_status 결제상태, o.delivery_status 배송상태, o.order_cnt 수량, o.order_price 주문가격, o.order_address 주문배송지,o.updatedate 구매일 FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON h.product_no = p.product_no ORDER BY o.updatedate LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("주문자", rs.getString("주문자"));
			m.put("주문번호", rs.getString("주문번호"));
			m.put("상품이름", rs.getString("상품이름"));
			m.put("결제상태", rs.getString("결제상태"));
			m.put("배송상태", rs.getString("배송상태"));
			m.put("수량", rs.getInt("수량"));
			m.put("주문가격", rs.getInt("주문가격"));
			m.put("주문배송지", rs.getString("주문배송지"));
			m.put("구매일", rs.getString("구매일"));
			list.add(m);
		}
		return list;
	}
	//관리자 고객 전체 구매내역 총행의 수 구하는 쿼리
	public int orderAllRow() throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON h.product_no = p.product_no ORDER BY o.updatedate";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		return row;
	}
	// 관리자 고객 구매내역 검색했을때 쿼리
	public ArrayList<HashMap<String, Object>> searchOrderList(String id, int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		System.out.println(id);
		System.out.println(beginRow);
		System.out.println(rowPerPage);
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT c.id 주문자, o.order_no 주문번호, p.product_name 상품이름, o.payment_status 결제상태, o.delivery_status 배송상태, o.order_cnt 수량, o.order_price 주문가격, o.order_address 주문배송지, o.updatedate 구매일 FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON h.product_no = p.product_no WHERE c.id like ? ORDER BY o.updatedate LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(id);
		stmt.setString(1, "%" +id + "%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("주문자", rs.getString("주문자"));
			m.put("주문번호", rs.getString("주문번호"));
			m.put("상품이름", rs.getString("상품이름"));
			m.put("결제상태", rs.getString("결제상태"));
			m.put("배송상태", rs.getString("배송상태"));
			m.put("수량", rs.getInt("수량"));
			m.put("주문가격", rs.getInt("주문가격"));
			m.put("주문배송지", rs.getString("주문배송지"));
			m.put("구매일", rs.getString("구매일"));
			list.add(m);
		}
		return list;
	}
	// 관리자 고객 구매내역 검색했을때 총 행의 수를 구하는 쿼리
	public int searchOrderRow(String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON h.product_no = p.product_no WHERE c.id like ? ORDER BY o.updatedate";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" +id + "%");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		return row;
	}
	// 날짜 조회했을때 검색하는 쿼리
	public ArrayList<HashMap<String, Object>> dateOrderList(String startDate, String endDate,int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT c.id 주문자,o.order_no 주문번호, p.product_name 상품이름, o.payment_status 결제상태, o.delivery_status 배송상태, o.order_cnt 수량, o.order_price 주문가격, o.order_address 주문배송지, o.updatedate 구매일 FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON h.product_no = p.product_no WHERE o.createdate between ? and ? ORDER BY o.updatedate LIMIT ? ,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, startDate);
		stmt.setString(2, endDate);
		stmt.setInt(3, beginRow);
		stmt.setInt(4, rowPerPage);
		ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("주문자", rs.getString("주문자"));
				m.put("주문번호", rs.getString("주문번호"));
				m.put("상품이름", rs.getString("상품이름"));
				m.put("결제상태", rs.getString("결제상태"));
				m.put("배송상태", rs.getString("배송상태"));
				m.put("수량", rs.getInt("수량"));
				m.put("주문가격", rs.getInt("주문가격"));
				m.put("주문배송지", rs.getString("주문배송지"));
				m.put("구매일", rs.getString("구매일"));
				list.add(m);
			}
		return list;
	}
	//	날짜만 조회했을때 검색하는 쿼리의 총 행의 수
	public int dateOrderRow(String startDate, String endDate) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON h.product_no = p.product_no WHERE o.createdate between ? and ? ORDER BY o.updatedate ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, startDate);
		stmt.setString(2, endDate);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		return row;
	}
	// 날짜와 이름을 조회했을때 검색하는 메소드
	public ArrayList<HashMap<String, Object>> searchDateOrder(String id, String startDate, String endDate, int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT c.id 주문자,o.order_no 주문번호, p.product_name 상품이름, o.payment_status 결제상태, o.delivery_status 배송상태, o.order_cnt 수량, o.order_price 주문가격, o.order_address 주문배송지,o.updatedate 구매일 FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON h.product_no = p.product_no WHERE c.id like ? AND o.createdate between ? and ? ORDER BY o.updatedate LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" +id + "%");
		stmt.setString(2, startDate);
		stmt.setString(3, endDate);
		stmt.setInt(4, beginRow);
		stmt.setInt(5, rowPerPage);
		ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("주문자", rs.getString("주문자"));
				m.put("주문번호", rs.getString("주문번호"));
				m.put("상품이름", rs.getString("상품이름"));
				m.put("결제상태", rs.getString("결제상태"));
				m.put("배송상태", rs.getString("배송상태"));
				m.put("수량", rs.getInt("수량"));
				m.put("주문가격", rs.getInt("주문가격"));
				m.put("주문배송지", rs.getString("주문배송지"));
				m.put("구매일", rs.getString("구매일"));
				list.add(m);
			}
		return list;
	}
	//날짜와 이름을 조회했을때 총 행의 수를 구하는 쿼리
	public int searchDateOrderRow(String id, String startDate, String endDate) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON h.product_no = p.product_no WHERE c.id like ? AND o.createdate between ? and ? ORDER BY o.updatedate";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" +id + "%");
		stmt.setString(2, startDate);
		stmt.setString(3, endDate);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		return row;
	}
}
