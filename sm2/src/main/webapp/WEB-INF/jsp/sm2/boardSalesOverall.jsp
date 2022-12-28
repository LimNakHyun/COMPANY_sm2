<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
<br>
	<div class="overall">
	
		<h3>${date.year}년 (주)이지스 사업 매출 현황 보고</h3>
	
		<table class="type04">
			<c:forEach items="${list}" var="dto">
				<tr>
					<th>${dto.month}월 매출액</th>
					<td class="money"><fmt:formatNumber value="${dto.amount}" pattern="#,###"/></td>
					<td class="won">원</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>