<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp"%>
<div class="row">
  <div class="col-lg-12">
	<h1 class="page-header">profile</h1>
  </div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
  <div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">User Profile Page</div>
		<div class="panel-body">
		  	<div class="form-group">
		  		<label>Userid</label>
		  		<input class="form-control" name='userid' value='<c:out value="${member.userid }"/>' readonly="readonly">
		  	</div>
		  	<div class="form-group">
		  		<label>Username</label>
		  		<input class="form-control" name='username' value='<c:out value="${member.username }"/>' readonly="readonly">
		  	</div>
		  	<div class="form-group">
		  		<label>regDate</label>
		  		<input class="form-control" name='regDate' value='<c:out value="${member.regDate }"/>' readonly="readonly">
		  	</div>
		  	<div class="form-group">
		  		<label>updateDate</label>
		  		<input class="form-control" name='updateDate' value='<c:out value="${member.updateDate }"/>' readonly="readonly">
		  	</div>
		</div><!-- end panel-body -->  		
	</div><!-- end panel panel-default -->
  </div><!-- /.col-lg-12 -->
</div><!-- /.row -->




<%@ include file="../includes/footer.jsp" %>