<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출관리 시스템</title>
</head>
<body>
	<h3>이지스 매출관리 시스템</h3>
	
	<div>
		<form action="/sm2/openSm2List.do" method="post">
			<select name="year">
				<option value="none" hidden>== 연도 선택 ==</option>
				<option value="2021">2021년</option>
				<option value="2022">2022년</option>
				<option value="2023">2023년</option>
				<option value="2024">2024년</option>
				<option value="2025">2025년</option>
				<option value="2026">2026년</option>
			</select>
			<button>관리할 연도 입력</button>
		</form>
	</div>
</body>
</html>