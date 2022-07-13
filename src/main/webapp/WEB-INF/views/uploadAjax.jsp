<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax를 사용한 파일 업로드</title>
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
}
.uploadResult ul li img {
	width: 20px;
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
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
.bigPicture img {
  width: 600px;
}


</style>
</head>
<body>
	<h1>Upload with Ajax</h1>
	<!-- 원본이미지를 보여주는 영역 -->
	<div class="bigPictureWrapper">
		<div class='bigPicture'>
		</div>
	</div>	
	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>
	<div class='uploadResult'>
		<ul><!-- 첨부 파일의 이름을 목록으로 출력 -->
		</ul>
	</div>
	<button id='uploadBtn'>Upload</button>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous">
</script>
<script>
function showImage(fileCallPath) {
	//alert(fileCallPath);
	$(".bigPictureWrapper").css("display","flex").show();
	  
	$(".bigPicture")
		.html("<img src='/display?fileName="+ encodeURI(fileCallPath)+"'>")
		.animate({width:'100%', height: '100%'}, 1000);

}

$(document).ready(function(){
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;	// 5MB
	  
	function checkExtension(filename, filesize) {
		if(filesize > maxSize) {			// 파일의 크기 제한
			alert("파일 크기 초과");
			return false;
		}
		if(regex.test(filename)) {		// 확장자 제한
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}

	// file input 태그를 감싸는 div(line 11) 박스를 복사
	var cloneObj = $(".uploadDiv").clone(); 
	
	$("#uploadBtn").on("click", function(e){
		var formData = new FormData();		// 가상의 <form> 태그
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
		//add filedate to formdata
		for(var i = 0; i < files.length; i++) {
			// 크기 제한이나 확장자 제한을 통과한 파일만 전송하도록 검사
		  if(!checkExtension(files[i].name, files[i].size)) {
			  return false;
		  }
		  formData.append("uploadFile", files[i]);
		}

		$.ajax({
		  url: '/uploadAjaxAction',
		  processData: false,
		  contentType: false,
		  data: formData,
		  type: 'POST',
		  dataType: 'json',
		  success: function(result){	// result에는 List<AttachFileDTO>가 온다
			console.log(result);
		    //alert("Uploaded");
		    // file input 태그를 초기화해서 다시 첨부파일을 추가할 수 있도록 준비
			showUploadedFile(result);
		    $(".uploadDiv").html(cloneObj.html());
		  }
		}); //$.ajax	
	});
	
	var uploadResult = $(".uploadResult ul");  		// 업로드 파일의 정보를 나타내는 <ul>태그
	function showUploadedFile(uploadResultArr) {	// 업로르 된 파일의 이름을 <li> 태그를 사용해 출력
	  var str = "";
	  $(uploadResultArr).each(function(i, obj) {	// uploadResultArr = List<AttachFileDTO> list
		  if(!obj.image) { // 일반파일
			  var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
			  str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>" +
				"<img src='/resources/img/attach.png'>"	+ obj.fileName + "</a>" +
				"<span data-file=\'" + fileCallPath + "\' data-type='file'> x </span>" +
				"</div></li>";

		  //str += "<li><a href='/download?fileName=" + fileCallPath + "'>" + "<img src='/resources/img/attach.png'>"	+ obj.fileName + "</a></li>";
		  //			+ obj.fileName + "</li>";
		  } else {	// 이미지 파일 -> 절대경로를 이용해서 접근 -> display url(controller)을 통해서 접근
			  //str += "<li>" + obj.fileName + "</li>";	// obj : AttachFileDTO
			  //var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			  var fileCallPath = encodeURIComponent(obj.uploadPath + obj.uuid + "_" + obj.fileName);
			  var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
			  originPath = originPath.replace(new RegExp(/\\/g), "/");
			  str += "<li><a href=\"javascript:showImage(\'" + originPath +
				"\')\"><img src='/display?fileName=" + fileCallPath + "'></a>" +
				"<span data-file=\'" + fileCallPath + "\' data-type='image'> x </span>"
				+ "</li>";
		  }
	  });
	  uploadResult.append(str);		// <ul> 태그 밑에 <li> 태그로 업로든 파일의 이름을 나열
	}
	
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		setTimeout(function() {
			$(".bigPictureWrapper").hide();
		}, 500);

	});
	
	// 삭제 버튼이 눌리면 동작
	$(".uploadResult").on("click","span", function(e){
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		$.ajax({
		    url: '/deleteFile',
		    data: {fileName: targetFile, type:type},
		    dataType:'text',
		    type: 'POST',
		      success: function(result){
		         alert(result);
		      }
		}); //$.ajax  
	});


});
</script>

</body>
</html>