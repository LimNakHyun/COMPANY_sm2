<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

	<div id="contents">
	
		<c:choose>
			<c:when test="${month eq 13}">
				<h2 class="cont_tit">${year + 1}년 이월사업</h2>
			</c:when>
			<c:otherwise>
				<h2 class="cont_tit">${year}년 ${month}월</h2>
			</c:otherwise>
		</c:choose>
		
		<div class="cont_top">
			<div class="dashboard_box">
				<div class="dashboard_item">
					<c:choose>
						<c:when test="${month eq 13}">
							<strong class="ds_tit">${year + 1}년 이월사업 계약매출 합계</strong>
						</c:when>
						<c:otherwise>
							<strong class="ds_tit">${month}월 계약매출 합계</strong>
						</c:otherwise>
					</c:choose>
					<span class="ds_num"><fmt:formatNumber value="${collectioncashsum.collectioncashsum}" pattern="#,###"/> 원</span>
				</div>
			</div>
		</div>
		
		<div class="cont_body">
		
			<form id="frm">
				<table class="tbl_basic tbl_list">
					<caption>${year}년 ${month}월</caption>
					<colgroup>
						<col style="width:4%;"><col style="width:51%;"><col style="width:12%;"><col style="width:9%;">
						<col style="width:9%;"><col style="width:9%;"><col style="width:6%;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">CODE</th><th scope="col">사업명/사업개요</th><th scope="col">발주처</th><th scope="col">매출금액</th>
							<th scope="col">수금잔여금액(-)</th><th scope="col">사업수금액</th><th scope="col">수금완료하기</th>
						</tr>
					</thead>
					<tbody id="monthsortable">
					<c:if test="${empty list}">
						<td colspan="11">등록된 사업이 없습니다.</td>
					</c:if>
					<c:forEach items="${list}" var="dto" varStatus="status">
						
						<tr name="monthdragitem">
							<td class="middle">${dto.code}</td>
							<td class="middle">
								<a href="#this" class="noborder" name="monthTitle">${dto.businessname}</a>
								<input type="hidden" id="monthidx" name="monthidx" value="${dto.monthidx}">
							</td>
							<td class="middle">${dto.client}</td>
							<td class="right">
								<fmt:formatNumber value="${dto.salesamount}" pattern="#,###"/> 원</td>
							<td class="right">
								<fmt:formatNumber value="${dto.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
							<td class="right red_txt">
								<fmt:formatNumber value="${dto.collectioncash}" pattern="#,###"/> 원</td>
							<td class="middle">
								<input type="hidden" id="idx" name="idx" value="${dto.idx}">
								<input type="hidden" id="monthorderidx" name="monthorderidx" value="${dto.monthorderidx}">
								<input type="hidden" id="collectioncash" name="collectioncash" value="${dto.collectioncash}">
								<input type="hidden" id="monthbusinesscondition" name="monthbusinesscondition" value="${dto.monthbusinesscondition}">
								<c:choose>
									<c:when test="${dto.monthbusinesscondition eq false}">
										<a class="red_txt" href="#this" name="monthConditionGo" title="사업 완료하기">미완</a>
									</c:when>
									<c:otherwise>
										<a class="blue_txt" href="#this" name="monthConditionBack" title="사업 되돌리기">완료</a>
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
									<th class="middle sum" colspan='5'>${month}월 계약매출 예상 합계</th>
									<td class="right sum">
										<fmt:formatNumber value="${collectioncashsum.expectedcollectioncashsum}" pattern="#,###"/> 원</td>
									<td class="sum"></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tfoot>
				</table>
				<div class="btn-group">
					<button type="submit" class="btn btn-basic" id="monthInsert">월별 사업 추가</button>
				</div>
			</form>
		</div>
	</div>
		
<%@ include file="/WEB-INF/include/body.jsp" %>
<%@ include file="/WEB-INF/include/footer.jsp" %>