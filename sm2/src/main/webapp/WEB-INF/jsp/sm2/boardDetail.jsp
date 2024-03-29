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
	
	<div class="boardDetailRelatedBusiness"></div>
		
	<div class="btn-group">
		<a href="#this" class="btn btn-basic" id="listDetail">목록으로</a>
		<c:if test="${fn:contains(sessionScope.role, 'admin')}">
			<a href="#this" class="btn btn-black" id="deleteDetail">삭제</a>
			<a href="#this" class="btn btn-lightblue" id="updateDetail">수정</a>
		</c:if>
	</div>
	
	<script>
		getBoardDetailRelatedBusiness(${detail.idx});
	</script>
		
<%@ include file="/WEB-INF/include/body.jsp" %>
		
	
	</div>
</div>
<%@ include file="/WEB-INF/include/footer.jsp" %>