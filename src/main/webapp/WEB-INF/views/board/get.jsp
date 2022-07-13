<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp"%>

<div class="row">
  <div class="col-lg-12">
   <h1 class="page-header">맛집 공유하기</h1>
  </div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<div class="row">
  <div class="col-lg-12">
   <div class="panel panel-default">
     <div class="panel-heading"><c:out value="${board.title }" /></div><!-- /.panel-heading -->
      <div class="panel-body">
        <div class="form-group">
           <label>작성자 :<c:out value="${board.writer }"/> <br>
                 작성일 : <fmt:formatDate pattern ="yyyy-MM-dd" value="${board.regDate }" />                 
           </label>
           <span> 좋아요 : <c:out value="${board.likehit }" /> </span>
           <span> 싫어요 : <c:out value="${board.hatehit }" /> </span>
         </div>
         <div class="row">
           <div class="col-lg-12">
             <div class="panel panel-default">
               <div class="panel-heading">파일첨부</div><!-- /.panel-heading -->
               <div class="panel-body">
                 <div class='uploadResult'> 
                   <ul>
                   </ul>
                 </div>
               </div><!--  end panel-body -->
             </div><!--  end panel-body -->
           </div><!-- end panel -->
         </div><!-- /.row -->
         <div class="form-group">
           <label>내용</label>
           <textarea class="form-control" rows="10" name='content'
             readonly="readonly"><c:out value="${board.content}" /></textarea>
         </div>
          <div class="form-group">
         <button type="button" class="btn btn-warning " id="like_btn">추천 ${board.likehit}</button>
         <button type="button" class="btn btn-warning " id="hate_btn">비추천 ${board.hatehit}</button>
         
        </div>
        <!-- 댓글 추가 부분 -->
  <div class='row'>
  <div class="col-lg-12">
    <!-- /.panel -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
        <!-- <button id='addReplyBtn' class='btn btn-primary btn-xs
           pull-right'>New Reply</button> -->
           <sec:authorize access="isAuthenticated()">
              <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글 작성하기</button>
             </sec:authorize>
      </div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        <ul class="chat"><!-- 댓글 목록 -->
        <!-- start reply -->
        <li class="left clearfix" data-rno='12'>
           <div>
             <div class="header">
               <strong class="primary-font">user00</strong>
               <small class="pull-right text-muted">2018-01-01 13:13</small>
             </div>
             <p>Good job!</p>
           </div>
        </li>
        <!-- end reply -->
        </ul>
        <!-- ./ end ul -->
      </div>
      <!-- /.panel .chat-panel -->
      <!-- 댓글에 대한 페이징 처리하는 부분 -->
      <div class="panel-footer"></div>
   </div>
  </div>
  <!-- ./ end row -->
</div>
         <%-- <button data-oper='modify' class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'">Modify</button>
         <button data-oper='list' class="btn btn-info" onclick="location.href='/board/list'">List</button> --%>
         <!-- <button data-oper='modify' class="btn btn-default">Modify</button> -->
         <sec:authentication property="principal" var="pinfo"/>
            <sec:authorize access="isAuthenticated()">
             <c:if test="${pinfo.username eq board.writer}">
              <button data-oper='modify' class="btn btn-default">수정</button>
             </c:if>
          </sec:authorize>
         
         <button data-oper='list' class="btn btn-info">목록보기</button>
         <form id="operForm" action="/board/modify" method="get">
            <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
            <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
           <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
           <!-- type과 keyword가 추가되어야 한다. -->
           <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
           <input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
         </form>
         
         
      </div><!-- end panel-body -->
     </div><!-- end panel-body -->
   </div><!-- end panel -->
  </div><!-- /.row -->
  <div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>
