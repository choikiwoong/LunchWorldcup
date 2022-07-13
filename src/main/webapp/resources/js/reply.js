/**
* 서버와 통신을 하는 객체를 정의 : replyService
*/
console.log("Reply Module.........");

var replyService = (function(){		// 자동실행함수를 정의

	//메소드를 정의
	// 매개변수 : reply, callback, error
	// reply : 댓글을 추가하기 위한 댓글정보 객체(bno, reply, replyer)
	// callback : get.jsp에서 응답을 받기 위해서 넣어준 함수
	// reply.js 에서 서버와 통신을 해서 받은 응당을 callback 함수를 통해 get.jsp에 전달
	// error : 서버와 통신해서 에러가 발생하면 처리하는 callback 함수를 받는다
	
	function add(reply,callback,error){
		console.log("add reply...............");

		$.ajax({
			type :'post', 
			url :'/replies/new',
			data : JSON.stringify(reply),			// reply 객체를 JSON 객체 문자열 형태로  전송
			contentType:"application/json; charset=utf-8",
			success:function(result,status,xhr){		// 서버와 통신을 성공하면 호출
				// get.jsp에서 callback 함수를 제공하면
				if(callback){callback(result);} 	// 결과를제공
			},
			error : function(xhr,status,er){	// 서버와 통신을 실패시 호출
				if(error){error(er);}
			}
		})
	}
	
	// 댓글 목록을 가져오는 메소드
	function getList(param,callback,error){
		var bno=param.bno;
		var page=param.page||1;
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",
			//data : PageReplyDTO (replyCnt, List<ReplyVO>)
			function(data){				// data : 댓글목록 (List<ReplyVO>)
				if(callback){
					// callback(data);		//댓글목록만가져오는경우
					callback(data.replyCnt, data.list); 	//댓글 숫자와 목록을 가져오는 경우
				}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	
	// 댓글 의 작성시간을 출력: 하루미만, 하루 이상인 경우를 나누어 출력
	function displayTime(timeValue){
		var today=new Date();
		var gap=today.getTime()-timeValue;
		var dateObj=new Date(timeValue);
		var str="";
		
		// 댓글을 작성한 시간이 하루미만이면 시간을 출력함
		if(gap<(1000*60*60*24)){
			var hh=dateObj.getHours();
			var mi=dateObj.getMinutes();
			var ss=dateObj.getSeconds();
			return[(hh>9?'':'0')+ hh,':',(mi>9?'':'0')+mi,
			':',(ss>9?'':'0')+ss].join('');
		}
		// 댓글을 작성한 시간이 하루 이상이면 날짜를 출력함
		else{	
			var yy=dateObj.getFullYear();
			var mm=dateObj.getMonth()+1;//getMonth()is zero-based
			var dd=dateObj.getDate();
			return[yy,'/',(mm>9?'':'0')+mm,'/',
			(dd>9?'':'0')+dd].join('');
		}
	}
	
	
	
	function get(rno, callback, error) {
		$.get("/replies/" + rno + ".json", function(result) {
			if(callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
	
	
	// 댓글 수정
	function update(reply, callback, error) {
		console.log("RNO: " + reply.rno);
		
		$.ajax({
			type: 'put',
			url: '/replies/' + reply.rno,
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
	
	function remove(rno, replyer, callback, error) {
		console.log("--------------------------------------");  
		console.log(JSON.stringify({rno:rno, replyer:replyer}));
		
		$.ajax({
			type: 'delete',
			url: '/replies/' + rno,
			data:  JSON.stringify({rno:rno, replyer:replyer}),
			contentType: "application/json; charset=utf-8",
						success: function(deleteResult, status, xhr) {
				if(callback) {
					callback(deleteResult);
				}
			},
			error: function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
			
	
			


	
	
	return{
		// add method를 추가
		// 첫번째 add : get.jsp 에서 호출하는 함수이름
		// 두번째 add : reply.js에서 동작하는 메소드이름
		add : add,	
		
		// getList:getList : 댓글 목록을 가져오는 메소드
		getList:getList,
				
		get: get,
		update: update,		
		remove: remove,
		
			
		// 작성 시간 정보를 가져 오는 메소드
		displayTime:displayTime
	};
})();