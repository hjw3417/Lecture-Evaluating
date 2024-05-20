<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%
	
	//session에 담긴 정보 제거
	session.invalidate();

%>

<script>
	location.href = 'userLogin.jsp';
</script>