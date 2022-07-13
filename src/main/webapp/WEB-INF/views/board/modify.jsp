<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 수정 페이지</h1>
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">맛집 공유하기</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<form role="form" action="/board/modify" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<!-- <input type='hidden' name='pageNum'	value='<c:out value="${cri.pageNum}"/>'>  -->
					<input type='hidden' name='amount'
						value='<c:out value="${cri.amount}"/>'>
					<!-- type과 keyword를 추가 -->
					<input type='hidden' name='type'
						value='<c:out value="${cri.type }"/>'> <input
						type='hidden' name='keyword'
						value='<c:out value="${cri.keyword }"/>'>
					<div class="form-group">
						<label>Bno</label> <input class="form-control" name='bno'
							value='<c:out value="${board.bno }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>제 목</label> <input class="form-control" name="title"
							value='<c:out value="${board.title}"/>'>
					</div>
					
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-heading">파일</div>
								<!-- /.panel-heading -->
								<div class="panel-body">
								<div class="form-group uploadDiv">
									<input type="file" name='uploadFile' multiple="multiple">
									</div>
									<div class='uploadResult'>
								<ul>
								</ul>
									</div>
								</div>
									<!--  end panel-body -->
								</div>
								<!--  end panel-body -->
							</div>
							<!-- end panel -->
						</div>
						<!-- /.row -->

					<div class="form-group">
						<label>내 용</label>
						<textarea class="form-control" rows="20" name="content"><c:out
								value="${board.content}" /></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label> <input class="form-control" name="writer"
							value='<c:out value="${board.writer}"/>' readonly="readonly">
					</div>
				<!-- <div class="form-group">
						<label>RegDate</label> <input class="form-control" name='regDate'
							value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regDate}" />'
							readonly="readonly">
					</div> 
					<div class="form-group">
						<label>Update Date</label> <input class="form-control"
							name='updateDate'
							value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}" />'
							readonly="readonly">
					</div>  -->
					<!-- <button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
					<button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>  -->
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer}">
							<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
							<button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
						</c:if>
					</sec:authorize>

					<button type="submit" data-oper='list' class="btn btn-info">목록보기</button>
				</form>
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var formObj = $("form"); // form 태그

						$('button')
								.on(
										"click",
										function(e) {
											// 세 개의 버튼을 구분을 해서 버튼별로 처리를 해야 함
											e.preventDefault(); // 버튼을 누르면 디폴트로 실행(서버로 전송)되는 동작을 막음
											var operation = $(this)
													.data("oper"); // data-oper 속성값을 얻는다.
											console.log(operation);
											if (operation === 'remove') {
												// form의 action이 default /board/modify -> /board/remove 변경
												formObj.attr("action",
														"/board/remove");
											} else if (operation === 'list') {
												// 목록 보기 페이지로 이동
												//			self.location = "/board/list";
												//			return;
												// 페이징 처리, 게시글 검색 기능 시 필요한 정보를 추가하기 위하여
												formObj.attr("action",
														"/board/list").attr(
														"method", "get");
												// input 태그들을(pageNum, amount) 복제한다.
												var pageNumTag = $(
														"input[name='pageNum']")
														.clone();
												var amountTag = $(
														"input[name='amount']")
														.clone();
												var keywordTag = $(
														"input[name='keyword']")
														.clone(); // 검색 관련
												var typeTag = $(
														"input[name='type']")
														.clone();
												formObj.empty(); // input 태그 (게시글 정보를 삭제)
												formObj.append(pageNumTag);
												formObj.append(amountTag);
												formObj.append(keywordTag); // 검색 관련
												formObj.append(typeTag);
											}
											// modify, remove 버튼을 누른 경우
											formObj.submit(); // 서버로 요청을 한다.
										});
						(function() {
							var bno = '<c:out value="${board.bno}"/>';
							$
									.getJSON(
											"/board/getAttachList",
											{
												bno : bno
											},
											function(arr) {
												console.log(arr);
												var str = "";
												$(arr)
														.each(
																function(i,
																		attach) {
																	//image type
																	if (attach.fileType) {
																		var fileCallPath = encodeURIComponent(attach.uploadPath
																				+ "/s_"
																				+ attach.uuid
																				+ "_"
																				+ attach.fileName);
																		str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
			      str +=" data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
																		str += "<span> "
																				+ attach.fileName
																				+ "</span>";
																		str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
			      str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
																		str += "<img src='/display?fileName="
																				+ fileCallPath
																				+ "'>";
																		str += "</div>";
																		str
																				+ "</li>";
																	} else {
																		str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
			      str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
																		str += "<span> "
																				+ attach.fileName
																				+ "</span><br/>";
																		str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
			      str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
																		str += "<img src='/resources/img/attach.png'></a>";
																		str += "</div>";
																		str
																				+ "</li>";
																	}
																});
												$(".uploadResult ul").html(str);
											});//end getjson
						})();//end function

						// 첨부 파일 추가
						var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
						var maxSize = 5242880; //5MB

						function checkExtension(fileName, fileSize) {
							if (fileSize >= maxSize) {
								alert("파일 사이즈 초과");
								return false;
							}
							if (regex.test(fileName)) {
								alert("해당 종류의 파일은 업로드할 수 없습니다.");
								return false;
							}
							return true;
						}
						var cloneObj = $(".uploadDiv").clone();
						var csrfHeaderName ="${_csrf.headerName}"; 
						var csrfTokenValue="${_csrf.token}";
						$("input[type='file']")
								.change(
										function(e) {
											var formData = new FormData();
											var inputFile = $("input[name='uploadFile']");
											var files = inputFile[0].files;
											for (var i = 0; i < files.length; i++) {
												if (!checkExtension(
														files[i].name,
														files[i].size)) {
													return false;
												}
												formData.append("uploadFile",
														files[i]);
											}

											$.ajax({
												url : '/uploadAjaxAction',
												processData : false,
												contentType : false,
												data : formData,
												type : 'POST',
												beforeSend: function(xhr) {
											          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
											      },
												dataType : 'json',
												success : function(result) {
													console.log(result);
													showUploadResult(result); //업로드 결과 처리 함수
													$(".uploadDiv").html(
															cloneObj.html());
												}
											}); //$.ajax
										});

						function showUploadResult(uploadResultArr) {
							if (!uploadResultArr || uploadResultArr.length == 0) {
								return;
							}
							var uploadUL = $(".uploadResult ul");
							var str = "";
							$(uploadResultArr)
									.each(
											function(i, obj) {
												if (obj.image) {
													var fileCallPath = encodeURIComponent(obj.uploadPath
															+ "/s_"
															+ obj.uuid
															+ "_"
															+ obj.fileName);
													str += "<li data-path='"+obj.uploadPath+"'";
				str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
				str +" ><div>";
													str += "<span> "
															+ obj.fileName
															+ "</span>";
													str += "<button type='button' data-file=\'"+fileCallPath+"\' "
				str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
													str += "<img src='/display?fileName="
															+ fileCallPath
															+ "'>";
													str += "</div>";
													str + "</li>";
												} else {
													var fileCallPath = encodeURIComponent(obj.uploadPath
															+ "/"
															+ obj.uuid
															+ "_"
															+ obj.fileName);
													var fileLink = fileCallPath
															.replace(
																	new RegExp(
																			/\\/g),
																	"/");
													str += "<li "
				str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
													str += "<span> "
															+ obj.fileName
															+ "</span>";
													str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
													str += "<img src='/resources/img/attach.png'></a>";
													str += "</div>";
													str + "</li>";
												}
											});
							uploadUL.append(str);
						}
					});
</script>
<%@ include file="../includes/footer.jsp"%>