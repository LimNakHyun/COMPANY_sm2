<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<meta charset="UTF-8">
</head>
<body>
<br>
<h3>
	사업 추가
</h3>

<form action="/sm2/insertSm2.do" method="post">
	<table class="type02">
	
		<tr>
			<th><label>코드선택</label></th>
			<td scope="row">
				<select name="CODE">
					<option value="none" hidden>== 선택 ==</option>
					<option value="유지보수">유지보수</option>
					<option value="구축">구축</option>
					<option value="구독">구독</option>
					<option value="SI">SI</option>
					<option value="컨설팅">컨설팅</option>
					<option value="DB구축">DB구축</option>
				</select>
			</td>
		</tr>
		<tr>
			<th><label>사업명/사업개요</label></th>
			<td scope="row">
				<input type="text" name="businessname" required="required">
			</td>
		</tr>
		<tr>
			<th><label>발주처</label></th>
			<td scope="row">
				<input type="text" name="client" required="required">
			</td>
		</tr>
		<tr>
			<th><label>계약 기간</label></th>
			<td scope="row">
				<input type="date" name="strstartterm"> ~ 
				<input type="date" name="strendterm">
			</td>
		</tr>
		<tr>
			<th><label>전체사업금액</label></th>
			<td scope="row">
				<input type="number" name="plustotalbusinessamount">
			</td>
		</tr>
		<tr>
			<th><label>지분율</label></th>
			<td scope="row">
				<input type="number" name="ratio" min="0" max="100" step="0.01"> %
			</td>
		</tr>
		
	
	</table>
	
	<br>
	<input type="hidden" name="year" value="${date.year}">
	<button type="submit">추가</button>
</form>

</body>
</html>