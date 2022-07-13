function loginChk() {
    var form = document.login;
    if (!form.username.value) {
        alert("아이디를 입력해 주십시오.");
        form.username.focus();
        return false;
    }
 
    if (!form.password.value) {
        alert("비밀번호를 입력해 주십시오.");
        form.password.focus();
        return false;
    }
    return true;
}







function joinCheck() {
   if (document.frm.id.value.length == 0) {
      alert("아이디를 입력해주세요");
      frm.id.focus();
      return false;
   }   
   var idRegExp  = /^[a-zA-z0-9]/;
   if(!idRegExp.test(document.frm.id.value)){
      alert("아이디는 영문 4글자 이상이어야 합니다.(한글 사용불가)");
      frm.id.focus();
      return false;
   }
   if (document.frm.id.value.length < 4) {
      alert("아이디는 4글자이상이어야 합니다.");
      frm.id.focus();
      return false;
   }
   if (document.frm.pw.value == "") {
      alert("암호를 입력해주세요.");
      frm.pw.focus();
      return false;
   }
   
   
   if (document.frm.reid.value.length == 0) {
      alert("중복 체크를 하지 않았습니다.");
      frm.id.focus();
      return false;
   }
   if (document.frm.name.value.length == 0) {
      alert("이름을 입력해주세요.");
      frm.name.focus();
      return false;
   }
   return true;
}



function idCheck() {
   if(document.frm.id.value == "") {
      alert("아이디를 입력하여 주십시요.");
      document.frm.id.focus();   
      return;
   }
   
   var idRegExp  = /^[a-zA-z0-9]/;
   if(!idRegExp.test(document.frm.id.value)){
      alert("아이디는 영문 4글자 이상이어야 합니다.(한글 사용불가)");
      frm.id.focus();
      return false;
   }
   
   var url = "idCheck?userid=" + document.frm.id.value;
   window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=450, height=200");
   
}


function idok() {
   opener.frm.userid.value = document.frm.userid.value;
   opener.frm.reid.value = document.frm.userid.value;
   self.close();   
}