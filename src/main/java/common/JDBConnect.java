package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletContext;

// DB연결을 위한 클래스 생성
public class JDBConnect {
	
	// 멤버변수 : DB연결, 쿼리문 실행 및 전송, 결과셋 반환
    public Connection con;
    public Statement stmt;  
    public PreparedStatement psmt;  
    public ResultSet rs;
    
    // 기본생성자 : 매개변수가 없는 생성자
    public JDBConnect() {
        try {
        	// 오라클 드라이버 로드
            Class.forName("oracle.jdbc.OracleDriver");
            // 커넥션URL, 계정 아이디와 패스워드
            String url = "jdbc:oracle:thin:@localhost:1521:xe";  
            String id = "sua_project";
            String pwd = "1234"; 
            // 오라클 DB 연결
            con = DriverManager.getConnection(url, id, pwd); 
            // 연결 성공시 콘솔에서 로그 확인
            System.out.println("DB 연결 성공(기본 생성자)");
        }
        catch (Exception e) {            
            e.printStackTrace();
        }
    }
        
    //자원반납
    public void close() { 
        try {
            if (rs != null) rs.close(); 
            if (stmt != null) stmt.close();
            if (psmt != null) psmt.close();
            if (con != null) con.close(); 

            System.out.println("JDBC 자원 해제");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}