<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="likey.LikeyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%!
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if(ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

%>

<%

	//요청 정보를 한글로 인코딩
	request.setCharacterEncoding("UTF-8");
	
	//회원 가입 정보 초기화
	String userID = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	//evaluationID를 parameter로 저장
	String evaluationID = null;
	if(request.getParameter("evaluationID") != null) {
		evaluationID = (String) request.getParameter("evaluationID");
	}
	
	//like()메소드의 결과 정보를 result에 저장
	LikeyDAO likeyDAO = new LikeyDAO();
	int result = likeyDAO.like(userID, evaluationID, getClientIP(request));
	
	
	//삭제 로직 실행
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	if(result == 1) {
		result = evaluationDAO.like(evaluationID);
			if(result == 1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('추천이 완료되었습니다.')");
				script.println("location.href = 'index.jsp';");
				script.println("</script>");
				script.close();
				return;
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터 베이스 오류가 발생했습니다.')");
				script.println("history.back()';");
				script.println("</script>");
				script.close();
				return;
			}
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 추천을 누른 글입니다.')");
			script.println("location.href = 'index.jsp';");
			script.println("</script>");
			script.close();
		}
	
	
%>
