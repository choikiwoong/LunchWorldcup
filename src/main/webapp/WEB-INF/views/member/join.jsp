<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value="/resources/js/member.js" />"></script>
</head>
<body>
	<div style="width: 400px; margin:0 auto;">
	<h2>회원 가입</h2>
	'*' 표시항목은 필수 입력 항목 입니다.
	
	<form name="frm" method="post" action="join">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<table>
			
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="userid" size="20" id="id">*
					<input type="button" value="중복 체크" onclick="idCheck()">
					<input type="hidden" name="reid" size="20">
				</td>
			</tr>
			<tr>
				<td>암호</td>
				<td><input type="password" name="userpw" id="pw" size="20">*</td>
			</tr>
			<tr height="30">
				<td width="80">암호 확인</td>
				<td><input type="password" name="userpw2" id="pw2" size="20">*</td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="username" id="name" size="20"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="email" name="email" size="20"></td>
			</tr>
			
			
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="확인" onclick="return joinCheck()">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="취소">
				</td>
			</tr>
			<tr>
				<td colspan="2">${message}</td>
			</tr>
		</table>

</form>
	</div>
	
     


</body>


</html>