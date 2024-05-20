<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
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

<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}



%>
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
		    <input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
		    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		</form>
		<!-- 네비 바 미니 검색 엔진 끝 -->
    </div>
    <!-- 토글러 컨텐츠 시작 -->
</nav>
<!-- 네이베게이션 섹션 끝 -->


<!-- 본문 섹션 시작 -->
<section class="container mt-3" style="max-width: 560px;">
	<!-- 아이디 및 비밀 번호 입력창 시작 -->
	<form method="post" action="./userLoginAction.jsp">
		<div class="form-group">
			<label>아이디</label>
			<input type="text" name="userID" class="form-control">
		</div>
		<div class="form-group">
			<label>비밀 번호</label>
			<input type="text" name="userPassword" class="form-control">
		</div>
		<button type="submit" class="btn btn-primary">로그인</button>
	</form>
	
		
	<!-- 아이디 및 비밀 번호 입력창 끝 -->
	
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