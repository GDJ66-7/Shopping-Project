package dao;

import util.*;
import java.sql.*;
import java.util.*;
import vo.*;

public class CartDao {
	// 0. 장바구니에 상품 조회(현재 장바구니에 있는 상품인지 확인) select
	// 장바구니에 상품 추가(현재 장바구니에 있는 상품이 아니면)	insert
	// 장바구니에 상품 수량 수정(현재 장바구니에 있는 상품이면) update
	public int totalInsertCart(Cart cart) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String selectSql = "SELECT count(*) "
						+ "FROM cart "
						+ "WHERE product_no = ? AND id = ? ";
		String updateSql = "UPDATE cart "
						+ "SET cart_cnt = cart_cnt + ? "
						+ "WHERE product_no = ? AND id = ?";
		String insertSql = "INSERT INTO cart(product_no, id, cart_cnt, checked, createdate, updatedate) "
						+ "VALUES(?, ?, ?, 'y', NOW(), NOW())";
		// 장바구니에 같은 상품이 있는지 확인한다.
		PreparedStatement selectStmt = conn.prepareStatement(selectSql);
		selectStmt.setInt(1, cart.getProductNo());
		selectStmt.setString(2, cart.getId());
		ResultSet rs = selectStmt.executeQuery();
		int row = 0;
		if(rs.next()) {
			row = rs.getInt(1);
		}
		if(row>0) {	// 장바구니에 같은 상품이 있으므로 추가한 수량만큼 +한다.
			PreparedStatement updateStmt = conn.prepareStatement(updateSql);
			updateStmt.setInt(1, cart.getCartCnt());
	        updateStmt.setInt(2, cart.getProductNo());
	        updateStmt.setString(3, cart.getId());
	        row = updateStmt.executeUpdate();
		} else { // 장바구니에 같은 상품이 없으므로 새로 추가한다.
			PreparedStatement insertStmt = conn.prepareStatement(insertSql);
	        insertStmt.setInt(1, cart.getProductNo());
	        insertStmt.setString(2, cart.getId());
	        insertStmt.setInt(3, cart.getCartCnt());
	        row = insertStmt.executeUpdate();
		}
		return row;
	}
	
	// 1. 고객ID에 해당하는 장바구니 상품 목록
	public ArrayList<HashMap<String, Object>> cartList(String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT c.product_no 상품번호, "
				+ "c.cart_no 장바구니번호, "
				+ "i.product_save_filename 상품이미지, "
				+ "c.id 아이디, "
				+ "p.product_name 상품이름, "
				+ "p.product_price 상품가격, "
				+ "p.product_price*(1- IFNULL(d.discount_rate, 0)) 할인상품가격, "
				+ "p.product_price*(1- IFNULL(d.discount_rate, 0))*c.cart_cnt 전체가격, "
				+ "c.cart_cnt 수량, "
				+ "c.checked 체크 "
				+ "FROM cart c "
				+ "		LEFT OUTER JOIN product p ON c.product_no = p.product_no "
				+ "		LEFT OUTER JOIN discount d ON p.product_no = d.product_no "
				+ "		LEFT OUTER JOIN product_img i ON p.product_no = i.product_no "
				+ "		LEFT OUTER JOIN customer m ON c.id = m.id "
				+ "WHERE m.id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();	
		ArrayList<HashMap<String, Object>> list = new ArrayList<>(); 
		while(rs.next()) {
			HashMap<String, Object> c = new HashMap<>();
			c.put("상품번호", rs.getInt("상품번호"));
			c.put("장바구니번호", rs.getInt("장바구니번호"));
			c.put("상품이미지",rs.getString("상품이미지"));
			c.put("아이디",rs.getString("아이디"));
			c.put("상품이름",rs.getString("상품이름"));
			c.put("상품가격",rs.getInt("상품가격"));
			c.put("할인상품가격",rs.getInt("할인상품가격"));
			c.put("전체가격",rs.getInt("전체가격"));
			c.put("수량", rs.getInt("수량"));
			c.put("체크", rs.getString("체크"));
			list.add(c);
		}
		return list;
	}
	
	// 2. 장바구니에서 수량 수정 가능한 최대 값(상품 재고량)
	public int maxCartCnt(int productNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();				
		String sql = "SELECT product_stock"
				+ " FROM product"
				+ " WHERE product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,productNo);
		ResultSet rs = stmt.executeQuery();
		int row = 0;
		if(rs.next()) {
			row = rs.getInt("product_stock");
		}
		return row;
	}
	
	// 3. 장바구니 단일 상품 삭제
	public int deleteSingleCart(Cart cart) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "DELETE FROM cart WHERE cart_no = ? AND id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getCartNo());
		stmt.setString(2, cart.getId());	
		int row = 0;
		row = stmt.executeUpdate();
		return row;
	}
	
	// 4. 장바구니 단일 상품 수량 수정
	public int updateSingleCart(Cart cart) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "UPDATE cart "
				+ "SET cart_cnt = ? "
				+ "WHERE cart_no = ? AND id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getCartCnt());
		stmt.setInt(2, cart.getCartNo());
		stmt.setString(3, cart.getId());
		int row = 0;
		row = stmt.executeUpdate();
		return row;
	}
	
	// 5. 장바구니 체크 변경
	public int updateChecked(Cart cart) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "UPDATE cart "
				+ "SET checked = ? "
				+ "WHERE cart_no = ? AND id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cart.getChecked());
		stmt.setInt(2, cart.getCartNo());
		stmt.setString(3, cart.getId());
		int row = 0;
		row = stmt.executeUpdate();
		return row;
	}
	
	// 6. 장바구니에서 선택한(checked = y) 상품 목록 조회
	public ArrayList<HashMap<String, Object>> checkedList(String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT p.product_name 상품이름, c.cart_cnt 수량 "
				+ "FROM cart c "
				+ "		INNER JOIN product p ON c.product_no = p.product_no "
				+ "		INNER JOIN customer m ON c.id = m.id "
				+ "WHERE m.id = ? AND c.checked = 'y' ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> list = new ArrayList<>(); 
		while(rs.next()) {
			HashMap<String, Object> c = new HashMap<>();
			c.put("상품이름", rs.getString("상품이름"));
			c.put("수량", rs.getInt("수량"));
			list.add(c);
		}
		return list;
	}
	
	// 7. 구매자정보, 받는사람정보 조회
	public ArrayList<HashMap<String, Object>> cartOrderList(String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT m.id 아이디, "
				+ "m.cstm_name 이름, "
				+ "m.cstm_email 이메일, "
				+ "m.cstm_phone 휴대폰번호, "
				+ "m.cstm_address 배송주소, "
				+ "m.cstm_point 보유포인트, "
				+ "SUM(p.product_price * c.cart_cnt) 총상품가격, "
				+ "SUM(p.product_price) * SUM((1- IFNULL(d.discount_rate, 0))) 할인적용금액, "
				+ "SUM(p.product_price) - SUM(p.product_price * (1- IFNULL(d.discount_rate, 0))) 할인금액, "
				+ "SUM(p.product_price*(1- IFNULL(d.discount_rate, 0))*c.cart_cnt) 전체금액, "
				+ "SUM((p.product_price * (1 - IFNULL(d.discount_rate, 0)) * c.cart_cnt)) - m.cstm_point 총결제금액 "
				+ "FROM cart c "
				+ "		LEFT OUTER JOIN product p ON c.product_no = p.product_no "
				+ "     LEFT OUTER JOIN customer m ON c.id = m.id "
				+ "     LEFT OUTER JOIN discount d ON p.product_no = d.product_no "
				+ "WHERE m.id = ? AND c.checked = 'y'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);	
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> list = new ArrayList<>(); 
		if(rs.next()) {
			HashMap<String, Object> c = new HashMap<>();	
			c.put("아이디", rs.getString("아이디"));
			c.put("이름", rs.getString("이름"));
			c.put("이메일", rs.getString("이메일"));
			c.put("휴대폰번호", rs.getString("휴대폰번호"));
			c.put("배송주소", rs.getString("배송주소"));	
			c.put("보유포인트", rs.getInt("보유포인트"));
			c.put("총상품가격", rs.getInt("총상품가격"));
			c.put("할인적용금액", rs.getInt("할인적용금액"));
			c.put("할인금액", rs.getInt("할인금액"));
			c.put("전체금액", rs.getInt("전체금액"));
			c.put("총결제금액", rs.getInt("총결제금액"));
			list.add(c);
		}
		return list;
	}

	
	
	
	
	
	
	// 9. 결제시 주문 정보를 orders 테이블에 추가
	public int insertCartOrder(Orders orders) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "INSERT INTO orders(product_no, id, payment_status, delivery_state, order_cnt, order_price, createdate, updatedate) "
				+ "VALUES(?, ?, ?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orders.getProductNo());
		stmt.setString(2, orders.getId());
		stmt.setString(3, orders.getPaymentStatus());
		stmt.setString(4, orders.getDeliveryState());
		stmt.setInt(5, orders.getOrderCnt());
		stmt.setInt(6, orders.getOrderPrice());
		int row = 0;
		row = stmt.executeUpdate();
		return row;
	}
	

}	


/*
	// 주소값을 넘기면 해당 주소로 업데이트
	public int addressCartOrder(String address, int orderNo) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "UPDATE orders SET order_address = ? WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, address);
		stmt.setInt(2, orderNo);
		row = stmt.executeUpdate();
		return row;
}
	
	// 구매완료(성공)시 장바구니 상품 삭제
	public int deleteCartId(String id) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "DELETE FROM cart WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		row = stmt.executeUpdate();
		return row;
	}
	
 */