package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
	//jdbc mysql 접속
	
	//필드 부
	private Connection conn = null;
	private ResultSet rs = null;
	
	//접속 생성자
	public UserDAO()  {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("UserDAO 접속");
		}
	}
	
	//로그인 메소드
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;	//로그인 성공
				} else {
					return 0;	//로그인 실패
				}
			}
			return -1;	//아이디 없음
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("login()");
		}	
		return -2;	//데이터 베이스 오류
	}
	
	//회원가입 메소드
	public int join(UserDTO userDTO) {
System.out.println(userDTO.getUserID() + userDTO.getUserPassword() + userDTO.getUserEmail() + userDTO.getUserEmailHash());
		String SQL = "INSERT INTO user (userID, userPassword, userEmail, userEmailHash, userEmailChecked) VALUES (?, ?, ?, ?, false)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userDTO.getUserID());
			pstmt.setString(2,  userDTO.getUserPassword());
			pstmt.setString(3,  userDTO.getUserEmail());
			pstmt.setString(4,  userDTO.getUserEmailHash());
			return pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("join()");
		}
		return -1;	//회원가입 실패
	}
	
	//이베일 주소 반환 메소드
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM USER WHERE userID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1);		//이메일 주소 반환
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("getUserEmail()");
		}
		return null;		//데이터 베이스 오류
	}
	
	//이메일 등록 여부 반환 메소드
	public boolean getUserEmailChecked(String userID) {
		System.out.println(userID);
		String SQL = "SELECT userEmailChecked FROM user WHERE userID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getBoolean(1);	//이메일 등록 여부 반환
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("getUserEmailChecked()");
		}
		return false;		//이메일 등록 설정 성공 실패
	}	
	
	//이메일 확인 변경 메소드
	public boolean setUserEmailChecked(String userID) {
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;		//이메일 등록 설정 성공
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("getUserEmailChecked()");
		}
		return false;		//이메일 등록 설정 성공 실패
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
