<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<title>월별 사업 추가</title>
</head>
<body>
<form action="/sm2/insertSm2Month.do">
	<input type="hidden" name="month" value="${month}">
	<table class="type02">
		<tr>
			<th><label>사업 선택</label></th>
			<td scope="row">
				<select name="businessname">
					<option value="none" hidden>사업 선택</option>
					<c:forEach items="${selectboxList}" var="boxlist" varStatus="status">
						<option value="${boxlist.businessname}">${boxlist.businessname}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th><label>매출금액(-)</label></th>
			<td scope="row">
				<input type="number" name="salesamount">
			</td>
		</tr>
	</table>
	<button>사업 추가</button>
</form>
</body>
</html>