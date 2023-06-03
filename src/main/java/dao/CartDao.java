package dao;

import java.util.*;
import util.*;
import java.sql.*;

import vo.*;

public class CartDao {
	// 장바구니 상품 리스트 
	public ArrayList<HashMap<String, Object>> selectCartList(String id) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>(); 
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT c.cart_no 장바구니번호, i.product_save_filename 상품이미지, c.id 아이디, p.product_name 상품이름, p.product_price 상품가격,"
				+ " p.product_price*(1- d.discount_rate) 할인상품가격, p.product_price*(1- d.discount_rate)*c.cart_cnt 전체가격, c.cart_cnt 수량,"
				+ " c.createdate 생성일, c.updatedate 수정일 "
				+ "FROM cart c "
				+ "INNER JOIN product p ON c.product_no = p.product_no "
				+ "INNER JOIN discount d ON p.product_no = d.discount_no "
				+ "INNER JOIN product_img i ON p.product_no = i.product_no "
				+ "INNER JOIN customer m ON c.id = m.id WHERE m.id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> c = new HashMap<>();
			c.put("장바구니번호", rs.getInt("장바구니번호"));
			c.put("상품이미지",rs.getString("상품이미지"));
			c.put("아이디",rs.getString("아이디"));
			c.put("상품이름",rs.getString("상품이름"));
			c.put("상품가격",rs.getInt("상품가격"));
			c.put("수량", rs.getInt("수량"));
			c.put("할인상품가격",rs.getInt("할인상품가격"));
			c.put("전체가격",rs.getInt("전체가격"));
			c.put("생성일",rs.getString("생성일"));
			c.put("수정일",rs.getString("수정일"));
			list.add(c);
		}
		return list;
	}
	
	// 장바구니 상품 추가
	public int insertCart(Cart cart) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "INSERT INTO cart(product_no, id, createdate, cart_cnt, updatedate) VALUES(?, ?, NOW(), ?, NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getProductNo());
		stmt.setString(2, cart.getId());
		stmt.setInt(3, cart.getCartCnt());
		row = stmt.executeUpdate();
		return row;
	}
	
	// 현재 장바구니에 있는 상품인지 확인
	public int selectCartCheck(Cart cart) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT * FROM cart WHERE product_no = ?  AND id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getProductNo());
		stmt.setString(1, cart.getId());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("count(*)");	// 있으면 row에 1 저장
		}
		return row;	// 없으면 row = 0
	}

	// 현재 장바구니에 있는 상품이면 추가한 수량만큼 +
	public int updateCartCntSum(Cart cart) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "UPDATE cart SET cart_cnt = cart_cnt + ? WHERE product_no = ? AND id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getCartCnt());
		stmt.setInt(2, cart.getProductNo());
		stmt.setString(3, cart.getId());
		row = stmt.executeUpdate();
		return row;
	}
	
	// 장바구니 상품 수량 수정
	public int updateCartQuantity(Cart cart) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "UPDATE cart SET cart_cnt = ? WHERE product_no = ? AND id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getCartCnt());
		stmt.setInt(2, cart.getProductNo());
		stmt.setString(3, cart.getId());
		row = stmt.executeUpdate();
		return row;
	}
	
	// 장바구니 상품 삭제 버튼
	public int deleteCart(Cart cart) throws Exception {
		int row = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "DELETE FROM cart WHERE product_no = ? AND id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getProductNo());
		stmt.setString(2, cart.getId());	
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
	// ----------------------------------------------------------------
	
	// 	장바구니에서 구매할 상품들 조회
	public ArrayList<HashMap<String, Object>> selectCartOrder(String id) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>(); 
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT m.cstm_name 이름, m.cstm_email 이메일, m.cstm_phone 휴대폰번호, m.cstm_address 배송주소, p.product_name 배송상품, "
				+ "c.cart_cnt 상품수량, p.product_price * c.cart_cnt 총상품가격, p.product_price * d.discount_rate 할인금액, "
				+ "m.cstm_point 보유포인트, p.product_price * (1 - d.discount_rate) * c.cart_cnt 총결제금액 "
				+ "FROM cart c "
				+ "INNER JOIN product p ON c.product_no = p.product_no "
				+ "INNER JOIN customer m ON c.id = m.id "
				+ "INNER JOIN discount d ON p.product_no = d.product_no "
				+ "WHERE m.id = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			HashMap<String, Object> co = new HashMap<>();
			co.put("이름", rs.getString("이름"));
			co.put("이메일", rs.getString("이메일"));
			co.put("휴대폰번호", rs.getString("휴대폰번호"));
			co.put("배송주소", rs.getString("배송주소"));
			co.put("배송상품", rs.getString("배송상품"));
			co.put("상품수량", rs.getInt("상품수량"));
			co.put("총상품가격", rs.getInt("총상품가격"));
			co.put("할인금액", rs.getInt("할인금액"));
			co.put("보유포인트", rs.getInt("보유포인트"));
			co.put("총결제금액", rs.getInt("총결제금액"));
			list.add(co);
		}
		return list;
	}
	
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
	
	
	
	
}	
