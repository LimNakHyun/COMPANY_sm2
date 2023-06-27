<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/resources/js/login.js" charset="utf-8"></script>
	<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
	<meta charset="UTF-8">
	<title>EGIS 매출 관리 시스템</title>
	<!-- <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&display=swap" rel="stylesheet"> -->
</head>

<body>
	<!-- <form id="loginFrm">
		ID : <input type="text" id="userId">
		PW : <input type="password" id="userPw">
		<button type="submit" id="mainLogin">로그인</button>
		<button type="submit" id="mainLoginReset">리셋</button>
	</form> -->
	<div id="container" class="container">
		<!-- FORM SECTION -->
		<div class="row">
			<!-- SIGN UP -->
			<div class="col align-items-center flex-col sign-up">
				<div class="form-wrapper align-items-center">
					<div class="form sign-up">
						<div class="input-group">
							<i class='bx bxs-user'></i>
							<input type="text" placeholder="Username">
						</div>
						<div class="input-group">
							<i class='bx bx-mail-send'></i>
							<input type="email" placeholder="Email">
						</div>
						<div class="input-group">
							<i class='bx bxs-lock-alt'></i>
							<input type="password" placeholder="Password">
						</div>
						<div class="input-group">
							<i class='bx bxs-lock-alt'></i>
							<input type="password" placeholder="Confirm password">
						</div>
						<button>Sign up</button>
						<p>
							<span>Already have an account?</span>
							<b onclick="toggle()" class="pointer">
								Sign in here
							</b>
						</p>
					</div>
				</div>
			</div>
			<!-- END SIGN UP -->
			
			<!-- SIGN IN -->
			<div class="col align-items-center flex-col sign-in">
				<div class="form-wrapper align-items-center">
					<div class="form sign-in">
						<!-- <form id="loginFrm" method="POST" action="/openSm2MainLogin.do"> -->
							<div class="input-group">
								<i class='bx bxs-user'></i>
								<input type="text" placeholder="Username" id="userId" name="userId">
							</div>
							<div class="input-group">
								<i class='bx bxs-lock-alt'></i>
								<input type="password" placeholder="Password" id="userPw" name="userPw">
							</div>
							<button type="submit" id="mainLogin">로그인</button>
						<!-- </form> -->
						<!-- <button type="submit" id="mainLoginReset">리셋</button> -->
						<!-- <p>
							<b>Forgot password?</b>
						</p> -->
						<!--  <p>
							<span>계정이 없으신가요?</span>
							<b onclick="toggle()" class="pointer">여기서 회원가입</b>
						</p> -->
					</div>
				</div>
				<div class="form-wrapper"></div>
			</div>
			<!-- END SIGN IN -->
			
		</div>
		<!-- END FORM SECTION -->
		
		<!-- CONTENT SECTION -->
		<div class="row content-row">
			<!-- SIGN IN CONTENT -->
			<div class="col align-items-center flex-col">
				<div class="text sign-in">
					<h2>EABS 로그인</h2>
				</div>
				<div class="img sign-in"></div>
			</div>
			<!-- END SIGN IN CONTENT -->
			
			<!-- SIGN UP CONTENT -->
			<!-- <div class="col align-items-center flex-col">
				<div class="img sign-up"></div>
				<div class="text sign-up">
					<h2>계정추가</h2>
				</div>
			</div> -->
			<!-- END SIGN UP CONTENT -->
		</div>
		<!-- END CONTENT SECTION -->
	</div>
	<script type="text/javascript">
		let container = document.getElementById('container')
		
		/* function toggle(){
			container.classList.toggle('sign-in')
			container.classList.toggle('sign-up')
		} */
		
		/* setTimeout(() => {
			container.classList.add('sign-in')
		}, 200) */
		
		setTimeout(container.classList.add('sign-in'), 2000);
		/* container.classList.add('sign-in'); */
		
		var userPw = document.getElementById("userPw");
		userPw.addEventListener("keyup", function(e){
			if(e.keyCode === 13) {
				e.preventDefault();
				/*fn_loginBoardMain($(this));*/
				document.getElementById("mainLogin").click();
			}
			/*fn_loginBoardMain();*/
		});
		
		var userId = document.getElementById("userId");
		userId.addEventListener("keyup", function(e){
			if(e.keyCode === 13) {
				e.preventDefault();
				/*fn_loginBoardMain($(this));*/
				document.getElementById("mainLogin").click();
			}
			/*fn_loginBoardMain();*/
		});
	</script>
	<%@ include file="/WEB-INF/include/body.jsp" %>
</body>
</html>