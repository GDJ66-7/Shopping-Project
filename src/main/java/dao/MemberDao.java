package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.spi.DirStateFactory.Result;

import org.mariadb.jdbc.export.Prepare;

import util.DBUtil;
import vo.Customer;
import vo.IdList;
import vo.Notice;

public class MemberDao {
	// 1) 로그인
	public int login(IdList id) throws Exception {
		int row = 0;
		// 아이디 활성화여부
		String active = "";
		
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT count(*) FROM id_list WHERE id = ? AND pw = PASSWORD(?) AND active = 'y'");
		stmt.setString(1, id.getId());
		stmt.setString(2, id.getPw());
		ResultSet loginRs = stmt.executeQuery();
		if(loginRs.next()) {
			row=loginRs.getInt(1);
		}
		if(row > 0) {
			PreparedStatement csLoginStmt = conn.prepareStatement("UPDATE customer set cstm_last_login = now() WHERE id = ?");
			csLoginStmt.setString(1, id.getId());
			int upRow = csLoginStmt.executeUpdate();
			if(upRow > 0) {
				System.out.println("고객이므로 마지막로그인 일자 업데이트 완료");
			}else if(upRow == 0) {
				System.out.println("관리자이므로 마지막로그인 일자 업데이트 안함");
			}
		} else if(row == 0) {
			PreparedStatement falStmt = conn.prepareStatement("SELECT count(*) FROM id_list WHERE id = ? AND pw = PASSWORD(?) AND active = 'n'");
			falStmt.setString(1, id.getId());
			falStmt.setString(2, id.getPw());
			ResultSet rs = falStmt.executeQuery();
			if(rs.next()) {
				row = 3;
			}
		}
		return row;
	}
	// 1-1 고객아이디 확인
	public int loginCstmId(IdList idList) throws Exception {
		int cnt = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM customer WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, idList.getId());
		System.out.println(stmt+"<-- 고객아이디 확인하는 STMT");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		return cnt;
	}
	// 1-2 사원아이디인지 확인
	public int loginEmpId(IdList idList) throws Exception {
		int empCnt = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM employees WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, idList.getId());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			empCnt = rs.getInt(1);
			System.out.println(empCnt+"<-- 1이상이면 사원아이디");
		}
		return empCnt;
	}
	// 1-2 사원중에 관리자인지 확인
	public String loginEmpLevel(IdList idList) throws Exception{
		String level = "";
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM employees WHERE id = ? AND emp_level = '2'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, idList.getId());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		if(row > 0) {
			level = "2";
			System.out.println("최고관리자로그인");
		} else if(row == 0) {
			String sql2 = "select count(*) FROM employees WHERE id = ? AND emp_level = '1'";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, idList.getId());
			ResultSet rs2 = stmt2.executeQuery();
			if(rs2.next()) {
				row = rs2.getInt(1);
			}
			if(row > 0) {
				level = "1";
				System.out.println("일반관리자로그인");
			}
		}
		
		return level;
	}
	
	// 2) 회원가입시 id테이블에 데이터값 넣기
	public int insertId(IdList idList) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// id 중복체크
		String checkIdSql = "SELECT count(*) FROM id_list WHERE id = ?";
		//id테이블 데이터값 입력쿼리
		String idSql = "INSERT INTO id_list(id, pw, active, createdate, updatedate) values(?, PASSWORD(?), 'y', now(), now())";
		// 비밀번호 이력 테이블에 데이터값 입력 쿼리
		String pwSql = "INSERT INTO pw_history(id, pw, createdate) values(?,PASSWORD(?),now())";
		
		//id중복체크
		PreparedStatement checkStmt = conn.prepareStatement(checkIdSql);
			checkStmt.setString(1, idList.getId());
			ResultSet rs = checkStmt.executeQuery();
			int row3 = 0;
			if(rs.next()) {
				row3 = rs.getInt(1);
			}
			//id중복체크를 통해 row3값이 0이면 중복이 아니므로 테이블에 값넣기
			// row3이 1이상이면 이미 있는 아이디이므로 row 값을 3을 저장하여 리턴하여 Action에서 분기시키도록 하기
			if(row3 == 0) {
		// id테이블 벨류값 넣기
		PreparedStatement  idStmt = conn.prepareStatement(idSql);
			idStmt.setString(1, idList.getId());
			idStmt.setString(2, idList.getPw());
			 int row1 = idStmt.executeUpdate();
			 System.out.println(row1+"<-- row1");
			
		PreparedStatement pwStmt = conn.prepareStatement(pwSql);
			pwStmt.setString(1, idList.getId());
			pwStmt.setString(2, idList.getPw());
			int row2 = pwStmt.executeUpdate();
			System.out.println(row2+"<-- row2");
			
			if(row1 > 0 && row2 > 0) {
				row = 1;
				}
			}
			if(row3 > 0) {
				row = 3;
			}
		return row;
	}
	
	// 3) 회원가입시 고객테이블에 데이터 값 넣기
	public int insertCustomer(Customer customer) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		
		// 고객 테이블 데이터 값 입력 쿼리
		String customerSql = "INSERT INTO customer(id, cstm_name, cstm_address, cstm_email, cstm_birth, cstm_phone, cstm_gender, cstm_rank, cstm_point,cstm_last_login, cstm_agree, cstm_question,createdate, updatedate) values(?,?,?,?,?,?,?,'BRONZE',0,now(),?,?,now(),now())";
		
		PreparedStatement customerStmt = conn.prepareStatement(customerSql);
		customerStmt.setString(1, customer.getId());
		customerStmt.setString(2, customer.getCstmName());
		customerStmt.setString(3, customer.getCstmAddress());
		customerStmt.setString(4, customer.getCstmEmail());
		customerStmt.setString(5, customer.getCstmBirth());
		customerStmt.setString(6, customer.getCstmPhone());
		customerStmt.setString(7, customer.getCstmGender());
		customerStmt.setString(8, customer.getCstmAgree());
		customerStmt.setString(9, customer.getCstmQuestion());
		row = customerStmt.executeUpdate();
		return row;
	}
	// 4) 회원 개인정보 수정(비밀번호 수정아님)
	public int modifyCustomer(Customer customer) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// 고객 테이블 데이터값 수정 쿼리
		String customerSql = "UPDATE customer SET cstm_address = ?, cstm_email = ?, cstm_phone = ?, updatedate = now() WHERE id = ? ";
		PreparedStatement stmt = conn.prepareStatement(customerSql);
		stmt.setString(1, customer.getCstmAddress());
		stmt.setString(2, customer.getCstmEmail());
		stmt.setString(3, customer.getCstmPhone());
		stmt.setString(4, customer.getId());
		row = stmt.executeUpdate();
		
		return row;
	}
	// 4-1) 회원 주소 수정
	public int modifyAddress(String address, String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "UPDATE customer SET cstm_address = ?, updatadate = now() WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, address);
		stmt.setString(2, id);
		row = stmt.executeUpdate();
		return row;
	}
	// 4-2) 회원 메일 수정
		public int modifyEmail(String email, String id) throws Exception {
			int row = 0;
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "UPDATE customer SET cstm_email = ?, updatadate = now() WHERE id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);
			stmt.setString(2, id);
			row = stmt.executeUpdate();
			return row;
		}
	// 4-3) 회원 주소 수정
			public int modifyPhone(String phone, String id) throws Exception {
				int row = 0;
				DBUtil dbUtil = new DBUtil(); 
				Connection conn =  dbUtil.getConnection();
				String sql = "UPDATE customer SET cstm_phone = ?, updatadate = now() WHERE id = ?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, phone);
				stmt.setString(2, id);
				row = stmt.executeUpdate();
				return row;
			}
	// 5 회원 비밀번호 변경시 이전 사용한 비밀번호인지 체크하기
	public int checkPwList(IdList idList) throws Exception {
		int pwCheckRow = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM pw_history WHERE id = ? AND pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, idList.getId());
		stmt.setString(2, idList.getPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			pwCheckRow = rs.getInt(1);
		}
		return pwCheckRow;
	}
	// 6) 회원 비밀번호 변경
	public int modifyIdList(IdList idList) throws Exception {
		//아이디 쿼리 실행값 변수
		int idListRow = 0;
		// 비밀번호 이력 쿼리 실행값
		int pwHistoryRow = 0;
		// 비밀번호 이력 갯수
		int cnt = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// 비밀번호 id_list 테이블에 입력
		String sql = "UPDATE id_list SET pw = PASSWORD(?), updatedate = now() WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, idList.getPw());
		stmt.setString(2, idList.getId());
		idListRow = stmt.executeUpdate();
		// 비밀번호 이력 데이터값 추가
		String pwHistortSql = "INSERT INTO pw_history(id, pw, createdate) values(?,PASSWORD(?),now())";
		PreparedStatement pwHistoryStmt = conn.prepareStatement(pwHistortSql);
		pwHistoryStmt.setString(1, idList.getId());
		pwHistoryStmt.setString(2, idList.getPw());
		pwHistoryRow = pwHistoryStmt.executeUpdate();
		// 비밀번호 이력 데이터값 갯수 새기
		String cntSql = "  SELECT count(*) FROM pw_history WHERE id = ?";
		PreparedStatement cntStmt = conn.prepareStatement(cntSql);
		cntStmt.setString(1, idList.getId());
		ResultSet rs = cntStmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		if(cnt > 3) {
		// 비밀번호 이력 3개 이상이면 삭제
		String historyDelSql = "DELETE FROM pw_history WHERE id = ? AND createdate = (SELECT MIN(createdate) FROM pw_history WHERE id = ?)";
		PreparedStatement historyDelStmt = conn.prepareStatement(historyDelSql);
		historyDelStmt.setString(1, idList.getId());
		historyDelStmt.setString(2, idList.getId());
		int pwHistoryDeleteRow = historyDelStmt.executeUpdate();
		System.out.println(pwHistoryDeleteRow+"<--pwHistoryDeleteRow 비밀번호 이력이 3개 이상이므로 삭제 제일 오래된 비밀번호 삭제완료");
		}
		return idListRow;
	}
	//비밀번호 맞는지 확인
	public int checkPw(IdList onePw) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM id_list WHERE id = ? AND pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, onePw.getId());
		stmt.setString(2, onePw.getPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}	
		System.out.println(row+"<--row");
		return row;
	}
	//회원 탈퇴
	public int deleteCustomer(String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "UPDATE id_list SET active = 'n', updatedate = now() WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		row = stmt.executeUpdate();
		return row;
	}
	

	// 고객 마이페이지
	public ArrayList<HashMap<String, Object>> selectCstmList(String id) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT cstm_name 고객이름, cstm_address 고객주소, cstm_email 고객이메일, cstm_birth 고객생일, cstm_phone 고객번호, cstm_rank 고객등급,cstm_point 고객포인트, createdate 가입일 FROM customer WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("고객이름", rs.getString("고객이름"));
			m.put("고객주소", rs.getString("고객주소"));
			m.put("고객이메일", rs.getString("고객이메일"));
			m.put("고객생일", rs.getString("고객생일"));
			m.put("고객번호", rs.getString("고객번호"));
			m.put("고객등급", rs.getString("고객등급"));
			m.put("고객포인트", rs.getInt("고객포인트"));
			m.put("가입일", rs.getString("가입일"));
			list.add(m);
			
		}
		return list;
	}
	// 고객 아이디 찾기
	public String fineId(Customer customer) throws Exception {
		String findId = "";
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT id FROM customer WHERE cstm_name = ? AND cstm_birth = ? AND cstm_phone = ? AND cstm_question = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCstmName());
		stmt.setString(2, customer.getCstmBirth());
		stmt.setString(3, customer.getCstmPhone());
		stmt.setString(4, customer.getCstmQuestion());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			findId = rs.getString("id");
		}
		return findId;
	}
	//비밀번호 변경 전 체크
	public int findPwCheck(Customer customer) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM customer WHERE id = ? AND cstm_name = ? AND cstm_birth = ? AND cstm_phone = ? AND cstm_question = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getId());
		stmt.setString(2, customer.getCstmName());
		stmt.setString(3, customer.getCstmBirth());
		stmt.setString(4, customer.getCstmPhone());
		stmt.setString(5, customer.getCstmQuestion());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("count(*)");
		}
		return row;
	}
	//아이디 중복체크
	public int checkId(String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM id_list WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("count(*)");
		}
			return row;
		
		
	}
	//카카오톡 로그인시체크
	public int checkIdkakao(String id) throws Exception {
		int row = 0;
		String idAct = "";
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM id_list WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("count(*)");
		}
		if(row == 0) {
			return row;
		} else if(row > 0){
			PreparedStatement checkStmt = conn.prepareStatement("SELECT active FROM id_list WHERE id = ?");
			checkStmt.setString(1, id);
			ResultSet checkRs = checkStmt.executeQuery();
			if(checkRs.next()) {
				idAct = checkRs.getString("active");
			}
			System.out.println(idAct+"<-- kakaoCheck");
			if(idAct.equals("y")) {
				//로그인일자 업데이트
				PreparedStatement csLoginStmt = conn.prepareStatement("UPDATE customer set cstm_last_login = now() WHERE id = ?");
				csLoginStmt.setString(1, id);
				row = csLoginStmt.executeUpdate();
				
			} else if(idAct.equals("n")) {
				row = 3;
			}
		}
		System.out.println(row +"카카오톡 로그인row");
		return row;
	}
	
}
