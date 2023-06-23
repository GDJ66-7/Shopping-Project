package dao;

import util.*;
import java.sql.*;
import java.util.*;
import vo.*;

public class CartDao {
	// 0. 장바구니에 상품 조회(현재 장바구니에 있는 상품인지 확인) ( SELECT )
	// 장바구니에 상품 추가(현재 장바구니에 있는 상품이 아니면)	( INSERT )
	// 장바구니에 상품 수량 수정(현재 장바구니에 있는 상품이면) ( UPDATE )
	public int totalInsertCart(Cart cart) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String selectSql = "SELECT count(*) "
						+ "FROM cart "
						+ "WHERE product_no = ? AND id = ? ";
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
			String updateSql = "UPDATE cart "
					+ "SET cart_cnt = cart_cnt + ? ,updatedate = NOW() "
					+ "WHERE product_no = ? AND id = ?";
			PreparedStatement updateStmt = conn.prepareStatement(updateSql);
			updateStmt.setInt(1, cart.getCartCnt());
	        updateStmt.setInt(2, cart.getProductNo());
	        updateStmt.setString(3, cart.getId());
	        row = updateStmt.executeUpdate();
		} else { // 장바구니에 같은 상품이 없으므로 새로 추가한다.
			String insertSql = "INSERT INTO cart(product_no, id, cart_cnt, checked, createdate, updatedate) "
					+ "VALUES(?, ?, ?, 'y', NOW(), NOW())";
			PreparedStatement insertStmt = conn.prepareStatement(insertSql);
	        insertStmt.setInt(1, cart.getProductNo());
	        insertStmt.setString(2, cart.getId());
	        insertStmt.setInt(3, cart.getCartCnt());
	        row = insertStmt.executeUpdate();
		}
		return row;
	}
	
	// 1.장바구니 상품 목록
	public ArrayList<HashMap<String, Object>> cartList(String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT c.product_no 상품번호, "
				+ "c.cart_no 장바구니번호, "
				+ "i.product_save_filename 상품이미지, "
				+ "c.id 아이디, "
				+ "p.product_name 상품이름, "
				+ "p.product_price 상품가격, "
				+ "p.product_price - (p.product_price * (1- IFNULL(d.discount_rate, 0))) 할인금액, "
				+ "p.product_price*(1-IFNULL(d.discount_rate, 0)) 할인상품가격, "
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
			c.put("할인금액",rs.getInt("할인금액"));
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
				+ "SET cart_cnt = ?, updatedate = NOW() "
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
				+ "SET checked = ?, updatedate = NOW() "
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
		String sql = "SELECT p.product_no 상품번호 , p.product_name 상품이름, c.cart_cnt 수량 "
				+ "FROM cart c "
				+ "INNER JOIN product p ON c.product_no = p.product_no "
				+ "INNER JOIN customer m ON c.id = m.id "
				+ "WHERE m.id = ? AND c.checked = 'y' ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> list = new ArrayList<>(); 
		while(rs.next()) {
			HashMap<String, Object> c = new HashMap<>();
			c.put("상품번호", rs.getInt("상품번호"));
			c.put("상품이름", rs.getString("상품이름"));
			c.put("수량", rs.getInt("수량"));
			list.add(c);
		}
		return list;
	}
	
	// 7. 구매자정보, 받는사람정보, 결제정보 조회
	public ArrayList<HashMap<String, Object>> cartOrderList(String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT m.id 아이디, "
				+ "m.cstm_name 이름, "
				+ "m.cstm_email 이메일, "
				+ "m.cstm_phone 휴대폰번호, "
				+ "m.cstm_address 배송주소, "
				+ "m.cstm_point 보유포인트, "
				+ "SUM(c.cart_cnt) 총상품개수, "
				+ "SUM(p.product_price * c.cart_cnt) 총상품가격, "
				+ "SUM(p.product_price * (1 - IFNULL(d.discount_rate, 0)) * c.cart_cnt) 할인적용금액, "
				+ "SUM(p.product_price * c.cart_cnt) - SUM(p.product_price * (1- IFNULL(d.discount_rate, 0))*c.cart_cnt) 할인금액, "
				+ "SUM(p.product_price * (1- IFNULL(d.discount_rate, 0))*c.cart_cnt) 전체금액 "
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
			c.put("총상품개수", rs.getInt("총상품개수"));
			c.put("총상품가격", rs.getInt("총상품가격"));
			c.put("할인적용금액", rs.getInt("할인적용금액"));
			c.put("할인금액", rs.getInt("할인금액"));
			c.put("전체금액", rs.getInt("전체금액"));
			list.add(c);
		}
		return list;
	}
	
	// 8. 보유 포인트 조회
	public int selectPoint(String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT cstm_point "
				+ "FROM customer "
				+ "WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		int point = 0;
		if(rs.next()) {
			point = rs.getInt("cstm_point");
		}
		return point;
	}
	
	// 9. 총결제금액
	public int totalPayment(int usePoint, String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT SUM(p.product_price * (1 - IFNULL(d.discount_rate, 0)) * c.cart_cnt) - ? 총결제금액 "
				+ "FROM cart c"
				+ "    LEFT OUTER JOIN product p ON c.product_no = p.product_no "
				+ "    LEFT OUTER JOIN customer m ON c.id = m.id "
				+ "    LEFT OUTER JOIN discount d ON p.product_no = d.product_no "
				+ "WHERE m.id = ? AND c.checked = 'y'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, usePoint);
		stmt.setString(2, id);
		ResultSet rs = stmt.executeQuery();
		int totalPay = 0;
		if(rs.next()) {
			totalPay = rs.getInt("총결제금액");
		}
		return totalPay;
	}
	
	// 10. 주소 내역 리스트 불러오기(최근 주소 3개만)
	public ArrayList<String> addressList(String id) throws Exception {
	    DBUtil dbutil = new DBUtil();
	    Connection conn = dbutil.getConnection();
	    String sql = "SELECT address "
	    		+ "FROM address "
	    		+ "WHERE id = ? "
	    		+ "ORDER BY address_no DESC LIMIT 3";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, id);
	    ResultSet rs = stmt.executeQuery();    
	    ArrayList<String> list = new ArrayList<>(); 
	    while(rs.next()) {
	        String address = rs.getString("address");
	        list.add(address);
	    }
	    return list;
	}
	
	// 11. 주소 내역 리스트에 주소 추가
	public int insertAddress(Address address) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "INSERT INTO address(id, address_name, address, address_last_date, createdate, updatedate) "
				+ "VALUES(?, ?, ?, NOW(), NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, address.getId());
		stmt.setString(2, address.getAddressName());
		stmt.setString(3, address.getAddress());
		int row = 0;
		row = stmt.executeUpdate();
		return row;
	}
	
	
	// 12. 장바구니에 선택한 상품 조회 ( SELECT ) + 장바구니에서 구매한 상품 오더테이블에 저장 ( INSERT )
	public int insertOrder(String id, int totalCartCnt, int totalPay, String selectAddress) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String selectSql = "SELECT COUNT(*) "
				+ "FROM cart "
				+ "WHERE id = ? AND checked = 'y' ";
		PreparedStatement selectStmt = conn.prepareStatement(selectSql);
		selectStmt.setString(1, id);
		ResultSet rs = selectStmt.executeQuery();
		int row = 0;
		if(rs.next()) {
			row = rs.getInt(1);
		}
		if(row>0) {
			String insertOrderSql = "INSERT INTO "
					+ "orders(id, payment_status, delivery_status, order_cnt, order_price, order_address, createdate, updatedate) "
					+ "VALUES( ?, '결제대기', '배송중', ?, ?, ?, NOW(), NOW()) ";
			PreparedStatement insertStmt = conn.prepareStatement(insertOrderSql);
			insertStmt.setString(1, id);
			insertStmt.setInt(2, totalCartCnt);
			insertStmt.setInt(3, totalPay);
			insertStmt.setString(4, selectAddress);
			row = insertStmt.executeUpdate();
		}
		return row;
	}
	
	// 13. 장바구니에서 아이디가 ?이고 체크가 Y인 여러개의 상품번호와 상품 수량 가져오기
	public ArrayList<Cart> selectCart(String id) throws Exception{
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT product_no, cart_cnt, id "
				+ "FROM cart "
				+ "WHERE id= ? AND checked = 'y' ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Cart> list = new ArrayList<>();
		while(rs.next()) {
			Cart c = new Cart();
			c.setProductNo(rs.getInt("product_no"));
			c.setCartCnt(rs.getInt("cart_cnt"));
			list.add(c);
		}
		return list;
	}
	
	// 14. orders_history에 저장하기 + 13번 사용(productNo, cartCnt)
	public ArrayList<Integer> insertOrdersHistory() throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String selectSql = "SELECT order_no, id "
				+ "FROM orders "
				+ "ORDER BY order_no DESC "
				+ "LIMIT 1 ";
		PreparedStatement selectStmt = conn.prepareStatement(selectSql);
		ResultSet selectRs = selectStmt.executeQuery();
		int selectOrderNo = 0;
		String selectOrderId = null;
		if(selectRs.next()) {
			// order_no와 id값 변수에 저장
			selectOrderNo = selectRs.getInt("order_no");
			selectOrderId = selectRs.getString("id");
		}
		// 13번 사용하여 productNo, cartCnt 값들 받아오기
		ArrayList<Cart> cartList = new ArrayList<>();
		cartList = selectCart(selectOrderId);
		ArrayList<Integer> InsertList = new ArrayList<>();
		String insertOrdersHistorySql ="INSERT INTO orders_history(id, order_no, product_no, order_cnt, createdate) "
							+ "VALUES(?, ?, ?, ?, NOW())";
		for (Cart c : cartList) {
			PreparedStatement insertOrdersHistoryStmt = conn.prepareStatement(insertOrdersHistorySql);
			insertOrdersHistoryStmt.setString(1, selectOrderId);
			insertOrdersHistoryStmt.setInt(2, selectOrderNo);
			insertOrdersHistoryStmt.setInt(3, c.getProductNo());
			insertOrdersHistoryStmt.setInt(4, c.getCartCnt());
			int row = insertOrdersHistoryStmt.executeUpdate();
			InsertList.add(row);
		}
		return InsertList;
	}
	
	// 15. 포인트 사용한 만큼 보유포인트에서 차감(-)
	public int customerPointMinus(int inputPoint, String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "UPDATE customer "
				+ "SET cstm_point = cstm_point - ?, updatedate = NOW() "
				+ "WHERE id = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, inputPoint);
		stmt.setString(2, id);
		int row = 0;
		row = stmt.executeUpdate();
		return row;
	}
	
	// 16. 총 결제금액의 1%만큼 포인트 적립(+)
	public int customerPointPlus(int totalPay, String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		
		String selectRankSql = "SELECT cstm_rank "
				+ "FROM customer "
				+ "WHERE id = ? ";
		PreparedStatement selectRankStmt = conn.prepareStatement(selectRankSql);
		selectRankStmt.setString(1, id);
		ResultSet selectRankRs = selectRankStmt.executeQuery();
		String rank = ""; // 회원 등급 저장을 위한 변수선언
		if(selectRankRs.next()) {
			rank = selectRankRs.getString("cstm_rank"); // 회원 등급을 변수에 저장
		}
		double rankPlusPoint = 0; // 등급별 적립 금액 차이를 위한 변수선언
		if(rank.equals("GOLD")) {
			rankPlusPoint = 0.001;
		}else if(rank.equals("SILVER")) {
			rankPlusPoint = 0.0001;
		}else {
			rankPlusPoint = 0.00001;
		}	
		String sql = "UPDATE customer "
				+ "SET cstm_point = cstm_point + ?*(0.01 + ?), updatedate = NOW() "
				+ "WHERE id = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, totalPay);
		stmt.setDouble(2, rankPlusPoint);
		stmt.setString(3, id);
		int row = 0;
		row = stmt.executeUpdate();
		return row;
		}
	
	// 17. 포인트 이력에 사용한 포인트(-) 저장
	public int pointHistoryMinus(int inputPoint) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String selectSql = "SELECT order_no "
				+ "FROM orders "
				+ "ORDER BY order_no DESC "
				+ "LIMIT 1 ";
		PreparedStatement selectStmt = conn.prepareStatement(selectSql);
		ResultSet selectRs = selectStmt.executeQuery();
		int selectOrderNo = 0;
		if(selectRs.next()) {
			// order_no 변수에 저장
			selectOrderNo = selectRs.getInt("order_no");
		}
		String sql="INSERT INTO "
				+ "point_history(order_no, point_pm, POINT, createdate) "
				+ "VALUES( ?, '-', ? , NOW()) ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, selectOrderNo);
		stmt.setInt(2, inputPoint);
		int row = 0;
		row = stmt.executeUpdate();
		return row;
	}
	
	// 18. 포인트 이력에 결제 후 적립된 포인트(+) 저장
	public int pointHistoryPlus(int totalPay, String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String selectRankSql = "SELECT cstm_rank "
				+ "FROM customer "
				+ "WHERE id = ? ";
		PreparedStatement selectRankStmt = conn.prepareStatement(selectRankSql);
		selectRankStmt.setString(1, id);
		ResultSet selectRankRs = selectRankStmt.executeQuery();
		String rank = ""; // 회원 등급 저장을 위한 변수선언
		if(selectRankRs.next()) {
			rank = selectRankRs.getString("cstm_rank"); // 회원 등급을 변수에 저장
		}
		double rankPlusPoint = 0; // 등급별 적립 금액 차이를 위한 변수선언
		if(rank.equals("GOLD")) {
			rankPlusPoint = 0.001;
		}else if(rank.equals("SILVER")) {
			rankPlusPoint = 0.0001;
		}else {
			rankPlusPoint = 0.00001;
		}
		String selectOrderSql = "SELECT order_no "
				+ "FROM orders "
				+ "ORDER BY order_no DESC "
				+ "LIMIT 1 ";
		PreparedStatement selectOrderStmt = conn.prepareStatement(selectOrderSql);
		ResultSet selectRs = selectOrderStmt.executeQuery();
		int selectOrderNo = 0;
		if(selectRs.next()) {
			// order_no 변수에 저장
			selectOrderNo = selectRs.getInt("order_no");
		}
		String sql="INSERT INTO "
				+ "point_history(order_no, point_pm, POINT, createdate) "
				+ "VALUES( ?, '+', ?*(0.01+?) , NOW()) ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, selectOrderNo);
		stmt.setInt(2, totalPay);
		stmt.setDouble(3, rankPlusPoint);
		int row = 0;
		row = stmt.executeUpdate();
		return row;
		
	}
	
	// 19. 장바구니에서 체크 된 상품 전체 삭제
	public int deleteCheckedCart(String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String deleteSql = "DELETE FROM cart "
				+ " WHERE checked = 'y' AND id = ? ";
		PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
		deleteStmt.setString(1, id);
		int row = 0;
		row = deleteStmt.executeUpdate();
		return row;
	}
	
	// 20. 결제 완료 상태로 변경
	public int updatePaymentStatus(String id) throws Exception {
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "UPDATE orders "
				+ "SET payment_status = '결제완료', updatedate = NOW() "
				+ "WHERE id = ? AND payment_status ='결제대기'"
				+ "ORDER BY order_no DESC "
				+ "LIMIT 1 ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		int row = 0;
		row = stmt.executeUpdate();
		return row;
	}
	
	
	// 21. 비회원 장바구니 리스트 조회
	public ArrayList<HashMap<String,Object>> notLoginSelectCart(int productNo, int cartCnt) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT "
				+ "p.product_no 상품번호, "
				+ "p.product_name 상품이름, "
				+ "p.product_price 상품가격, "
				+ "i.product_save_filename 상품이미지, "
				+ "p.product_price - (p.product_price * (1- IFNULL(d.discount_rate, 0))) 할인금액, "
				+ "p.product_price*(1-IFNULL(d.discount_rate, 0)) 할인상품가격, "
				+ "p.product_price*(1- IFNULL(d.discount_rate, 0)) * ? 전체가격 "
				+ "FROM product p "
				+ "		LEFT OUTER JOIN product_img i ON p.product_no = i.product_no "
				+ "		LEFT OUTER JOIN discount d ON p.product_no = d.product_no "
				+ "WHERE p.product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cartCnt);
		stmt.setInt(2, productNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("수량",cartCnt);
			m.put("상품번호",rs.getInt("상품번호"));
			m.put("상품이름",rs.getString("상품이름"));
			m.put("상품가격",rs.getInt("상품가격"));
			m.put("상품이미지",rs.getString("상품이미지"));
			m.put("할인금액",rs.getInt("할인금액"));
			m.put("할인상품가격",rs.getInt("할인상품가격"));
			m.put("전체가격",rs.getInt("전체가격"));
			list.add(m);
		}
		return list;
	}
	
	// 22. 비회원 장바구니 리스트 총 주문금액
	public ArrayList<HashMap<String,Object>> notLoginSelectCartTotal(int productNo, int cartCnt) throws Exception {
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		return list;
	}
	
	
	
	
	
}	