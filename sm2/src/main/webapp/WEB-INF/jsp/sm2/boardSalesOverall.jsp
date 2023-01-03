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
			<c:forEach items="${list}" var="dto" varStatus="idx">
				<tr>
					<c:choose>
						<c:when test="${dto.monthstr ne null}">
							<th>${dto.monthstr} 매출액</th>
							<td class="money"><fmt:formatNumber value="${dto.amount}" pattern="#,###"/></td>
							<td class="won">원</td>
						</c:when>
						<c:when test="${dto.quarter ne null}">
							<th class="quarter">${dto.quarter} 매출액</th>
							<td class="quarter"><fmt:formatNumber value="${dto.quarteramount}" pattern="#,###"/></td>
							<td class="won quarter">원</td>
						</c:when>
						<c:when test="${idx.index eq 16}">
							<th class="all">${dto.all} (${date.year + 1}년 01월 01일 기준)</th>
							<td class="money"><fmt:formatNumber value="${dto.allamount}" pattern="#,###"/></td>
							<td class="won">원</td>
						</c:when>
					</c:choose>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>