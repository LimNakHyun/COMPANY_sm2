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
			<tbody>
				<tr>
					<th scope="row">CODE</th>
					<td>${detail.code}</td>
					<th scope="row">발주처</th>
					<td>${detail.client}</td>
				</tr>
				<tr>
					<th scope="row">사업 완료 상태</th>
					<td>
						<c:choose>
							<c:when test="${detail.monthbusinesscondition eq false}">
								<label class="red_txt">미완</label>
							</c:when>
							<c:otherwise>
								<label class="blue_txt">완료</a>
							</c:otherwise>
						</c:choose>
					</td>
					<th scope="row">매출금액(-)<br>(계약금액 * 지분율)</th>
					<td class="red_txt">
						<fmt:formatNumber value="${detail.salesamount}" pattern="#,###"/> 원</td>
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
					<th scope="row">수금잔여금액(-)</th>
					<td class="red_txt">
						<fmt:formatNumber value="${detail.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
					<th scope="row">사업수금액</th>
					<td class="red_txt">
						<fmt:formatNumber value="${detail.collectioncash}" pattern="#,###"/> 원</td>
				</tr>
			</tbody>
		</table>
		
		<input type="hidden" name="month" value="${month}">
		<input type="hidden" name="year" value="${year}">
		<input type="hidden" name="collectioncash" value="${detail.collectioncash}">
		<input type="hidden" name="idx" value="${detail.idx}">
		<input type="hidden" name="monthidx" value="${detail.monthidx}">
		
		<div class="btn-group">
			<c:if test="${month != null}">
				<!-- <button type="button" class="btn btn-basic" onclick="goBack()">목록으로</button> -->
				<a href="#this" class="btn btn-basic" id="monthListDetail">목록으로</a>
				<a href="#this" class="btn btn-black" id="monthDeleteDetail">삭제</a>
				<a href="#this" class="btn btn-lightblue" id="monthUpdateDetail">수정</a>
			</c:if>
			
			<c:if test="${month eq null}">
				<!-- <a href="#this" class="btn btn-CornflowerBlue" name="title">사업으로</a> -->
				<button type="button" class="btn btn-CornflowerBlue" onclick="goBack()">사업으로</button>
			</c:if>
		</div>
	</form>
		
<%@ include file="/WEB-INF/include/body.jsp" %>

		<script type="text/javascript">
			$(document).ready(function(){
				// 월별 사업 상세보기 페이지에서 월별 사업 수정페이지로 이동
				$("#monthUpdateDetail").on("click", function(e){
					e.preventDefault();
					var condition = ${detail.monthbusinesscondition};
					/* console.log(condition); */
					if(!condition){
						fn_updateBoardMonthDetail();
					} else{
						alert('월별 사업 상태를 미완으로 바꿔주세요.');
					}
				});
			});
			
			// 월별 사업 상세보기 페이지에서 월별 사업 수정페이지로 이동
			function fn_updateBoardMonthDetail() {
				var comSubmit = new ComSubmit("frm");
				comSubmit.setUrl("<c:url value='/openSm2MonthUpdate.do' />");
				comSubmit.submit();
			}
		</script>
	</div>
</div>
<%@ include file="/WEB-INF/include/footer.jsp" %>