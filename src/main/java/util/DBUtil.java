package util;

import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception {
		String driver="org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://127.0.0.1:3306/shopping";
		String dbId = "root"; 
		String dbPw = "java1234";
		Class.forName(driver);
		Connection conn = null;
		conn = DriverManager.getConnection(dbUrl,dbId, dbPw);
		return conn;
	}
}
