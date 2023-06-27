/**
 * 
 */

$(document).ready(function(){
	// 메인화면에서 로그인
	$("#mainLogin").on("click", function(e){
//		e.preventDefault();
//		fn_loginBoardMain($(this));
		getUserInfo($(this));
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
function getUserInfo(obj){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/openSm2MainLogin.do");
	var userId = obj.parent().find("#userId").val();
	var userPw = obj.parent().find("#userPw").val();
	var result = "default";
	var noSpaceRule = /[\s]+/;
	if(noSpaceRule.test(userId) || noSpaceRule.test(userPw)){
		alert("아이디나 비밀번호에 공백이 존재해서는 안됩니다.");
	} else {
		var noEngRule = /[a-zA-Z0-9]+/;
		if(!noEngRule.test(userId)){
			alert("아이디를 입력해주세요.");
		} else if(noEngRule.test(userId) && !noEngRule.test(userPw)){
			alert("비밀번호를 입력해주세요.");
		} else {
			$.ajax({
				type: "POST",
				url: "/openSm2LoginAjax.do",
				async: false,
				data: {
					userId : userId,
					userPw : userPw
				},
				dataType: "json",
				success: function(data){
					if(data.msg == "idError"){
						alert("존재하지 않는 아이디입니다.");
					} else if(data.msg == "pwError"){
						alert("존재하지 않는 비밀번호입니다.");
					} else if(data.msg == "success") {
						comSubmit.addParam("userId", data.ID);
						comSubmit.addParam("userPw", data.PW);
						comSubmit.submit();
					}
				}
			});
		}
	}
}

// 메인 로그인페이지 리셋
//function fn_mainLoginResetUpdate(){
//	document.getElementById("loginFrm").reset();
//}

