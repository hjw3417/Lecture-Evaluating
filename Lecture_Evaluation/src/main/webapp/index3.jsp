<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>강의 평가 웹 사이트</title>
<!-- 부트스트랩 CSS 추가하기 -->
<!-- <link rel="stylesheet" href="./css/bootstrap.min.css"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- 커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="./css/custom.css">

</head>
<body>

<!-- 자바 코드 시작 -->
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요..')");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
	}
	
	/*기능미구현
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSedConfirm.jsp';");
		script.println("</script>");
		script.close();
	}
	*/

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
<section class="container mt-3" style="max-width: 860px;">
	<!-- 미니 검색 엔진 시작 -->
	<form method="get" action="./index.jsp" class="form-inline mt-3">
		<select name="lectureDivide" class="form-control mx-1 mt-2">
			<option value="전체">전체</option>
			<option value="전공">전공</option>
			<option value="교양">교양</option>
			<option value="기타">기타</option>
		</select>
		<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">	
		<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
		<a class="btn btn-primary mx-1 mt-2" data-bs-toggle="modal" href="#registerModal">등록하기</a>	
		<a class="btn btn-danger ml-1 mt-2" data-bs-toggle="modal" href="#reportModal">신고하기</a>	
	</form>
	<!-- 미니 검색 엔진 끝 -->
	
	<!-- 평가 카드 시작 -->
	<div class="card bg-lght mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left">컴퓨터학 개론 &nbsp;<small>허진욱</small></div>
				<div class="col-4 text-right">
					종합<span style="color: red;">A</span>
				</div>
			</div>
		</div>
		<div class="card-body">
			<h5 class="card-title">
				정말 좋은 강의에요.&nbsp;<small>(2017년 가을 학기)</small>
			</h5>
			<p class="card-text">강의가 많이 널널해서, 솔직히 많이 배운 건 없는 것 같지만 학점도 잘 나오고 너무 좋은 것 같습니다.</p>
			<div class="row">
				<div class="col-9 text-left">
					성적<span style="color: red;">&nbsp;A</span>
					널널<span style="color: red;">&nbsp;A</span>
					강의<span style="color: red;">&nbsp;A</span>
					<span style="color: green;">(추천: 15 )</span>
				</div>
			
				<div class="col-3 text-right">
					<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
					<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 평가 카드 끝 -->
	
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

<!-- modal 시작 -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modal">평가 등록</h5>
				<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="./evaluationRegisterAction.jsp" method="post">
					<div class="row">
						<div class="form-group col-sm-6">
							<label>강의명</label>
							<input type="text" name="lectureName" class="form-control" maxlength="20">
						</div>
						<div class="form-group col-sm-6">
							<label>교수명</label>
							<input type="text" name="professorName" class="form-control" maxlength="20">
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-sm-4">
							<label>수강년도</label>
							<select name="lectureYear" class="form-control">
								<option value="2020">2020</option>
								<option value="2021">2021</option>
								<option value="2022">2022</option>
								<option value="2023">2023</option>
								<option value="2024" selected>2024</option>
							</select>
						</div>
						<div class="form-group col-sm-4">
							<label>수강학기</label>
							<select name="semesterDivide" class="form-control">
								<option value="1학기">1학기</option>
								<option value="여름학기">여름학기</option>
								<option value="2학기">2학기</option>
								<option value="겨울학기">겨울학기</option>
							</select>
						</div>
						<div class="form-group col-sm-4">
							<label>강의구분</label>
							<select name="lectureDivide" class="form-control">
								<option value=전공>전공</option>
								<option value="교양">교양</option>
								<option value="기타">기타</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label>제목</label>
						<input type="text" name="evaluationTitle" class="form-control" maxlength="20">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;">
						</textarea>
					</div>
					<div class="form-row">
						<div class="form-group col-sm-3">
							<label>종합</label>
							<select name="totalScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B" >B</option>
								<option value="C" >C</option>
								<option value="D" >D</option>
								<option value="F" >F</option>
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label>성적</label>
							<select name="creditScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B" >B</option>
								<option value="C" >C</option>
								<option value="D" >D</option>
								<option value="F" >F</option>
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label>널널</label>
							<select name="comfortableScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B" >B</option>
								<option value="C" >C</option>
								<option value="D" >D</option>
								<option value="F" >F</option>
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label>강의</label>
							<select name="lectureScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B" >B</option>
								<option value="C" >C</option>
								<option value="D" >D</option>
								<option value="F" >F</option>
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">등록하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modal">신고하기</h5>
				<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" action="./reportActioin.jsp">
					<div class="form-group">
						<label>제목</label>
						<input type="text" name="evaluationTitle" class="form-control" maxlength="20">
					</div>
					<div class="form-group">
						<label>신고내용</label>
						<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;">
						</textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-danger">신고하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- modal 끝 -->
	
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