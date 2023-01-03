<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
<br>
<h3>
	이지스 ${date.year}년 사업실적(매출세금계산서 기준)
</h3>

<table class="type01">
	<thead>
		<tr class="amount">
			<th class="middle sum" colspan='4'>사업금액 합계</th>
			<th class="right allAmount sum"><fmt:formatNumber value="${amount.plustotalbusinessamountsum}" pattern="#,###"/> 원</th>
			<th class="right allAmount sum"><fmt:formatNumber value="${amount.minustotalbusinessamountsum}" pattern="#,###"/> 원</th>
			<td class="code middle sum">-</td>
			<th class="right amount sum"><fmt:formatNumber value="${amount.salesamountsum}" pattern="#,###"/> 원</th>
			<th class="right amount sum"><fmt:formatNumber value="${amount.collectioncompletedamountsum}" pattern="#,###"/> 원</th>
			<th class="right amount sum"><fmt:formatNumber value="${amount.totalcollectionremainingamountsum}" pattern="#,###"/> 원</th>
			<td class="note middle sum">-</td>
		</tr>
	</thead>
	<thead>
		<tr>
			<th class="middle code">CODE</th>
			<th class="middle name">사업명/사업개요</th>
			<th class="middle client">발주처</th>
			<th class="middle date">계약기간</th>
			<th class="middle allAmount">전체사업금액(+)</th>
			<th class="middle allAmount">전체사업금액(-)<br>(계약금액)</th>
			<th class="middle code">지분율</th>
			<th class="middle amount">매출금액(-)<br>(계약금액 * 지분율)</th>
			<th class="middle amount">수금완료금액(-)</th>
			<th class="middle amount">수금잔여금액(-)</th>
			<th class="middle note">비고</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${list}" var="dto" varStatus="status">
		<tr>
			<td class="middle">${dto.code}</td>
			<td class="middle">
				<form action="/sm2/openSm2Detail.do" method="post">
					<button>${dto.businessname}</button>
					<input type="hidden" name="businessname" value="${dto.businessname}">
					<input type="hidden" name="year" value="${date.year}">
				</form>
			</td>
			<td class="middle">${dto.client}</td>
			<td class="middle"><fmt:formatDate pattern="yy/MM/dd" value="${dto.startterm}"/> ~ <fmt:formatDate pattern="yy/MM/dd" value="${dto.endterm}"/></td>
			<td class="right"><fmt:formatNumber value="${dto.plustotalbusinessamount}" pattern="#,###"/> 원</td>
			<td class="right red"><fmt:formatNumber value="${dto.minustotalbusinessamount}" pattern="#,###"/> 원</td>
			<td class="middle"><fmt:formatNumber type="number" pattern="0.###" value="${dto.ratio}" />%</td>
			<td class="right red"><fmt:formatNumber value="${dto.salesamount}" pattern="#,###"/> 원</td>
			<td class="right red"><fmt:formatNumber value="${dto.collectioncompletedamount}" pattern="#,###"/> 원</td>
			<td class="right red"><fmt:formatNumber value="${dto.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
			<td class="middle">
				<c:choose>
					<c:when test="${dto.businesscondition eq true}">
						<label class="blue">완료</label>
					</c:when>
					<c:otherwise>
						<label class="notered">미완</label>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<br>

<form action="/sm2/openSm2Write.do" method="post">
	<input type="hidden" name="year" value="${date.year}">
	<button>사업 추가</button>
</form>

<%@ include file="/WEB-INF/include/include-body.jspf" %>

</body>
</html>
