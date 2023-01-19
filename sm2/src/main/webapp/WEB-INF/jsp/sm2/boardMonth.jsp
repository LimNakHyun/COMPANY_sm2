<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">

	<h2 class="cont_tit">${year}년 ${month}월</h2>
	
	<div class="cont_top">
		<div class="dashboard_box">
			<div class="dashboard_item">
				<strong class="ds_tit">${month}월 계약매출 합계</strong>
				<span class="ds_num"><fmt:formatNumber value="${collectioncashsum.collectioncashsum}" pattern="#,###"/> 원</span>
			</div>
		</div>
	</div>
	
	<div class="cont_body">
	
		<form id="frm">
			<table class="tbl_basic tbl_list">
				<caption>${year}년 ${month}월</caption>
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
							<input type="hidden" id="monthidx" name="monthidx" value="${dto.monthidx}">
							<a href="#this" class="noborder" name="title">${dto.businessname}</a>
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
							<input type="hidden" id="monthidx" name="monthidx" value="${dto.monthidx}">
							<input type="hidden" id="collectioncash" name="collectioncash" value="${dto.collectioncash}">
							<input type="hidden" id="monthbusinesscondition" name="monthbusinesscondition" value="${dto.monthbusinesscondition}">
							<c:choose>
								<c:when test="${dto.monthbusinesscondition eq false}">
									<a class="red_txt" href="#this" name="condition" title="사업 완료하기">미완</a>
								</c:when>
								<c:otherwise>
									<a class="blue_txt" href="#this" name="condition" title="사업 되돌리기">완료</a>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					
				</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<th class="middle sum" colspan='5'>${month}월 계약매출 예상 합계</th>
						<td class="right sum">
							<fmt:formatNumber value="${collectioncashsum.expectedcollectioncashsum}" pattern="#,###"/> 원</td>
						<td class="sum"></td>
					</tr>
				</tfoot>
			</table>
				<div class="btn-group">
					<button type="submit" class="btn btn-basic" id="insert">월별 사업 추가</button>
				</div>
		</form>
		
<%@ include file="/WEB-INF/include/body.jsp" %>

		<script type="text/javascript">
			$(document).ready(function(){
				$("#insert").on("click", function(e){
					e.preventDefault();
					fn_openBoardInsert();
				});
				
				$("a[name='title']").on("click", function(e){
					e.preventDefault();
					fn_openBoardDetail($(this));
				});
				
				$("a[name='condition']").on("click", function(e){
					e.preventDefault();
					if(confirm('사업을 완료하시겠습니까?')){
						fn_switchMonthBusinessCondition($(this));
					} else{
						return false;
					}
				})
			});
			
			function fn_openBoardInsert(){
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("<c:url value='/sm2/openSm2MonthInsert.do' />");
				comSubmit.submit();
			}
			
			function fn_openBoardDetail(obj){
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("<c:url value='/sm2/openSm2MonthDetail.do' />");
				comSubmit.addParam("monthidx", obj.parent().find("#monthidx").val());
				comSubmit.submit();
			}
			
			function fn_switchMonthBusinessCondition(obj){
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("<c:url value='/sm2/updateSm2MonthBusinessCondition.do' />");
				comSubmit.addParam("idx", obj.parent().find("#idx").val());
				comSubmit.addParam("monthidx", obj.parent().find("#monthidx").val());
				comSubmit.addParam("collectioncash", obj.parent().find("#collectioncash").val());
				comSubmit.addParam("monthbusinesscondition", obj.parent().find("#monthbusinesscondition").val());
				comSubmit.submit();
			}
		</script>
	</div>
</div>