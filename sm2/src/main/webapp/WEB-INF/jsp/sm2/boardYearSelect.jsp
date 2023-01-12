<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>EGIS 매출 관리 시스템</title>
	<link href="${pageContext.request.contextPath}/resources/css/contents.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div id="wrapper" class="main_wrap">
		<div class="main_year_select">
			<h1 class="logo"><img class="egis_logo" src='${pageContext.request.contextPath}/resources/images/logo.svg'
					alt="이지스"></h1>
			<div class="main_year_wrap">
				<h2>이지스 매출 관리 시스템</h2>
				<form name="frm" action="/sm2/openSm2List.do" method="post">
					<div class="main_year_select_box">
						<select name="year">
							<option value="none" hidden>연도</option>
							<option value="2021">2021년</option>
							<option value="2022">2022년</option>
							<option value="2023">2023년</option>
							<option value="2024">2024년</option>
							<option value="2025">2025년</option>
							<option value="2026">2026년</option>
						</select>
					</div>
					<div class="main_btn_box">
						<button type="submit" class="year_select_btn" onclick="return checkFrm();">선택</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
		function checkFrm(){
			if(document.frm.year.value == "none"){
				alert("연도를 선택해 주세요.");
				return false;
			}
		}
	</script>
</body>

</html>