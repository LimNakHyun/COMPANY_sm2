/**
 * 
 */

$(document).ready(function(){
	// 메인화면에서 로그인
	$("#mainLogin").on("click", function(e){
		e.preventDefault();
		fn_loginBoardMain($(this));
		/*fn_loginBoardMain();*/
	});
	
	// 메인 로그인페이지 리셋
//	$("#mainLoginReset").on("click", function(e){
//		e.preventDefault();
//		if(confirm('리셋하시겠습니까?\n입력한 모든 정보가 사라집니다.')) {
//			fn_mainLoginResetUpdate();
//		} else{
//			return false;
//		}
//	});
});

// 메인화면에서 로그인
function fn_loginBoardMain(obj){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/openSm2MainLogin.do");
	var userid = obj.parent().find("#userId").val();
	var userpw = obj.parent().find("#userPw").val();
	
	var noEngRule = /[a-zA-Z0-9]+/;
	if(!noEngRule.test(userid)){
		alert("아이디를 입력해주세요.");
	} else if(noEngRule.test(userid) && !noEngRule.test(userpw)){
		alert("비밀번호를 입력해주세요.");
	} else {
		var noSpaceRule = /[\s]+/;
		if(noSpaceRule.test(userid) || noSpaceRule.test(userpw)){
			alert("아이디나 비밀번호에 공백이 존재해서는 안됩니다.");
		} else {
			if(getUserInfo(userid, userpw) == "idError"){
				alert("존재하지 않는 아이디입니다.");
			} else if(getUserInfo(userid, userpw) == "pwError"){
				alert("존재하지 않는 비밀번호입니다.");
			} else {
				comSubmit.addParam("id", obj.parent().find("#userId").val());
				comSubmit.addParam("pw", obj.parent().find("#userPw").val());
				comSubmit.submit();
			}
		}
	}
	
}

// 사용자 정보 호출
function getUserInfo(userId, userPw){
	var result = "";
	
	$.ajax({
		type: "POST",
		url: "/openSm2LoginAjax.do",
		async: false,
		data: {
			userId : userId
		},
		dataType: "json",
		success: function(data){
			
			if((data.userInfo == '') || (data.userInfo == null) || (data.userInfo == undefined) 
					|| (data.userInfo == 0) || (data.userInfo == NaN)){
				result = "idError";
			} else if(data.userInfo.userpw != userPw){
				result = "pwError";
			}
			
		}
	});
	return result;
}

// 메인 로그인페이지 리셋
//function fn_mainLoginResetUpdate(){
//	document.getElementById("loginFrm").reset();
//}

