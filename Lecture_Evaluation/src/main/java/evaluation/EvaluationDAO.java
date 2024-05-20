package evaluation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EvaluationDAO {
	//jdbc mysql 접속
	
	//필드 부
	private Connection conn = null;
	private ResultSet rs = null;
	
	//접속 생성자
	public EvaluationDAO()  {
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
	
	//평가 정보를 입력 받아 db evaluation 테이블에 저장 메소드
	public int write(EvaluationDTO evaluationDTO) {
		
		PreparedStatement pstmt = null;
		
		try {
			String SQL = "INSERT INTO evaluation ("
					+ "evaluationID, userID, lectureName, professorName, lectureYear, semesterDivide, lectureDivide, "
					+ "evaluationTitle, evaluationContent, totalScore, creditScore, comfortableScore,  lectureScore, likeCount) "
					+ "VALUES(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
					
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  evaluationDTO.getUserID());
			pstmt.setString(2,  evaluationDTO.getLectureName());
			pstmt.setString(3,  evaluationDTO.getProfessorName());
			pstmt.setInt(4,  evaluationDTO.getLectureYear());
			pstmt.setString(5,  evaluationDTO.getSemesterDivide());
			pstmt.setString(6,  evaluationDTO.getLectureDivide());
			pstmt.setString(7,  evaluationDTO.getEvaluationTitle());
			pstmt.setString(8,  evaluationDTO.getEvaluationContent());
			pstmt.setString(9,  evaluationDTO.getTotalScore());
			pstmt.setString(10,  evaluationDTO.getCreditScore());
			pstmt.setString(11,  evaluationDTO.getComfortableScore());
			pstmt.setString(12,  evaluationDTO.getLectureScore());
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		
		return -1;
	}
	
	public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber) {
		if(lectureDivide.equals("전체")) {
			lectureDivide = "";
		}
		
		ArrayList<EvaluationDTO> evaluationList = null;
		PreparedStatement pstmt = null;
		String SQL = "";
		
		try {
			if(searchType.equals("최신순")) {
				SQL = "SELECT * FROM EVALUATION WHERE lectureDivide like ? AND "
						+ "concat(lectureName, professorName, evaluationTitle, evaluationContent) like ? "
						+ "ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6; 
			} else if(searchType.equals("추천순")) {
				SQL = "SELECT * FROM EVALUATION WHERE lectureDivide like ? AND "
						+ "concat(lectureName, professorName, evaluationTitle, evaluationContent) like ? "
						+ "ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6; 
			}
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  "%" + lectureDivide + "%");
			pstmt.setString(2,  "%" + search + "%");
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			while(rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14)				
						);
				evaluationList.add(evaluation);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return evaluationList;
	}
	
	public int like(String evaluationID) {
		PreparedStatement pstmt = null;
		try {
			String SQL = "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("like() 오류");
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public int delete(String evaluationID) {
		PreparedStatement pstmt = null;
		try {
			String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete() 오류");
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public String getUserID(String evaluationID) {
		PreparedStatement pstmt = null;
		try {
			String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  Integer.parseInt(evaluationID));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("getUserID() 오류");
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
