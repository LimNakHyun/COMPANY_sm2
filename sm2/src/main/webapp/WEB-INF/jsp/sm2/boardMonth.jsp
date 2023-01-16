<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">

	<h2 class="cont_tit">${date.year}년 ${date.month}월</h2>
	
	<div class="cont_top">
		<div class="dashboard_box">
			<div class="dashboard_item">
				<strong class="ds_tit">${date.month}월 계약매출 합계</strong>
				<span class="ds_num"><fmt:formatNumber value="${collectioncashsum.collectioncashsum}" pattern="#,###"/> 원</span>
			</div>
		</div>
	</div>
	
	<div class="cont_body">
	
		<table class="tbl_basic tbl_list">
			<caption>${date.year}년 ${date.month}월</caption>
			<colgroup>
				<col style="width:4%;">
				<col style="width:51%;">
				<col style="width:12%;">
				<col style="width:9%;">
				<col style="width:9%;">
				<col style="width:9%;">
				<col style="width:6%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">CODE</th>
					<th scope="col">사업명/사업개요</th>
					<th scope="col">발주처</th>
					<th scope="col">매출금액</th>
					<th scope="col">수금잔여금액(-)</th>
					<th scope="col">사업수금액</th>
					<th scope="col">수금완료하기</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${empty list}">
				<td colspan="11">등록된 사업이 없습니다.</td>
			</c:if>
			<c:forEach items="${list}" var="dto" varStatus="status">
				<tr>
					<td class="middle">${dto.code}</td>
					<td class="middle">
						<form action="/sm2/openSm2MonthDetail.do" method="post">
							<input type="hidden" name="month" value="${date.month}">
							<input type="hidden" name="year" value="${date.year}">
							<input type="hidden" name="businessname" value="${dto.businessname}">
							<input type="hidden" name="monthidx" value="${dto.monthidx}">
							<input type="hidden" name="idx" value="${dto.idx}">
							<button class="noborder">${dto.businessname}</button>
						</form>
					</td>
					<td class="middle">${dto.client}</td>
					<td class="right">
						<fmt:formatNumber value="${dto.salesamount}" pattern="#,###"/> 원</td>
					<td class="right">
						<fmt:formatNumber value="${dto.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
					<td class="right red">
						<fmt:formatNumber value="${dto.collectioncash}" pattern="#,###"/> 원</td>
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
									<button class="red_txt">미완</button>
								</c:when>
								<c:otherwise>
									<button class="blue_txt">완료</button>
								</c:otherwise>
							</c:choose>
						</form>
					</td>
				</tr>
			</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<th class="middle sum" colspan='5'>${date.month}월 계약매출 합계</th>
					<td class="right sum">
						<fmt:formatNumber value="${collectioncashsum.collectioncashsum}" pattern="#,###"/> 원</td>
					<td class="sum"></td>
				</tr>
			</tfoot>
		</table>
		<div class="btn-group">
			<form action="/sm2/openSm2MonthWrite.do" method="post">
				<input type="hidden" name="month" value="${date.month}">
				<input type="hidden" name="year" value="${date.year}">
				<button type="submit" class="btn btn-basic">사업 추가</button>
			</form>
		</div>
	</div>
</div>