<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">

	<div class="cont_body">
	
	<form id="frm">
		<h2 class="cont_tit">${update.businessname} 수정</h2>
		<table class="tbl_basic tbl_view tbl_inp">
			<caption>${update.businessname} 수정</caption>
			<colgroup>
				<col style="width:15%;">
				<col style="width:35%;">
				<col style="width:15%;">
				<col style="width:35%;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">CODE</th>
					<td>${update.code}</td>
					<th scope="row">발주처</th>
					<td>${update.client}</td>
				</tr>
				<tr>
					<th scope="row">사업 완료 상태</th>
					<td>
						<c:choose>
							<c:when test="${update.monthbusinesscondition eq false}">
								<label class="red_txt">미완</label>
							</c:when>
							<c:otherwise>
								<label class="blue_txt">완료</a>
							</c:otherwise>
						</c:choose>
					</td>
					<th scope="row">매출금액(-)<br>(계약금액 * 지분율)</th>
					<td class="red_txt">
						<fmt:formatNumber value="${update.salesamount}" pattern="#,###"/> 원</td>
				</tr>
				<tr>
					<th scope="row">전체사업금액(+)</th>
					<td>
						<fmt:formatNumber value="${update.plustotalbusinessamount}" pattern="#,###"/> 원</td>
					<th scope="row">전체사업금액(-)<br>(계약금액)</th>
					<td class="red_txt">
						<fmt:formatNumber value="${update.minustotalbusinessamount}" pattern="#,###"/> 원</td>
				</tr>
				<tr>
					<th scope="row">수금잔여금액(-)</th>
					<td class="red_txt">
						<fmt:formatNumber value="${update.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
					<th scope="row">사업수금액</th>
					<td class="red_txt">
						<input class="red_txt collectioncash" type="text" id="UDCollectioncash" name="UDCollectioncash" value="${update.collectioncash}">&nbsp;원
					</td>
				</tr>
			</tbody>
		</table>
		
		<input type="hidden" name="idx" value="${update.idx}">
		<input type="hidden" name="monthidx" value="${update.monthidx}">
		
		<div class="btn-group">
			<button type="button" class="btn btn-basic" onclick="goForward()">이전으로</button>
			<a href="#this" class="btn btn-black" id="monthResetUpdate">리셋</a>
			<a href="#this" class="btn btn-lightblue" id="monthUpdateUpdate">수정</a>
			
		</div>
	</form>
	
		<script type="text/javascript">
			const input = document.querySelector('#UDCollectioncash');
			input.addEventListener('keyup', function(e){
				let value = e.target.value;
				value = Number(value.replaceAll(',', ''));
				if(isNaN(value)){
					input.value = 0;
				} else{
					const formatValue = value.toLocaleString('ko-KR');
					input.value = formatValue;
				}
			});
		</script>
	
</div>