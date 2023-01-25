<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">

	<div class="cont_body">
	
	<form id="frm">
		<h2 class="cont_tit">${update.businessname} 수정하기</h2>
		<table class="tbl_basic tbl_view tbl_inp">
			<caption>${update.businessname} 수정하기</caption>
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
						<input class="red_txt collectioncash" type="number" id="collectioncash" name="collectioncash" value="${update.collectioncash}">&nbsp;원
					</td>
				</tr>
			</tbody>
		</table>
		
		<input type="hidden" name="idx" value="${update.idx}">
		<input type="hidden" name="monthidx" value="${update.monthidx}">
		
		<div class="btn-group">
			<button type="button" class="btn btn-basic" onclick="goForward()">이전으로</button>
			<a href="#this" class="btn btn-black" id="reset">리셋</a>
			<a href="#this" class="btn btn-lightblue" id="update">수정</a>
			
		</div>
	</form>
	
		<script type="text/javascript">
			$(document).ready(function(){
				$("#update").on("click", function(e){
					e.preventDefault();
					if(confirm('월별 사업을 수정하시겠습니까?')){
						fn_updateBoard();
					} else{
						return false;
					}
				});
				
				$("#reset").on("click", function(e){
					e.preventDefault();
					if(confirm('리셋하시겠습니까?\n입력한 사업수금액 정보가 사라집니다.')) {
						fn_inputReset();
					} else{
						return false;
					}
				});
			});
			
			function fn_updateBoard() {
				var comSubmit = new ComSubmit("frm");
				var chkNum = /[0-9]*/;
				
				if(!$('#collectioncash').val()){
					alert('사업수금액을 입력해주세요.')
				}else if(!chkNum.test($('#collectioncash').val())){
					alert('사업수금액은 숫자만 입력이 가능합니다.');
				} else if($('#collectioncash').val() == "0"){
					alert('전체사업금액을 입력해주세요.');
				} else{
					comSubmit.setUrl("<c:url value='/sm2/updateBoardMonth.do' />");
					comSubmit.submit();
				}
			}
			
			function fn_inputReset(){
				document.getElementById("frm").reset();
			}
		</script>
	
</div>