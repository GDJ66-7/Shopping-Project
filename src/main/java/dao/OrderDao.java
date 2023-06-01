package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class OrderDao {
	// 고객 구매내역
		public ArrayList<HashMap<String, Object>> orderList(String id, int beginRow, int rowPerPage) throws Exception{
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "SELECT o.order_no 주문번호, p.product_name 상품이름, o.payment_status 결제상태, o.delivery_status 배송상태, o.order_cnt 수량, o.order_price 주문가격, o.updatedate 구매일 FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN product p ON p.product_no = o.product_no WHERE c.id = ? ORDER BY o.updatedate LIMIT ?,?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("주문번호", rs.getString("주문번호"));
				m.put("상품이름", rs.getString("상품이름"));
				m.put("결제상태", rs.getString("결제상태"));
				m.put("배송상태", rs.getString("배송상태"));
				m.put("수량", rs.getInt("수량"));
				m.put("주문가격", rs.getInt("주문가격"));
				m.put("구매일", rs.getString("구매일"));
				list.add(m);
			}
			return list;
		}
		// 상품 구매 취소
		public int cancelOrder(int orderNo) throws Exception {
			int row = 0;
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "  UPDATE orders SET payment_status = '취소', delivery_status = '구매취소', updatedate = now() WHERE order_no = ?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			row = stmt.executeUpdate();
			return row ;
		}
}
