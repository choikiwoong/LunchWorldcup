<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- all or member or admin -->
<h1>/security/all page</h1>

<sec:authorize access="isAnonymous()"><!-- 로그인하지 않은 경우 -->
	<a href="/customLogin">로그인</a>
</sec:authorize>
	
<sec:authorize access="isAuthenticated()"><!-- 인증(로그인)이 되었다면 -->
	<a href="/customLogout">로그아웃</a>
</sec:authorize>
</body>
</html>