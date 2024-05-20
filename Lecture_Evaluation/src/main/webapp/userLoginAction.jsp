<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	//요청 정보를 한글로 인코딩
	request.setCharacterEncoding("UTF-8");
	
	//회원 가입 정보 초기화
	String userID = null;
	String userPassword = null;
	
	//입력된 회원 가입 정보를 변수에 저장
	if(request.getParameter("userID") != null) {
		userID = (String) request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = (String) request.getParameter("userPassword");
	}

	
	//입력된 아이디와 비밀 번호를 userDAO에 저장
	UserDAO userDAO = new UserDAO();
	
	//login() 메소드를 통해 DB에 저장된 회원 정보 조회
	int result = userDAO.login(userID, userPassword);
	
	//회원 가입 정보와 입력된 정보를 비교하여 로그인 확인
	if(result == 1) {
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 되었습니다.')");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
	} else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀 번호가 다릅니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	} else if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	} else if(result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터테이스 오류가 발생했습니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	
	}
	
	
	

%>
