<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<%
    // 요청 정보를 한글로 인코딩
    request.setCharacterEncoding("UTF-8");

    String code = request.getParameter("code");
    UserDAO userDAO = new UserDAO();
    String userID = null;

    // 입력된 회원 가입 정보를 변수에 저장
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    // 회원 가입 정보가 담겼는지 확인하고 이메일 발송 페이지로 이동
    if (userID == null) {
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("alert('로그인을 해주세요.');");
            script.println("location.href = 'userLogin.jsp';");
            script.println("</script>");
        }
    } else {
        String userEmail = userDAO.getUserEmail(userID);
        boolean rightCode = SHA256.getSHA256(userEmail).equals(code);

        try (PrintWriter script = response.getWriter()) {
            if (rightCode) {
                userDAO.setUserEmailChecked(userID);
                script.println("<script>");
                script.println("alert('인증에 성공했습니다.');");
                script.println("location.href = 'index.jsp';");
                script.println("</script>");
            } else {
                script.println("<script>");
                script.println("alert('유효하지 않은 코드입니다.');");
                script.println("location.href = 'index.jsp';");
                script.println("</script>");
            }
        }
    }
%>

