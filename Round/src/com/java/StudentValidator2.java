package com.java;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class StudentValidator2 implements StudentAvailable {


		private Connection conn;

		public StudentValidator2() {
			try {
				//JDBC Driver 등록
				Class.forName("oracle.jdbc.OracleDriver");
				
				//연결하기
				conn = DriverManager.getConnection(
						"jdbc:oracle:thin:@localhost:1521/xe",
						"c##practiceaccount",
						"wlsdnr"
						);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		//id, password 를 전달 받아서 StudentDTO 객체를 생성하여 반화합니다. 
		//(StudentAvailable 의 1번 문제의 전달 인자는 모두 문자)
		@Override
		public StudentDTO sendStudentInfo(String studentID, String studentPassword) {
			StudentDTO studentDTO = new StudentDTO(studentID, studentPassword);
			System.out.println("userID: " + studentDTO.getStudentID() + " studentPW: " + studentDTO.getStudentPassword());
			return studentDTO;
		}
		
//		StudentDTO 를 전달 받아서 DB 에 있는 아이디와 비밀번호와 비교하여 정상 여부를 반화합니다 
//		(StudentAvailable 의 2번 전달인자 StudentDTO, 반환값 boolean (일치/불일치)
		@Override
		public boolean checkStudentInfo(StudentDTO studentDTO) {
			
			String sql = "" +
					"SELECT studentID, studentPassword, trainningStatus FROM student WHERE studentID=?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			boolean result = false;
			String studentID = null;
			String studentPassword = null;
			try {
				System.out.println("pstmt에 넣는 정보: " + studentDTO.getStudentID());
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, studentDTO.getStudentID());
				rs = pstmt.executeQuery();
				System.out.println(sql);
				if(rs.next()) {
					studentID = rs.getString("studentID");
					studentPassword = rs.getString("studentPassword");
					System.out.println(studentID + " " + studentPassword);
					if(studentDTO.getStudentID().equals(studentID) && studentDTO.getStudentPassword().equals(studentPassword)) {
						result = true;
					}
				}
				System.out.println(studentID + " " + studentPassword);
				System.out.println("ID, PW 일치 여부: " + result);
			} catch (Exception e) {
				System.out.println("checkStudentInfo");
				e.printStackTrace();
			} finally {
				try {
					if(rs!=null) {
						rs.close();
						if(pstmt!=null) {
							pstmt.close();
						}
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					
				}
			}
			
			return result;
			
		}
		
//		StudentDTO 를 전달받아서 DB 에 있는 학생정보의 훈련여부에 따라 유효성 여부를 반환합니다
//		( StudentAvailable 의 3번 전달일자 StudentDTO, 반환값 boolean(유효/비유효)
		@Override
		public boolean checkStudentTraining(StudentDTO studentDTO) {
			String sql = "" +
					"SELECT studentID, studentPassword, trainningStatus " +
					"FROM student " +
					"WHERE studentID=?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			boolean result = false;
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,  studentDTO.getStudentID());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					if(rs.getInt("trainningStatus") == 1) {
						result = true;
					}
				}
				System.out.println("trainningStatus: " + result);
				
			} catch (Exception e) {
				System.out.println("checkStudentTraining");
				e.printStackTrace();
			} finally {
				try {
					if(rs!=null) {
						rs.close();
						if(pstmt!=null) {
							pstmt.close();
						}
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					
				}
			}
			
			return result;
		}
		
//		StudentDTO 를 전달 받아서 로그인 정보 일치여부와 유효성 여부를 모든 확인 하 후, 
//		결과 코드와 결과 메세지를 담은 최종 ResposeDTO 를 반환합니다 
//		(전달인자 StudentDTO, 반환값 ResposeDTO)
		@Override
		public ResponseDTO checkAllStudentStatus(StudentDTO studentDTO) {
			ResponseDTO responseDTO = new ResponseDTO();
			String sql = "" +
					"SELECT studentID, studentPassword, trainningStatus " +
					"FROM student " +
					"WHERE studentID=?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			boolean result = false;
			try {
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,  studentDTO.getStudentID());
				rs = pstmt.executeQuery();
				
				if(this.checkStudentInfo(studentDTO)) {
					responseDTO.setResponseResultCode("0");
					responseDTO.setResponseResultMsg("로그인 허용");
					if(rs.getBoolean("trainningStatus")) {
						responseDTO.setResponseResultCode("1");
						responseDTO.setResponseResultMsg("훈련 중");
					} else {
						responseDTO.setResponseResultCode("2");
						responseDTO.setResponseResultMsg("훈련 종료");
					}
				} else {
					responseDTO.setResponseResultCode("3");
					responseDTO.setResponseResultMsg("로그인 정보 불일치");
				}
				
			} catch (Exception e) {
				System.out.println("checkStudentTraining");
				e.printStackTrace();
			} finally {
				try {
					if(rs!=null) {
						rs.close();
						if(pstmt!=null) {
							pstmt.close();
						}
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					
				}
			}
			System.out.println("responseDTO: " + responseDTO);
			return responseDTO;
		}
		}

