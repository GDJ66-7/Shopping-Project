package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import org.mariadb.jdbc.export.Prepare;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	
		// 공지사항 검색 리스트 출력
			public ArrayList<HashMap<String, Object>> selectNoticeList(int beginRow, int rowPerPage, String search) throws Exception{
				ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
				DBUtil dbUtil = new DBUtil(); 
				Connection conn =  dbUtil.getConnection();
				String sql = "SELECT notice_no 번호, notice_title 타이틀, notice_content 내용, createdate 작성일, updatedate 수정일 FROM notice";
				//검색했을때
				if(!search.equals("")) {
					sql += " WHERE notice_title LIKE '%"+search+"%'";
				}
				sql += " LIMIT ? , ?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
				ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
					HashMap<String, Object> m = new HashMap<String, Object>();
					m.put("번호", rs.getInt("번호"));
					m.put("타이틀", rs.getString("타이틀"));
					m.put("내용", rs.getString("내용"));
					m.put("작성일", rs.getString("작성일"));
					m.put("수정일", rs.getString("수정일"));
					list.add(m);
				}
				return list;
			}
		// 공지사항 검색했을때의 총 행의 수
			public int selectNoticeRow(String search) throws Exception {
				int row = 0;
				DBUtil dbUtil = new DBUtil(); 
				Connection conn =  dbUtil.getConnection();
				String sql = "SELECT count(*) FROM notice";
				//검색했을때
				if(!search.equals("")) {
					sql += " WHERE notice_title LIKE '%"+search+"%'";
				}
				PreparedStatement stmt = conn.prepareStatement(sql);
				ResultSet rs = stmt.executeQuery();
				if(rs.next()) {
					row = rs.getInt("count(*)");
				}
				return row;
			}
		// 공지사항 추가
		public int insertNotice(Notice notice) throws Exception {
			int row = 0;
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "INSERT INTO notice(notice_title, notice_content, createdate, updatedate) VALUES(?,?,now(),now())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeContent());
			row = stmt.executeUpdate();
			return row;
		}
		// 공지사항 수정
		public int modifyNotice(Notice notice) throws Exception{
			int row = 0;
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "UPDATE notice SET notice_title = ?, notice_content = ?, updatedate = now() WHERE notice_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeContent());
			stmt.setInt(3, notice.getNoticeNo());
			row = stmt.executeUpdate();
			return row;
		}
		// 공지사항 삭제 
		public int removeNotice(int noticeNo) throws Exception {
			int row = 0;
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "DELETE FROM notice WHERE notice_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			row = stmt.executeUpdate();
			return row;
		}
		// 공지사항 상세보기
		public ArrayList<HashMap<String, Object>> noticeOne(int noticeNo) throws Exception {
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			String sql = "SELECT notice_no 번호, notice_title 제목, notice_content 내용, updatedate 수정일, createdate 작성일 FROM notice WHERE notice_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("번호", rs.getInt("번호"));
				m.put("제목", rs.getString("제목"));
				m.put("내용", rs.getString("내용"));
				m.put("수정일", rs.getString("수정일"));
				m.put("작성일", rs.getString("작성일"));
				list.add(m);
			}
			return list;
		}
			
}
