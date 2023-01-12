<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">

	<div class="cont_body">

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
					<fmt:formatDate pattern="yy-MM-dd" value="${detail.startterm}"/> ~
					<fmt:formatDate pattern="yy/MM/dd" value="${detail.endterm}"/>
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
		<div class="btn-group">
			<button type="button" class="btn btn-basic" onclick="goForward()">목록으로</button>
			<form action="/sm2/deleteBoard.do" method="post">
				<input type="hidden" name="year" value="${date.year}">
				<input type="hidden" name="idx" value="${detail.idx}">
				<button type="submit" class="btn btn-black">삭제</button>
			</form>
		</div>
		
		<script type="text/javascript">
			function goForward() {
				history.go(-1);
			}
		</script>

	</div>
</div>