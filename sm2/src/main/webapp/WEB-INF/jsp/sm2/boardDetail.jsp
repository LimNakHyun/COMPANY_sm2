<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">

	<div class="cont_body">

	<form id="frm">
		<h2 class="cont_tit">${detail.businessname} 상세보기</h2>
		<table class="tbl_basic tbl_view">
			<caption>${detail.businessname} 상세보기</caption>
			<colgroup>
				<col style="width:15%;">
				<col style="width:35%;">
				<col style="width:15%;">
				<col style="width:35%;">
			</colgroup>
			<tr>
				<th scope="row">CODE</th>
				<td>${detail.code}</td>
				<th scope="row">계약기간</th>
				<td>
					<fmt:formatDate pattern="yyyy년 MM월 dd일" value="${detail.startterm}"/> ~
					<fmt:formatDate pattern="yyyy년 MM월 dd일" value="${detail.endterm}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">사업명/사업개요</th>
				<td>${detail.businessname}</td>
				<th scope="row">발주처</th>
				<td>${detail.client}</td>
			</tr>
			<tr>
				<th scope="row">전체사업금액(+)</th>
				<td>
					<fmt:formatNumber value="${detail.plustotalbusinessamount}" pattern="#,###"/> 원</td>
				<th scope="row">전체사업금액(-)<br>(계약금액)</th>
				<td class="red_txt">
					<fmt:formatNumber value="${detail.minustotalbusinessamount}" pattern="#,###"/> 원</td>
			</tr>
			<tr>
				<th scope="row">지분율</th>
				<td>
					<fmt:formatNumber type="number" pattern="0.###" value="${detail.ratio}" />%</td>
				<th scope="row">매출금액(-)<br>(계약금액 * 지분율)</th>
				<td class="red_txt">
					<fmt:formatNumber value="${detail.salesamount}" pattern="#,###"/> 원</td>
			</tr>
			<tr>
				<th scope="row">수금잔여금액(-)</th>
				<td class="red_txt">
					<fmt:formatNumber value="${detail.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
				<th scope="row">수금완료금액(-)</th>
				<td class="red_txt">
					<fmt:formatNumber value="${detail.collectioncompletedamount}" pattern="#,###"/> 원</td>
			</tr>
		</table>
		
		<input type="hidden" name="idx" value="${detail.idx}">
		<br>
	</form>
	
	<form id="frm2">
		<div class="cont_body">
		
			<table class="tbl_basic tbl_list">
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
				<c:if test="${empty monthDetails}">
					<td colspan="11">등록된 사업이 없습니다.</td>
				</c:if>
				<c:forEach items="${monthDetails}" var="monthDetail" varStatus="status">
								
					<tr>
						<td class="middle">${monthDetail.code}</td>
						<td class="middle">
							<a href="#this" class="noborder" name="detailTitle">[${monthDetail.businessmonth}월] ${monthDetail.businessname}</a>
							<input type="hidden" id="monthidx" name="monthidx" value="${monthDetail.monthidx}">
						</td>
						<td class="middle">${monthDetail.client}</td>
						<%-- <td class="right">${monthDetail.businessmonth}월</td> --%>
						<td class="right">
							<fmt:formatNumber value="${monthDetail.salesamount}" pattern="#,###"/> 원</td>
						<td class="right">
							<fmt:formatNumber value="${monthDetail.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
						<td class="right red_txt">
							<fmt:formatNumber value="${monthDetail.collectioncash}" pattern="#,###"/> 원</td>
						<td class="middle">
							<input type="hidden" id="idx" name="idx" value="${detail.idx}">
							<input type="hidden" id="monthidx" name="monthidx" value="${monthDetail.monthidx}">
							<input type="hidden" id="collectioncash" name="collectioncash" value="${monthDetail.collectioncash}">
							<input type="hidden" id="monthbusinesscondition" name="monthbusinesscondition" value="${monthDetail.monthbusinesscondition}">
							<c:choose>
								<c:when test="${monthDetail.monthbusinesscondition eq false}">
									<a class="red_txt" href="#this" name="detailMonthConditionGo" title="사업 완료하기">미완</a>
								</c:when>
								<c:otherwise>
									<a class="blue_txt" href="#this" name="detailMonthConditionBack" title="사업 되돌리기">완료</a>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					
				</c:forEach>
				</tbody>
				<tfoot>
					<c:choose>
						<c:when test="${month eq 13}">
							<tr>
								<th class="middle sum" colspan='5'>${year + 1}년 이월사업 계약매출 예상 합계</th>
								<td class="right sum">
									<fmt:formatNumber value="${collectioncashsum.expectedcollectioncashsum}" pattern="#,###"/> 원</td>
								<td class="sum"></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<th class="middle sum" colspan='5'>사업수금액 합계</th>
								<td class="right sum">
									<fmt:formatNumber value="${collectioncashsum.expectedcollectioncashsum}" pattern="#,###"/> 원</td>
								<td class="sum"></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tfoot>
			</table>
		</div>
	</form>
		
	<div class="btn-group">
		<a href="#this" class="btn btn-basic" id="listDetail">목록으로</a>
		<a href="#this" class="btn btn-black" id="deleteDetail">삭제</a>
		<a href="#this" class="btn btn-lightblue" id="updateDetail">수정</a>
	</div>
		
	
		
<%@ include file="/WEB-INF/include/body.jsp" %>
	</div>
</div>
<%@ include file="/WEB-INF/include/footer.jsp" %>