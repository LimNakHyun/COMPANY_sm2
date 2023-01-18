<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">

	<div class="cont_body">
	<h2 class="cont_tit">${update.businessname} 수정하기</h2>

	<form action="/sm2/updateSm2Board.do" method="post">
		<table class="tbl_basic tbl_view tbl_inp">
			<caption>${update.businessname} 수정하기</caption>
			<colgroup>
				<col style="width:15%;">
				<col style="width:35%;">
				<col style="width:15%;">
				<col style="width:35%;">
			</colgroup>
			<tr>
				<th scope="row">CODE</th>
				<td>
					<select name="CODE" required>
						<option value="${update.code}" hidden>${update.code}</option>
						<option value="유지보수">유지보수</option>
						<option value="구축">구축</option>
						<option value="구독">구독</option>
						<option value="SI">SI</option>
						<option value="컨설팅">컨설팅</option>
						<option value="DB구축">DB구축</option>
					</select>
				</td>
				<th scope="row">계약기간</th>
				<td>
					<input type="date" name="strstartterm" required="required" value="${update.startterm}">&nbsp;~&nbsp;
					<input type="date" name="strendterm" required="required" value="${update.endterm}">
				</td>
			</tr>
			<tr>
				<th scope="row">사업명/사업개요</th>
				<td>
					<input type="text" name="businessname" required="required" value="${update.businessname}">
				</td>
				<th scope="row">발주처</th>
				<td>
					<input type="text" name="client" required="required" value="${update.client}">
				</td>
			</tr>
			<tr>
				<th scope="row">전체사업금액(+)</th>
				<td>
					<input
						type="number"
						class="plustotalbusinessamount"
						name="plustotalbusinessamount"
						value="${update.plustotalbusinessamount}"
						min="0"
						required="required"
						onkeyup="minustotalbusinessamountAutoCal();ratioAutoCal();"
					>&nbsp;원
				</td>
				<th scope="row">전체사업금액(-)<br>(계약금액)</th>
				<td class="red_txt">
					<input class="red_txt minustotalbusinessamount" type="number" name="minustotalbusinessamount" value="${update.minustotalbusinessamount}" readonly>&nbsp;원
				</td>
			</tr>
			<tr>
				<th scope="row">지분율</th>
				<td>
					<input
						type="number"
						class="ratio"
						name="ratio"
						value="${update.ratio}"
						min="0"
						max="100"
						step="0.01"
						required="required"
						onkeyup="ratioAutoCal();"
					>&nbsp;%
				</td>
				<th scope="row">매출금액(-)<br>(계약금액 * 지분율)</th>
				<td class="red_txt">
					<input class="red_txt" type="number" name="salesamount" value="${update.salesamount}" readonly>&nbsp;원
				</td>
			</tr>
			<tr>
				<th scope="row">수금잔여금액(-)</th>
				<td class="red_txt">
					<fmt:formatNumber value="${update.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
				<th scope="row">수금완료금액(-)</th>
				<td class="red_txt">
					<fmt:formatNumber value="${update.collectioncompletedamount}" pattern="#,###"/> 원</td>
			</tr>
		</table>
		<div class="btn-group">
			<button type="button" class="btn btn-basic" onclick="goForward()">이전으로</button>
			<input type="hidden" name="year" value="${date.year}">
			<input type="hidden" name="idx" value="${update.idx}">
			<a href="#this" class="btn btn-black" id="update">수정</a>
			<button type='reset' class="btn btn-lightblue">리셋</button>
		</div>
	</form>
		
		<script type="text/javascript">
			$(document).ready(function(){
				$("#list").on("click", function(e){
					e.preventDefault();
				})
			})
		
			function minustotalbusinessamountAutoCal() {
				var result = $('.plustotalbusinessamount').val() * 10000 / 11000;
				$('input[name="minustotalbusinessamount"]').val(result);
			}
			
			function ratioAutoCal() {
				var result = $('.minustotalbusinessamount').val() * $('.ratio').val() / 100;
				$('input[name="salesamount"]').val(result);
			}
		
			function goForward() {
				history.go(-1);
			}
		</script>
		
	</div>

</div>