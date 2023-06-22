package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class OrderDao {
	// 고객 구매내역
		public ArrayList<HashMap<String, Object>> orderList(String id, String startDate, String endDate, int beginRow, int rowPerPage) throws Exception{
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "SELECT o.order_no 주문번호, p.product_name 상품이름, o.payment_status 결제상태, o.delivery_status 배송상태, o.order_cnt 수량, o.order_price 주문가격, o.order_address 주문배송지, o.updatedate 구매일, h.history_no 주문내역번호, p.product_no 상품번호 FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON h.product_no = p.product_no WHERE c.id = ?";
			//날짜 검색했을때
			if(!startDate.equals("") && !endDate.equals("")) {
				sql+=" AND o.createdate between '"+startDate+"' AND '"+endDate+"'";
			}
			sql += " ORDER BY o.updatedate LIMIT ?, ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("주문번호", rs.getInt("주문번호"));
				m.put("상품이름", rs.getString("상품이름"));
				m.put("결제상태", rs.getString("결제상태"));
				m.put("배송상태", rs.getString("배송상태"));
				m.put("수량", rs.getInt("수량"));
				m.put("주문가격", rs.getInt("주문가격"));
				m.put("주문배송지", rs.getString("주문배송지"));
				m.put("구매일", rs.getString("구매일"));
				m.put("주문내역번호", rs.getInt("주문내역번호"));
				m.put("상품번호", rs.getInt("상품번호"));
				list.add(m);
			}
			return list;
		}
		// 고객 구매내역 총 갯수
		public int selectOrder(String id, String startDate, String endDate) throws Exception {
			int row = 0;
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql ="SELECT count(*)  FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON h.product_no = p.product_no WHERE c.id = ?";
			//날짜 검색했을때
			if(!startDate.equals("") && !endDate.equals("")) {
				sql+=" AND o.createdate between '"+startDate+"' AND '"+endDate+"'";
			}
			sql+= " ORDER BY o.updatedate";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				row = rs.getInt(1);
			}
			return row;
		}
		// 상품 구매 조회
		public ArrayList<HashMap<String, Object>> selectOrder(int orderNo) throws Exception{
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "SELECT o.order_no 주문번호, p.product_name 상품이름, o.payment_status 결제상태, o.delivery_status 배송상태, o.order_cnt 수량, o.order_price 주문가격,o.order_address 주문배송지, o.updatedate 구매일 FROM orders o INNER JOIN orders_history h ON h.order_no = o.order_no INNER JOIN product p ON p.product_no = h.product_no WHERE o.order_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("주문번호", rs.getInt("주문번호"));
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
		// 상품 구매 취소
		public int cancelOrder(int orderNo) throws Exception {
			int row = 0;
			System.out.println(orderNo + "<-- OrderDao cancelOrder orderNo");
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "  UPDATE orders SET payment_status = '취소', delivery_status = '구매취소', updatedate = now() WHERE order_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			row = stmt.executeUpdate();
			return row ;
		}
		// 상품 구매취소시 포인트 변경
		public int  cancelPoint(int  orderNo) throws Exception{
			int row = 0;
			int point = 0;
			System.out.println(orderNo + "<-- OrderDao cancelpoint orderNo");
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "SELECT point FROM point_history WHERE order_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			System.out.println(stmt + "< cancelPoint stmt");
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				point = rs.getInt(1);
			}
			System.out.println(point + "<-- point");
			String sql2 = "INSERT INTO point_history(order_no, point_pm, point, createdate) values(?,'-',?,now())";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setInt(1, orderNo);
			stmt2.setInt(2, point);
			row = stmt2.executeUpdate();
			return row;
		}
		// 상품주문확정
		public int complete(int orderNo) throws Exception {
			int row = 0;
			System.out.println(orderNo + "<-- OrderDao cancelpoint orderNo");
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "UPDATE orders SET delivery_status ='구매확정', updatedate = now() WHERE order_no =?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			row = stmt.executeUpdate();
			return row;
		}
}
