package com.java;




public class StudentValidator implements StudentAvailable {
	
		StudentDB studentDB = new StudentDB();
		
		//id, password 를 전달 받아서 StudentDTO 객체를 생성하여 반화합니다. 
		//(StudentAvailable 의 1번 문제의 전달 인자는 모두 문자)
		@Override
		public StudentDTO sendStudentInfo(String studentID, String studentPassword) {
			StudentDTO studentDTO = new StudentDTO(studentID, studentPassword);
			return studentDTO;
		}
		
//		StudentDTO 를 전달 받아서 DB 에 있는 아이디와 비밀번호와 비교하여 정상 여부를 반화합니다 
//		(StudentAvailable 의 2번 전달인자 StudentDTO, 반환값 boolean (일치/불일치)
		@Override
		public boolean checkStudentInfo(StudentDTO studentDTO) {

			boolean result = false;
			if(studentDTO.getStudentID().equals(studentDB.getStudentID()) && studentDTO.getStudentPassword().equals(studentDB.getStudentPassword())) 
				result = true;
			return result;
		}
		
//		StudentDTO 를 전달받아서 DB 에 있는 학생정보의 훈련여부에 따라 유효성 여부를 반환합니다
//		( StudentAvailable 의 3번 전달일자 StudentDTO, 반환값 boolean(유효/비유효)
		@Override
		public boolean checkStudentTraining(StudentDTO studentDTO) {
			return studentDB.isTrainningStatus();
		}
		
//		StudentDTO 를 전달 받아서 로그인 정보 일치여부와 유효성 여부를 모든 확인 하 후, 
//		결과 코드와 결과 메세지를 담은 최종 ResposeDTO 를 반환합니다 
//		(전달인자 StudentDTO, 반환값 ResposeDTO)
		@Override
		public ResponseDTO checkAllStudentStatus(StudentDTO studentDTO) {
			ResponseDTO responseDTO = new ResponseDTO();
			if(this.checkStudentInfo(studentDTO)) {
				responseDTO.setResponseResultCode("0");
				responseDTO.setResponseResultMsg("로그인 허용");
				if(studentDB.isTrainningStatus()) {
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
			return responseDTO;
		}
}
