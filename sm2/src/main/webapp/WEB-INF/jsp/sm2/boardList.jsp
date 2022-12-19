<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<title>매출총괄현황</title>
</head>
<body>
<h1>
	이지스 2021년 사업실적(매출세금계산서 기준)
</h1>

<table class="type02">
	<tr>
		<th scope="row">CODE</th>
		<th scope="row">사업명/사업개요</th>
		<th scope="row">발주처</th>
		<th scope="row">계약기간</th>
		<th scope="row">전체사업금액(+)</th>
		<th class="red" scope="row">전체사업금액(-)<br>(계약금액)</th>
		<th scope="row">지분율</th>
		<th class="red" scope="row">매출금액(-)<br>(계약금액 * 지분율)</th>
		<th class="red" scope="row">수금완료금액(-)</th>
		<th class="red" scope="row">총 수금잔여금액(-)<br>(매출금액 - 수금완료금액)</th>
		<th scope="row">비고</th>
	</tr>
	<c:forEach items="${list}" var="dto" varStatus="status">
		<tr>
			<td>${dto.code}</td>
			<td>
				<form action="/sm2/openSm2Detail.do" method="post">
					<button>${dto.businessname}</button>
					<input type="hidden" name="businessname" value="${dto.businessname}">
				</form>
			</td>
			<td>${dto.client}</td>
			<td><fmt:formatDate pattern="yy-MM-dd" value="${dto.startterm}"/> ~ <fmt:formatDate pattern="yy-MM-dd" value="${dto.endterm}"/></td>
			<td><fmt:formatNumber value="${dto.plustotalbusinessamount}" pattern="#,###"/></td>
			<td class="red"><fmt:formatNumber value="${dto.minustotalbusinessamount}" pattern="#,###"/></td>
			<td><fmt:formatNumber type="number" pattern="0.###" value="${dto.ratio}" />%</td>
			<td class="red"><fmt:formatNumber value="${dto.salesamount}" pattern="#,###"/></td>
			<td class="red"><fmt:formatNumber value="${dto.collectioncompletedamount}" pattern="#,###"/></td>
			<td class="red"><fmt:formatNumber value="${dto.totalcollectionremainingamount}" pattern="#,###"/></td>
			<td>
				<c:choose>
					<c:when test="${dto.businesscondition eq true}">
						완료
					</c:when>
					<c:otherwise>
						미완료
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</c:forEach>
</table>

<form action="/sm2/openSm2Write.do">
	
	<button>사업 추가</button>
</form>

<%@ include file="/WEB-INF/include/include-body.jspf" %>

</body>
</html>
