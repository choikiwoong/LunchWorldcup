<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 체크</title>
<!-- 자바스크립트 파일을 절대 경로를 사용해서 지정
	절대경로를 사용할 때 c:url JSTL 태그를 사용
  -->
<script type="text/javascript" src="<c:url value="/resources/js/member.js" />"></script>
</head>
<body>
	<h2>아이디 중복 확인</h2>
	<!-- 아이디 중복 체크를 다시 실행하기 위해 (중복된 아이디 일 경우
		다시 다른 아이디로 중복체크를 해야 하므로 -->
	<form action="idCheck.action" method="get" name="frm">
		아이디 <input type="text" name="userid" value="${userid}">
		<input type="submit" value="중복 체크"><br>
	</form>
		<!-- 중복된 사용자 : result(1) -->
		<c:if test="${result == 1}">
			<script type="text/javascript">
				opener.document.frm.userid.value = "";	// opener : joinForm.jsp
				// idCheck.jsp의 부모인 joinForm.jsp -> 중복되었으므로 ""로 채운 것임.
			</script>
			${userid}는 이미 사용중인 아이디입니다.
		</c:if>
		<!-- 사용 가능한 아이디 : result(-1) -->
		<c:if test="${result == -1}">
			${userid}은 사용 가능한 아이디입니다.
			<input type="button" value="사용" class="cancel" onclick="idok('${userid}')">
		</c:if>
	
</body>
</html>