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
		<!-- <th scope="row">전체사업금액(+)<br>(계약금액(+))</th> -->
		<!-- <th class="red" scope="row">전체사업금액(-)<br>(계약금액(-))</th> -->
		<th class="red" scope="row">매출금액</th>
		<th scope="row">사업수금액</th>
		<th scope="row">수금완료하기</th>
	</tr>
	<c:forEach items="${list}" var="dto" varStatus="status">
		<tr>
			<td>${dto.code}</td>
			<td>
				<form action="detailBusiness" method="post">
					<input type="hidden" name="month" value="${month}">
					<input type="hidden" name="businessname" value="${dto.businessname}">
					<button>${dto.businessname}</button>
				</form>
			</td>
			<td>${dto.client}</td>
			<%-- <td><fmt:formatNumber value="${dto.plustotalbusinessamount}" pattern="#,###"/></td> --%>
			<%-- <td class="red"><fmt:formatNumber value="${dto.minustotalbusinessamount}" pattern="#,###"/></td> --%>
			<td class="red"><fmt:formatNumber value="${dto.salesamount}" pattern="#,###"/> 원</td>
			<td><fmt:formatNumber value="${dto.collectioncash}" pattern="#,###"/> 원</td>
			<td>
				<form action="/sm2/updateSm2Month.do">
					<input type="hidden" name="month" value="${month}">
					<input type="hidden" name="idx" value="${dto.idx}">
					<input type="hidden" name="monthidx" value="${dto.monthidx}">
					<input type="hidden" name="collectioncash" value="${dto.collectioncash}">
					<input type="hidden" name="monthbusinesscondition" value="${dto.monthbusinesscondition}">
					<c:choose>
						<c:when test="${dto.monthbusinesscondition eq false}">
							<button>미완</button>
						</c:when>
						<c:otherwise>
							<button>완료</button>
						</c:otherwise>
					</c:choose>
				</form>
				
				<%-- <form action="nextMonth" method="post">
					<input type="hidden" name="month" value="${month}">
					<input type="hidden" name="businessname" value="${dto.businessname}">
					<button>이월</button>
				</form> --%>
			</td>
		</tr>
	</c:forEach>
</table>

<form action="/sm2/openSm2MonthWrite.do">
	<input type="hidden" name="month" value="${month}">
	<button>사업 추가</button>
</form>

</body>
</html>