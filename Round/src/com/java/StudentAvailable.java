package com.java;

public interface StudentAvailable {
	
	//학생아이디, 비밀번호 를 전달받아 StudentDTO 에 담아서 반환합니다
	public StudentDTO sendStudentInfo(String userID, String userPasswrod);
	
	//정보가 담긴 StudentDTO 를 전달받아 DB 에 저장된 정보와 일치하는지 확인합니다
	public boolean checkStudentInfo(StudentDTO studentDTO);
	
	//정보가 담긴 StudentDTO 를 전달받아 해당 학생의 현재 훈련여부를 
	//기준으로 판단하여 유효한 상태인지 확인합니다
	public boolean checkStudentTraining(StudentDTO studentDTO);
	
	//정보가 담긴 StudentDTO  를 인자로 받아 위 모든 상태를 확인 한 후, 
	//결과를 담은 ResponseDTO 를 생성하여 반환합니다
	public ResponseDTO checkAllStudentStatus(StudentDTO studentDTO);
}
