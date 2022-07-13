<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Read Page</div>
			<div class="panel-body">
				<div class="form-group">
					<label>Bno</label> <input class="form-control" name='bno'
						value='<c:out value="${board.bno }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Title</label> <input class="form-control" name='title'
						value='<c:out value="${board.title }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name='content'
						readonly="readonly"><c:out value="${board.content}" /></textarea>
				</div>
				<div class="form-group">
					<label>Writer</label> <input class="form-control" name='writer'
						value='<c:out value="${board.writer }"/>' readonly="readonly">
				</div>
				<!-- 
				<button data-oper='modify' class="btn btn-default"
					onclick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'">Modify</button>
				<button data-oper='list' class="btn btn-info"
					onclick="location.href='/board/list'">List</button>
				 -->
				<button data-oper='modify' class="btn btn-default">Modify</button>
				<button data-oper='list' class="btn btn-info">List</button>

				<form id='operForm' action="/boad/modify" method="get">
					<input type='hidden' id='bno' name='bno'
						value='<c:out value="${board.bno}"/>'> <input
						type='hidden' name='pageNum'
						value='<c:out value="${cri.pageNum}"/>'> <input
						type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
					<!-- 검색유형(type) 키워드가 추가되야함 -->
					<input type='hidden' name='keyword'
						value='<c:out value="${cri.keyword}"/>'> <input
						type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
				</form>
			</div>
		</div>
	</div>
</div>
<div class='row'>
	<div class="col-lg-12">
		<!-- /.panel -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New
					Reply</button>

			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<ul class="chat">
					<!-- start reply -->
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong> <small
									class="pull-right text-muted">2018-01-01 13:13</small>
							</div>
							<p>Good job!</p>
						</div>
					</li>
					<!-- end reply -->
				</ul>
				<!-- ./ end ul -->
			</div>
			<!-- /.panel .chat-panel -->
		</div>
	</div>
	<!-- ./ end row -->
</div>
<!-- 모달창 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name='reply'
						value='New Reply!!!!'>
				</div>
				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name='replyer'
						value='replyer'>
				</div>
				<div class="form-group">
					<label>Reply Date</label> <input class="form-control"
						name='replyDate' value='2018-01-01 13:13'>
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
				<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var bnoValue = '<c:out value = "${board.bno}"/>'; // 게시글 번호저장
						var replyUL = $(".chat"); // 댓글목록에 대하여 변수를 추가

						showList(1); // 댓글 목록을 보여줌(1페이지)

						// 댓글 목록으 보여주는 함수
						function showList(page) {
							console.log("show list " + page);
							// 서버에서 댓글 목록을 가져온다
							// list : 서버로부터 댓글 목록을 수신
							replyService
									.getList(
											{
												bno : bnoValue,
												page : page || 1
											},
											function(list) {
												console.log("list: " + list);

												var str = "";
												if (list == null
														|| list.length == 0) { // 댓글이 없는 경우
													replyUL.html(""); // 댓글목록을 지워버림
													return;
												}
												// 댓글이 있는 경우
												for (var i = 0, len = list.length || 0; i < len; i++) { // 댓글에 대하여 조작
													// html 로 댓글을 작성
													// <li 태그를 추가
													// data-rno : 속성  data-rno을 이횽해서 댓글 번호를 저장
													str += "<li class='left clearfix'data-rno='"+list[i].rno+"'>";
													// 댓글 번호와 댓글 작성자
													str += "<div><div class='header'><strong class='primary-font'>["
															+ list[i].rno
															+ "]"
															+ list[i].replyer
															+ "</strong>";
													// 댓글 작성시간	
													str += "<small class='pull-right text-muted'>"
															+ replyService
																	.displayTime(list[i].replyDate)
															+ "</small></div>";
													// 댓글 내용
													str += "<p>"
															+ list[i].reply
															+ "</p></div></li>";
												}
												replyUL.html(str); // 댓글을 추가
											});
						}

						var modal = $(".modal");
					    var modalInputReply = modal.find("input[name='reply']");
					    var modalInputReplyer = modal.find("input[name='replyer']");
					    var modalInputReplyDate = modal.find("input[name='replyDate']");
					    
					    var modalModBtn = $("#modalModBtn");
					    var modalRemoveBtn = $("#modalRemoveBtn");
					    var modalRegisterBtn = $("#modalRegisterBtn");


						// 댓글 추가 버틀을 누를경우 동작
						$("#addReplyBtn").on("click", function(e){
					      modal.find("input").val("");
					      modalInputReplyDate.closest("div").hide();
					      modal.find("button[id !='modalCloseBtn']").hide();
					      modalRegisterBtn.show();
					      $(".modal").modal("show");
					    });

						
						// 댓글 추가 버튼 눌리면 서버로 댓글을 추가 요청, 댓글 목록을 갱신
						    modalRegisterBtn.on("click",function(e){
					        var reply = {
					            reply: modalInputReply.val(),
					            replyer:modalInputReplyer.val(),
					            bno:bnoValue
					        };
					        replyService.add(reply, function(result){
					            alert(result);
					            modal.find("input").val("");
					            modal.modal("hide");
					            
					            showList(1);	//댓글목록이갱신되도록한다.
						});
					        
					        // 댓글 조회 클릭 이벤트 처리 
					        $(".chat").on("click", "li", function(e){	// li 태그는 댓글이 추가되면 생기는 것
					          var rno = $(this).data("rno");
					          console.log(rno);

					          replyService.get(rno, function(reply){
					            modalInputReply.val(reply.reply);
					            modalInputReplyer.val(reply.replyer);
					            modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
					            .attr("readonly","readonly");
					            modal.data("rno", reply.rno);
					            
					            modal.find("button[id !='modalCloseBtn']").hide();
					            modalModBtn.show();
					            modalRemoveBtn.show();
					            
					            $(".modal").modal("show");        
					          });
     
					        
					});
	
	
	
	
</script>
<script type="text/javascript">
	$(document).ready(function() {
		// 페이징과 검색기능을 추가할 떄, 필요한 데이터를 추가하기 용이하도록 변경
		// form 안에 input 태그에 필요한 데이터를 추가하기 위해 form을 이용
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/modify").submit();
		});
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove(); // bno input 태그를 삭제
			operForm.attr("action", "/board/list");
			operForm.submit();
		});
	});
</script>
<%@ include file="../includes/footer.jsp"%>
