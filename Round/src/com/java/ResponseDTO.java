package com.java;

public class ResponseDTO {
	//field
	private String responseResultCode;	//로그인 응답 결과 코드
	private String responseResultMsg;	//로그인 응답 결과 메시지

	//constructor
	
	
	public ResponseDTO(String responseResultCode, String responseResultMsg) {
		this.responseResultCode = responseResultCode;
		this.responseResultMsg = responseResultMsg;
	}

	public ResponseDTO() {
	}
	
	//method
	public String getResponseResultCode() {
		return responseResultCode;
	}

	public void setResponseResultCode(String responseResultCode) {
		this.responseResultCode = responseResultCode;
	}

	public String getResponseResultMsg() {
		return responseResultMsg;
	}

	public void setResponseResultMsg(String responseResultMsg) {
		this.responseResultMsg = responseResultMsg;
	}
	

}
