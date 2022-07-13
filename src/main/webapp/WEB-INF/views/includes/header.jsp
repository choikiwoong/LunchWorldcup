<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>골라줘 점심즈</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>

<body>

		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header"></div>
            <ul class="vav navbar-top-links navbar = left" style="text-align:center">
            	<img src="../../resources/img/logo.png" width=700 height="250" onclick="location.href='/'"><br>
				<li style="display:inline-block">
					<input type="button" value="골라줘 점심즈" onclick="location.href='/'" class="btn btn-lg">
                    <input type="button" value="점심 메뉴 월드컵" onclick="location.href='../worldcup/main'" class="btn btn-lg">
					<input type="button" value="맛집 공유 게시판" onclick="location.href='/board/list'" class="btn btn-lg">
					<input type="button" value="새 글 작성하기" onclick="location.href='/board/register'" class="btn btn-lg">
                </li>
             </ul>
            

            
            
            <ul class="nav navbar-top-links navbar-right">
                <li>
                    <ul>
						<sec:authorize access="isAnonymous()">
							<!-- 로그인하지 않은 경우 -->
							<a href="/customLogin" class="fa fa-sign-out">로그인</a>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<!-- 인증(로그인)이 되었다면 -->
							<a href="/customLogout" class="fa fa-sign-out">로그아웃</a>
						</sec:authorize>
                    </ul>
                </li>
            </ul>
        </nav>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        