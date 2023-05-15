<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:if test="${result eq 'success'}">
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
							<a href="#this" class="noborder" name="detailTitle">
								<c:choose>
									<c:when test="${monthDetail.businessmonth eq 13}">
										[이월] ${monthDetail.businessname}
									</c:when>
									<c:otherwise>
										[${monthDetail.businessmonth}월] ${monthDetail.businessname}
									</c:otherwise>
								</c:choose>
							</a>
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
							<%-- <input type="hidden" id="monthidx" name="monthidx" value="${monthDetail.monthidx}"> --%>
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
					<tr>
						<th class="middle sum" colspan='2'>예상 사업수금액 합계</th>
						<td class="right sum">
							<fmt:formatNumber value="${expectcollectioncash.expectcollectioncash}" pattern="#,###"/> 원</td>
						<td class="sum"></td>
						<th class="middle sum" colspan='2'>실 사업수금액 합계</th>
						<td class="right sum">
							<fmt:formatNumber value="${realcollectioncash.realcollectioncash}" pattern="#,###"/> 원</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</c:if>