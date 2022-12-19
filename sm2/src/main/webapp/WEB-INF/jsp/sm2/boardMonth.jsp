<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<title>월별 사업 추가</title>
</head>
<body>
<h1>${month}월</h1>

<table class="type02">
	<tr>
		<th scope="row">CODE</th>
		<th scope="row">사업명/사업개요</th>
		<th scope="row">발주처</th>
		<th scope="row">전체사업금액(+)<br>(계약금액(+))</th>
		<th class="red" scope="row">전체사업금액(-)<br>(계약금액(-))</th>
		<th scope="row">매출금액</th>
		<th scope="row">비고</th>
	</tr>
	<c:forEach items="${list}" var="dto" varStatus="status">
		<tr>
			<td>${dto.CODE}</td>
			<td>
				<form action="detailBusiness" method="post">
					<input type="hidden" name="month" value="${month}">
					<input type="hidden" name="businessname" value="${dto.businessname}">
					<button>${dto.businessname}</button>
				</form>
			</td>
			<td>${dto.client}</td>
			<td><fmt:formatNumber value="${dto.plustotalbusinessamount}" pattern="#,###"/></td>
			<td class="red"><fmt:formatNumber value="${dto.minustotalbusinessamount}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${dto.salesamount}" pattern="#,###"/></td>
			<td>
				<form action="editCondition" method="post">
					<input type="hidden" name="month" value="${month}">
					<input type="hidden" name="businesscondition" value="${dto.businesscondition}">
					<input type="hidden" name="businessname" value="${dto.businessname}">
					<c:choose>
						<c:when test="${dto.businesscondition eq false}">
							<button>미완</button>
						</c:when>
						<c:otherwise>
							<button>완료</button>
						</c:otherwise>
					</c:choose>
				</form>
				<form action="nextMonth" method="post">
					<input type="hidden" name="month" value="${month}">
					<input type="hidden" name="businessname" value="${dto.businessname}">
					<button>이월</button>
				</form>
			</td>
		</tr>
	</c:forEach>
</table>

<form action="addMonthBusinessForm" method="post">
	<input type="hidden" name="month" value="${month}">
	<button>사업 추가</button>
</form>

</body>
</html>