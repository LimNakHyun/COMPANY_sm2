<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<title>월별 사업 추가</title>
</head>
<body>
<br>
<h3>${date.year}년 ${date.month}월</h3>

<table class="type03">
	<tr>
		<th class="middle code" scope="row">CODE</th>
		<th class="middle name" scope="row">사업명/사업개요</th>
		<th class="middle client" scope="row">발주처</th>
		<th class="red amount" scope="row">매출금액</th>
		<th class="middle amount">수금잔여금액(-)</th>
		<th class="middle amount" scope="row">사업수금액</th>
		<th class="middle note" scope="row">수금완료하기</th>
	</tr>
	<c:forEach items="${list}" var="dto" varStatus="status">
		<tr>
			<td class="middle">${dto.code}</td>
			<td class="middle">
				<form action="detailBusiness" method="post">
					<input type="hidden" name="month" value="${date.month}">
					<input type="hidden" name="year" value="${date.year}">
					<input type="hidden" name="businessname" value="${dto.businessname}">
					<button class="noborder">${dto.businessname}</button>
				</form>
			</td>
			<td class="middle">${dto.client}</td>
			<td class="right"><fmt:formatNumber value="${dto.salesamount}" pattern="#,###"/> 원</td>
			<td class="right"><fmt:formatNumber value="${dto.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
			<td class="right red"><fmt:formatNumber value="${dto.collectioncash}" pattern="#,###"/> 원</td>
			<td class="middle">
				<form action="/sm2/updateSm2Month.do" method="post">
					<input type="hidden" name="month" value="${date.month}">
					<input type="hidden" name="year" value="${date.year}">
					<input type="hidden" name="idx" value="${dto.idx}">
					<input type="hidden" name="monthidx" value="${dto.monthidx}">
					<input type="hidden" name="collectioncash" value="${dto.collectioncash}">
					<input type="hidden" name="monthbusinesscondition" value="${dto.monthbusinesscondition}">
					<c:choose>
						<c:when test="${dto.monthbusinesscondition eq false}">
							<button class="notered">미완</button>
						</c:when>
						<c:otherwise>
							<button class="noteblue">완료</button>
						</c:otherwise>
					</c:choose>
				</form>
			</td>
		</tr>
	</c:forEach>
</table>
<br>

<form action="/sm2/openSm2MonthWrite.do" method="post">
	<input type="hidden" name="month" value="${date.month}">
	<input type="hidden" name="year" value="${date.year}">
	<button>사업 추가</button>
</form>

</body>
</html>