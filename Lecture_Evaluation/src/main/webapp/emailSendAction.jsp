<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="util.Nmail" %>
<%@ page import="java.io.PrintWriter" %>
<%
	//UserDAO 객체 생성
	UserDAO userDAO = new UserDAO();

	//userID 생성 및 초기화
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	//로그인 상태 확인 후 로그인이 되지 않았으면 로그인 페이지로 이동
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이된 상태입니다.')");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
	}
	
	//email 확인 변수 생성 및 초기화
	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	
	//email 확인하여 인증시 초기 화면으로 이동
	if(emailChecked == true) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 인증된 회원입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	//사용자에게 보낼 메시지를 기입
	String host = "http://localhost:8081/Lecture_Evaluation/";
	String from = "rapheo0913@naver.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "강의 평가를 위한 이메일 확인 메일입니다.";
	String content = "다음 링크에 접속하여 이메일 확인을 진행하세요." +
					"<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) +"'>이메일 인증하기</a>";
	
	//SMTP에 접속하기 위한 정보를 기입
	Properties p = new Properties();
	p.put("mail.transport.protocol", "smtp");
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.naver.com");
	p.put("mail.smtp.port", "587");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "587");
	//p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	
	try {
	    Authenticator auth = new Nmail();
	    Session ses = Session.getInstance(p, auth);
	    ses.setDebug(true);
	    MimeMessage msg = new MimeMessage(ses);
	    msg.setSubject(subject);
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr);
	    Address toAddr = new InternetAddress(to);
	    msg.addRecipient(Message.RecipientType.TO, toAddr);
	    msg.setContent(content, "text/html;charset=UTF-8");
	    Transport.send(msg);
	} catch (Exception e) {
	    e.printStackTrace();
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('회원가입 완료되었으나 인증 메일 발송 오류입니다.')");
	    script.println("history.back();");
	    script.println("</script>");
	    script.close();
	    return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>로그인</title>
<!-- 부트스트랩 CSS 추가하기 -->
<!-- <link rel="stylesheet" href="./css/bootstrap.min.css"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="./css/custom.css">

</head>
<body>
<!-- 네이베게이션 섹션 시작 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
	
	<!-- 토글러 버튼 시작 -->
	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <!-- 토글러 버튼 끝 -->
    <!-- 토글러 컨텐츠 시작 -->
    <div id="navbar" class="collapse navbar-collapse">
    	<ul class="navbar-nav mr-outo">
    		<li class="nav-item active">
    			<a class="nav-link" href="index.jsp">메인</a>
    		</li>
    		<li class="nav-item dropdown">
    			<a class="nav-link dropdown-toggle" id="dropdown" data-bs-toggle="dropdown">
    				회원관리
    			</a>
    			<div class="dropdown-menu" aria-labelledby="dropdown">
<!-- 로그인 여부에 따른 목록 변화 로직 시작 -->
<%
	if(userID == null) {

%>

    				<a class="dropdown-item" href="userLogin.jsp">로그인</a>
    				<a class="dropdown-item" href="userRegister.jsp">회원가입</a>
<%
	} else {
%>
    				<a class="dropdown-item" href="userLogoutAction.jsp">로그아웃</a>
<%
	}
%>
    				
<!-- 로그인 여부에 따른 목록 변화 로직 시작 -->
    			</div>
    		</li>
    	</ul>
    	<!-- 네비 바 미니 검색 엔진 시작 -->
    	<form class="form-inline my-2 my-lg-0">
		    <input class="form-control mr-sm-2" name="search" type="search" placeholder="내용을 입력하세요." aria-label="Search">
		    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		</form>
		<!-- 네비 바 미니 검색 엔진 끝 -->
    </div>
    <!-- 토글러 컨텐츠 시작 -->
</nav>
<!-- 네이베게이션 섹션 끝 -->


<!-- 본문 섹션 시작 -->
<section class="container mt-3" style="max-width: 560px;">
	<div class="alert alert-success mt-4" role="alert">
		이메일 주소 인증 메일이 전송되었습니다. 이메일에 들어가셔서 인증해주세요.
	</div>
	
</section>
<!-- 본문 섹션 끝 -->

<!-- 목차 이동 시작 -->
<ul class="pagination justify-content-center mt-3">
	<li class="page-item">
		<a class="page-link href="#">이전</a>
	</li>
	<li class="page-item">
		<a class="page-link href="#">다음</a>
	</li>
</ul>
	
<!-- 목차 이동 끝 -->


	
<!-- 푸터 섹션 시작 -->
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2024 허진욱 All Rights Reserved.
	</footer>
<!-- 푸터 섹션 끝 -->

<!-- 제이쿼리 자바스트립트 추가하기 -->
<script src="script/jquery-1.12.4.js"></script>
<!-- popper 자바스트립트 추가하기 -->
<!-- <script src="./js/popper.js"></script> -->
<!-- 부트스트랩 자바스트립트 추가하기 -->
<!-- <script src="./js/bootstrap.min.js"></script> -->
<!-- Bootstrap JavaScript (반드시 body 태그의 마지막에 로드해야 함) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
