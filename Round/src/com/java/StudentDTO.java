package com.java;

public class StudentDTO {
	
	//field
	private String studentID;	//학생아이디
	private String studentPassword;	//학생비밀번호
	private boolean trainningStatus;
	
	//constructor
	
	
	public StudentDTO() {
		
	}
	
	public StudentDTO(String studentID, String studentPassword, boolean trainningStatus) {
		this.studentID = studentID;
		this.studentPassword = studentPassword;
		this.trainningStatus = trainningStatus;
	}
	public StudentDTO(String studentID, String studentPassword) {
		this.studentID = studentID;
		this.studentPassword = studentPassword;
	}

	

	//method
	public String getStudentID() {
		return studentID;
	}
	public void setStudentID(String studentID) {
		this.studentID = studentID;
	}
	public String getStudentPassword() {
		return studentPassword;
	}
	public void setStudentPassword(String studentPassword) {
		this.studentPassword = studentPassword;
	}
	
	public boolean isTrainningStatus() {
		return trainningStatus;
	}

	public void setTrainningStatus(boolean trainningStatus) {
		this.trainningStatus = trainningStatus;
	}
}
