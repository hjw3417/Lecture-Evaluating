package com.java;

import java.util.Scanner;

public class StudentExample {

	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner sc= new Scanner(System.in);		
		StudentValidator2 studentvalidaotr = new StudentValidator2();
		
		System.out.print("학생 ID: " );
		String studentID = sc.nextLine();
		System.out.print("학생 Password: ");
		String studentPassword = sc.nextLine();
		StudentDTO studentDTO = studentvalidaotr.sendStudentInfo(studentID, studentPassword);
		System.out.println(studentDTO.getStudentID() + " " + studentDTO.getStudentPassword());
		studentvalidaotr.checkStudentInfo(studentDTO);
		studentvalidaotr.checkStudentTraining(studentDTO);
		
	}

}
