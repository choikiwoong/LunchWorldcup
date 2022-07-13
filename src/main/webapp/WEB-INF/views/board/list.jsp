<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시판 페이지</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">맛집 공유하기
				<button id="regBtn" type="button" class="btn btn-xs pull-right">
				새 글 작성하기</button><br>
				
				<div>
					<a href="javascript:recentlist();">최신순</a>&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp
					<a href="javascript:hitlist();">조회순</a>&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp
					<a href="javascript:like_hitlist();">추천순</a>
				</div>
				
			</div>
			
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table width="100%"
					class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>추천수</th>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<c:forEach items="${list}" var="board">
						<tr>
							<td><c:out value="${board.likehit}" /></td>
							<td><c:out value="${board.bno}" /></td>
							<!-- href: 꼭 필요한 정보만 저장 (bno), url은 알고 있으므로 생략 -->
							<td><a class="move" href='<c:out value="${board.bno}" />'>
								<c:out value="${board.title}" />
									<b>[<c:out value="${board.replyCnt}"/>]</b>
								</a></td>
							<td><c:out value="${board.writer}" /></td>
							<td><fmt:formatDate value="${board.regDate}"
									pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${board.updateDate}"
									pattern="yyyy-MM-dd" /></td>
							<td><c:out value="${board.hit}" /></td>
						</tr>
					</c:forEach>
				</table>
				<div class='row'>
				  <div class="col-lg-12">
				    <form id='searchForm' action="/board/list" method='get'>
					  <select name='type'>
					  	<!-- selected 속성을 추가 : type을 보여준다. -->
					    <option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
					    <option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
					    <option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
					    <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
					    
					  </select>
					  <input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' />
					  <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' />
					  <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
					  <button class='btn btn-default'>Search</button>
					</form>
				  </div>
				</div>
				<!-- 페이징 처리 부분을 추가 -->
				<div class='pull-right'>
				  <ul class="pagination">
					<c:if test="${pageMaker.prev}">
					  <li class="paginate_button previous"><a
						href="${pageMaker.startPage -1}">Previous</a></li>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}">
					  <li class="paginate_button  ${pageMaker.cri.pageNum == num ? 'active':''} ">
						<a href="${num}">${num}</a>
					  </li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
					  <li class="paginate_button next"><a
						href="${pageMaker.endPage +1 }">Next</a></li>
					</c:if>
				  </ul>
				</div><!--  end Pagination -->
				<form id='actionForm' action="/board/list" method='get'>
				  <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				  <input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
				  <input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'>
		  		  <input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
				</form>
				<!-- Modal  추가 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
				    <div class="modal-dialog">
					<div class="modal-content">
					    <div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
						  aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">Modal title</h4>
					    </div>
					    <div class="modal-body">처리가 완료되었습니다.</div>
					    <div class="modal-footer">
						<button type="button" class="btn btn-default"
						  data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Save changes</button>
					    </div>
					</div><!-- /.modal-content -->
				    </div><!-- /.modal-dialog -->
				</div><!-- /.modal -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<script type="text/javascript">
$(document).ready(function() {	// HTML 코드가 브라우저에 렌더링된다음
	var result ='<c:out value="${result}"/>';	// bno를 저장
	// 게시글 쓰기를 한 게시글 번호를 사용자에게 알린다.
	// 주의사항 : 브라우저에서 히스토리 기능이 있어서 백/포워드를 하면 게시글을
	// 작성하지 않고 새로 작성한 것처럼 출력이 될 수 있다.
	// 모달창을 뛰운다.
	checkModal(result);
	history.replaceState({}, null, null);
	function checkModal(result) {
		if(result === '' || history.state) {	// 게시글을 작성하지 않고 온 경우 모달창을 띄우지 않겠다.
			return;
		}
		if(parseInt(result) > 0) {	// 정상적인 게시글 번호이면
			$(".modal-body").html(	// 모달창의 본문 내용을 추가
				"게시글 " + parseInt(result)
				+ " 번이 등록되었습니다.");
		}
		$("#myModal").modal("show");	// 모달창을 보여준다.
	}
	$("#regBtn").on("click", function(){	// 이벤트와 핸들러 등록
		self.location = "/board/register";	// 게시글 쓰기 화면으로 이동
	});
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click", function(e) {
	  e.preventDefault();
	  console.log('click');
	  actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	  actionForm.submit();
	});
	$(".move").on("click", function(e) {
	  e.preventDefault();
	  // bno를 전달하기 위한 <input 태그를 추가
	  actionForm.append("<input type='hidden' name='bno' value='"
		+ $(this).attr("href") + "'>");
	  actionForm.attr("action",	"/board/get");
	  actionForm.submit();	// bno, pageNum, amount
	});
	// 검색에 대한 유효성 검사를 하고, 1페이지 부터 출력이 되도록 한다.
	var searchForm = $("#searchForm");
	// 검색(searchForm button)버튼에 "click" 이벤트를 건다.
	$("#searchForm button").on("click", function(e) {
		if (!searchForm.find("option:selected").val()) {
			alert("검색종류를 선택하세요");
			return false;
		}
		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");	// 1페이지
		e.preventDefault();
		searchForm.submit();
	});

});
</script>
<%@ include file="../includes/footer.jsp"%>