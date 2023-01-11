<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
<br>
<h3>사업 상세보기</h3>
<table class="type02">
	<tr>
		<th scope="row">CODE</th>
		<td class="middle">${detail.code}</td>
		<th scope="row">계약기간</th>
		<td class="middle"><fmt:formatDate pattern="yy-MM-dd" value="${detail.startterm}"/> ~ <fmt:formatDate pattern="yy/MM/dd" value="${detail.endterm}"/></td>
	</tr>
	<tr>
		<th scope="row">사업명/사업개요</th>
		<td class="middle">${detail.businessname}</td>
		<th scope="row">발주처</th>
		<td class="middle">${detail.client}</td>
	</tr>
	<tr>
		<th scope="row">전체사업금액(+)</th>
		<td class="right"><fmt:formatNumber value="${detail.plustotalbusinessamount}" pattern="#,###"/> 원</td>
		<th class="red" scope="row">전체사업금액(-)<br>(계약금액)</th>
		<td class="red right"><fmt:formatNumber value="${detail.minustotalbusinessamount}" pattern="#,###"/> 원</td>
	</tr>
	<tr>
		<th scope="row">지분율</th>
		<td class="middle"><fmt:formatNumber type="number" pattern="0.###" value="${detail.ratio}" />%</td>
		<th class="red" scope="row">매출금액(-)<br>(계약금액 * 지분율)</th>
		<td class="red right"><fmt:formatNumber value="${detail.salesamount}" pattern="#,###"/> 원</td>
	</tr>
	<tr>
		<th class="red" scope="row">수금잔여금액(-)</th>
		<td class="red right"><fmt:formatNumber value="${detail.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
		<th class="red" scope="row">수금완료금액(-)</th>
		<td class="red right"><fmt:formatNumber value="${detail.collectioncompletedamount}" pattern="#,###"/> 원</td>
	</tr>
</table>
<br>
<script type="text/javascript">
	function goForward() {
		history.go(-1);
	}
</script>
<button onclick="goForward()">목록으로</button>

<form action="/sm2/deleteBoard.do" method="post">
	<input type="hidden" name="year" value="${date.year}">
	<input type="hidden" name="idx" value="${detail.idx}">
	<button>삭제하기</button>
</form>

</body>
</html>