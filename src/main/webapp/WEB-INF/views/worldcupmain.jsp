<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
   language="java"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<link type="text/css" rel="stylesheet" href="/resources/css/style.css">
<%@include file="/WEB-INF/views/includes/header.jsp"%>


<head>
<title>점심메뉴 월드컵</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<script type="text/javascript" src="/resources/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/resources/js/worldcup.js"></script>
</head>

<body>
<div class="wrap">
   <h1>점심메뉴 월드컵</h1>
   <div id="intro" class="box2">
      <div class="noti">
      <h2>사용법</h2>
      <ol>
         <li>월드컵 후보가 되는 메뉴들의 이미지 파일을 준비한다.</li>
         <li>파일선택  버튼을 눌러 위에서 준비한 이미지 파일을 선택한다.</li>
      </ol>
      <p><input id="file" type="file" multiple></p>
      </div>
   </div>
   <div id="game" class="box">
       <h2 id="round_title"></h2>
      <div class="frame"><img id="left_image" src="/resources/images/no_contact_icon.png"><div id="left_name" class="name">아무개</div></div>
      <div class="frame"><img id="right_image" src="/resources/images/no_contact_icon.png"><div id="right_name" class="name">아무개</div></div>
      <div class="vs"></div>
   </div>
   <div id="winner" class="box2">
      <div class="frame">
         <img id="winner_image" src="/resources/images/no_contact_icon.png">
         <div id="winner_name" class="name"></div>
         <button id="newgame">새 게임</button>
      </div>
   </div>
</div>
</body>

<%@include file="/WEB-INF/views/includes/footer.jsp"%>

</html>