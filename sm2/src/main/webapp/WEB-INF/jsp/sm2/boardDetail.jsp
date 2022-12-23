<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<title>사업 항목</title>
</head>
<body>

<table class="type02">
	<tr>
		<th scope="row">CODE</th>
		<td>${detail.code}</td>
	</tr>
	<tr>
		<th scope="row">사업명/사업개요</th>
		<td>${detail.businessname}</td>
	</tr>
	<tr>
		<th scope="row">발주처</th>
		<td>${detail.client}</td>
	</tr>
	<tr>
		<th scope="row">계약기간</th>
		<td><fmt:formatDate pattern="yy-MM-dd" value="${detail.startterm}"/> ~ <fmt:formatDate pattern="yy-MM-dd" value="${detail.endterm}"/></td>
	</tr>
	<tr>
		<th scope="row">전체사업금액(+)</th>
		<td><fmt:formatNumber value="${detail.plustotalbusinessamount}" pattern="#,###"/></td>
	</tr>
	<tr>
		<th class="red" scope="row">전체사업금액(-)<br>(계약금액)</th>
		<td class="red"><fmt:formatNumber value="${detail.minustotalbusinessamount}" pattern="#,###"/></td>
	</tr>
	<tr>
		<th scope="row">지분율</th>
		<td><fmt:formatNumber type="number" pattern="0.###" value="${detail.ratio}" />%</td>
	</tr>
	<tr>
		<th class="red" scope="row">매출금액(-)<br>(계약금액 * 지분율)</th>
		<td class="red"><fmt:formatNumber value="${detail.salesamount}" pattern="#,###"/></td>
	</tr>
	<tr>
		<th class="red" scope="row">수금완료금액(-)</th>
		<td class="red"><fmt:formatNumber value="${detail.collectioncompletedamount}" pattern="#,###"/></td>
	</tr>
	<tr>
		<th class="red" scope="row">총 수금잔여금액(-)<br>(매출금액 - 수금완료금액)</th>
		<td class="red"><fmt:formatNumber value="${detail.totalcollectionremainingamount}" pattern="#,###"/></td>
	</tr>
</table>

</body>
</html>