<style>
span {
  float: right;
  color: red;
}
.uploadResult {
  height : 300px;
  width:100%;
  background-color: lightgray;
}
.uploadResult ul{
  display:flex;
  flex-flow: row;
  justify-content: left;
  align-items: center;
}
.uploadResult ul li {
  list-style: none;
  padding: 10px;
  align-content: center;
  text-align: center;
}
.uploadResult ul li img{
  width: 100%;
  height: 100%;
}
.uploadResult ul li span {
  color:white;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
  background:rgba(255,255,255,0.5);
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
.bigPicture img {
  width:600px;
}
</style>


<!-- 모달창을 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
  aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"
          aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">댓글 작성</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <label>댓글 내용</label> 
          <input class="form-control" name='reply' value='New Reply!!!!'>
        </div>      
        <div class="form-group">
          <label>작성자</label> 
          <input class="form-control" name='replyer' value='replyer'>
        </div>
        <div class="form-group">
        <label>작성 일</label> 
          <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
        </div>        
      </div>
      <div class="modal-footer">
        <button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
        <button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
        <button id='modalRegisterBtn' type="button" class="btn btn-primary">작성</button>
        <button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">

 
$(document).ready(function() {
   var bnoValue = '<c:out value="${board.bno}" />';   // 게시글 번호 저장
   var replyUL = $(".chat");   // 댓글 목록에 대하여 변수를 추가
   
   showList(1);   // 댓글 목록을 보여준다. (1 페이지)
   
   // 댓글 목록을 보여주는 함수
   function showList(page) {   // page : 보여줄 페이지 번호
      console.log("show list " + page);
      // 서버에서 댓글 목록을 가져온다.
      replyService.getList({bno: bnoValue, page: page || 1}, function(replyCnt, list) {
         console.log("replyCnt: " + replyCnt);
         // 서버로부터 댓글 목록을 수신 : list
         console.log("list: " + list);   // 댓글 목록을 콘솔창에 출력
         
         if(page == -1) {   // 마지막 페이지를 보여준다.
            pageNum = Math.ceil(replyCnt / 10.0);   // 마지막 페이지 번호
            showList(pageNum);   // 마직 페이지를 보여준다.
            return;
         }
         
         var str = "";
         if(list == null || list.length == 0) {   // 댓글이 없으면
            replyUL.html("");   // 댓글 목록을 지운다.
            return;
         }
         // 댓글이 있으면
         for(var i = 0, len = list.length || 0;i < len;i++) {   // 댓글에 대하여 조작
            // html로 댓글을 작성
            // <li 태그를 추가
            // data-rno : 속성 data-rno을 이용해서 댓글 번호를 저장
            str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
            // 댓글 번호와 댓글 작성자
            str +="  <div><div class='header'><strong class='primary-font'>["
               + list[i].rno+"] "+ list[i].replyer + "</strong>";
            // 댓글 작성 시간
             str +="    <small class='pull-right text-muted'>"
                + replyService.displayTime(list[i].replyDate) + "</small></div>";
            // 댓글 내용
             str +="    <p>"+list[i].reply+"</p></div></li>";
         }
         replyUL.html(str);         // 댓글을 추가
         showReplyPage(replyCnt);   // 페이징 처리 부분을 보여준다.
      });
   }
   
   var modal = $(".modal");
    var modalInputReply = modal.find("input[name='reply']");
    var modalInputReplyer = modal.find("input[name='replyer']");
    var modalInputReplyDate = modal.find("input[name='replyDate']");
    
    var modalModBtn = $("#modalModBtn");
    var modalRemoveBtn = $("#modalRemoveBtn");
    var modalRegisterBtn = $("#modalRegisterBtn");

    // 댓글작성자
    var replyer = null;
    <sec:authorize access="isAuthenticated()" >
        replyer = '<sec:authentication property="principal.username"/>';
    </sec:authorize>
     
    var csrfHeaderName ="${_csrf.headerName}"; 
    var csrfTokenValue ="${_csrf.token}";

    $("#addReplyBtn").on("click", function(e){   // 댓글 추가 버튼을 누르면 동작
      modal.find("input").val("");
        // 댓글 작성 버튼을 누르면 모달창이 뜰때 작성자이름을 보여줌
      modal.find("input[name='replyer']").val(replyer);
      // 댓글을 추가할 때 작성시간이 불필요하므로 감춘다.
      modalInputReplyDate.closest("div").hide();   // 댓글 작성시간을 감춤
      modal.find("button[id !='modalCloseBtn']").hide();
      modalRegisterBtn.show();
      $(".modal").modal("show");   // 모달창을 보이게 한다.
    });
    
   // Ajax spring security header...
   // reply.js에서 ajax 전송을 하기 떄문에  여기서 헤더를 추가
    $(document).ajaxSend(function(e, xhr, options) { 
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
    }); 

    
    // 댓글 추가 버튼이 눌리면 서버로 댓글 추가를 요청을하고 댓글목록을 갱신
    modalRegisterBtn.on("click",function(e){
        var reply = {
            reply: modalInputReply.val(),
            replyer:modalInputReplyer.val(),
            bno:bnoValue
        };
        replyService.add(reply, function(result){
            alert(result);
            modal.find("input").val("");
            modal.modal("hide");      // 모달창을 닫음
            
            showList(-1);        // 마지막 페이지(-1)를 보여준다.
               // 댓글이 추가되면 마지막 페이지에 보여지므로
        });
    });

   // 댓글 조회 클릭 이벤트 처리 
    $(".chat").on("click", "li", function(e){   // li 태그는 댓글이 추가되면 생기는 것
      var rno = $(this).data("rno");   // 댓글 번호를 가져온다,
      console.log(rno);

      // 댓글 내용을 서버로부터 가져온다.
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

   // 댓글 수정 버튼이 눌리면 실행된다.
    modalModBtn.on("click", function(e){
       var originalReplyer = modalInputReplyer.val();
      var reply = {rno:modal.data("rno"), reply: modalInputReply.val(),
         replyer: originalReplyer};
      if(!replyer){
         alert("로그인후 수정이 가능합니다.");
         modal.modal("hide");
         return;
      }
      console.log("Original Replyer: " + originalReplyer);
      if(replyer != originalReplyer){
         alert("자신이 작성한 댓글만 수정이 가능합니다.");
         modal.modal("hide");
         return;
      }
      replyService.update(reply, function(result){
           alert(result);
           modal.modal("hide");
           showList(pageNum);
      });
   });

   // 댓글 삭제 버튼이 눌리면 실행하도록 이벹를 등록하고 핸들러를 정의한다.
    modalRemoveBtn.on("click", function (e){
      var rno = modal.data("rno");
      console.log("RNO: " + rno);
         console.log("REPLYER: " + replyer);
         if(!replyer){
           alert("로그인후 삭제가 가능합니다.");
           modal.modal("hide");
           return;
         }
         var originalReplyer = modalInputReplyer.val();
         console.log("Original Replyer: " + originalReplyer);
         if(replyer  != originalReplyer){
           alert("자신이 작성한 댓글만 삭제가 가능합니다.");
           modal.modal("hide");
           return;
         }
  
      replyService.remove(rno, originalReplyer, function(result){
            alert(result);
            modal.modal("hide");
            showList(pageNum);
      });
   });

   // 댓글의 페이지 처리부분
    var pageNum = 1;
    var replyPageFooter = $(".panel-footer");
    
    // 페이징 처리부분 보져주는 메소드
    function showReplyPage(replyCnt){
       // BoardController에서 페이징 처리하는 부분
       var endNum = Math.ceil(pageNum / 10.0) * 10;  
       var startNum = endNum - 9;       
       var prev = startNum != 1;
       var next = false;
          
       if(endNum * 10 >= replyCnt){
            endNum = Math.ceil(replyCnt/10.0);
       }
       if(endNum * 10 < replyCnt){
            next = true;
       }
       var str = "<ul class='pagination pull-right'>";
       if(prev){
            str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
       }
       for(var i = startNum ; i <= endNum; i++){
            var active = pageNum == i? "active":"";
            str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
       }
       if(next){
            str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
       }
       str += "</ul></div>";
       console.log(str);
       replyPageFooter.html(str);
    }
    
    // 댓글의 페이징 처리부분 링크가 눌렸을 때 실행
    replyPageFooter.on("click","li a", function(e){
       e.preventDefault();
       console.log("page click");
       var targetPageNum = $(this).attr("href");
       console.log("targetPageNum: " + targetPageNum);
       pageNum = targetPageNum;
       showList(pageNum);
    });

    // 게시글 상세 보기 화면이 보여지고 나서 자동으로 실행되는 함수
    (function() {   // 자동 실행함수
      var bno = '<c:out value="${board.bno}"/>';

      // 특정 게시글 bno에 대한 첨부파일 정보를 요청
      $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
        console.log(arr);
        var str = "";
        $(arr).each(function(i, attach){
          //image type
          if(attach.fileType){
        	
            var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
            str += "<img src='/display?fileName="+fileCallPath+"'>";
            str += "</div>";
            str +"</li>";
          }else{
            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
            str += "<span> "+ attach.fileName+"</span><br/>";
            str += "<img src='/resources/img/attach.png'>";
            str += "</div>";
            str +"</li>";
          }
        });
           $(".uploadResult ul").html(str);
      }); //end getjson
   })();
    
    $(".uploadResult").on("click","li", function(e){
       console.log("view image");
       var liObj = $(this);
       var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
       if(liObj.data("type")){
         showImage(path.replace(new RegExp(/\\/g),"/"));
       }else {
         //download 
         self.location ="/download?fileName="+path;
       }
      });
      
   function showImage(fileCallPath){
      
        alert(fileCallPath);
       $(".bigPictureWrapper").css("display","flex").show();
       $(".bigPicture")
         .html("<img src='/display?fileName="+fileCallPath+"' >")
         .animate({width:'100%', height: '100%'}, 1000);
   }

     $(".bigPictureWrapper").on("click", function(e){
          $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
          setTimeout(function(){
            $('.bigPictureWrapper').hide();
          }, 1000);
      });
     
    
   $("#like_btn").on("click", function updateLike(e){
      var bno = ${board.bno};
      var userid = null;
      <sec:authorize access="isAuthenticated()" >
         userid = '<sec:authentication property="principal.username"/>';
      </sec:authorize>
      $.ajax({
               type : "POST",  
               url : "/board/updateLike",       
               dataType : "json",   
               data : {'bno' : bno, 'userid' : userid },
               error : function(){
                  alert("로그인 후 사용 가능");
               },
               success : function(likeCheck) {
                   
                       if(likeCheck == 0){
                          alert("추천완료.");
                          location.reload();
                       }
                       else if (likeCheck == 1){
                        alert("추천취소");
                          location.reload();

                   }
               }
         });

   });
   
   $("#hate_btn").on("click", function updateHate(e){
	      var bno = ${board.bno};
	      var userid = null;
	      <sec:authorize access="isAuthenticated()" >
	         userid = '<sec:authentication property="principal.username"/>';
	      </sec:authorize>
	      $.ajax({
	               type : "POST",  
	               url : "/board/updateHate",       
	               dataType : "json",   
	               data : {'bno' : bno, 'userid' : userid },
	               error : function(){
	                  alert("로그인 후 사용 가능");
	               },
	               success : function(hateCheck) {
	                   
	                       if(hateCheck == 0){
	                          alert("비추천완료.");
	                          location.reload();
	                       }
	                       else if (hateCheck == 1){
	                        alert("비추천취소");
	                          location.reload();

	                   }
	               }
	         });

	   });
    
   
   

});
</script>
<script type="text/javascript">
$(document).ready(function() {
   // 페이징과 검색기능을 추가할 때, 필요한 데이터를 추가하기 용이하도록 변경
   // form 안에 input 태그에 필요한 데이터를 추가하기 위해서
   var operForm = $("#operForm");
   $("button[data-oper='modify']").on("click", function(e) {
      operForm.attr("action", "/board/modify").submit();   // 서버로 수정 요청
   });
   $("button[data-oper='list']").on("click", function(e) {
      operForm.attr("action", "/board/list");
      operForm.find("#bno").remove();   // bno input 태그를 삭제
      operForm.submit();
   });

});

</script>
<%@ include file="../includes/footer.jsp" %>