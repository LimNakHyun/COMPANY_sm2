<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

	<div id="contents">
		<div class="cont_tit" style="display: flex; justify-content: space-between;">
			<h2>이지스 ${year}년 사업실적(매출세금계산서 기준)</h2>
			<c:if test="${fn:contains(sessionScope.role, 'admin')}">
				<c:if test="${fn:contains(sessionScope.BizOrdChg, 'Y')}">
					<button type="submit" class="btn btn-red" id="board_business_order_change">사업 순서 변경 잠금</button>
				</c:if>
				<c:if test="${fn:contains(sessionScope.BizOrdChg, 'N')}">
					<button type="submit" class="btn btn-basic" id="board_business_order_change">사업 순서 변경</button>
				</c:if>
			</c:if>
		</div>

		<div class="cont_top">
			<div class="dashboard_box"></div>
			<div class="search_box">
				<select class="year_select_btn" id="searchtype" name="searchtype" onchange="JavaScript:getBusinessList();">
					<option value="all" selected>전체</option>
					<option value="CODE">CODE</option>
					<option value="businessname">사업명/사업개요</option>
					<option value="client">발주처</option>
				</select>
				<input class="search_item" type="text" id="searchword" name="searchword" placeholder="검색" maxlength="100" autocomplete="off" onkeyup="JavaScript:getBusinessList();">
				<div class="btn-group">
					<button id="search_reset">초기화</button>
				</div>
			</div>
		</div>
		
		<div class="cont_body">
			<form id="frm">
				<table class="tbl_basic tbl_list">
					<caption>이지스 ${year}년 사업실적(매출세금계산서 기준)</caption>
					<colgroup>
						<col style="width:5%;"><col style="width:21%;"><col style="width:9%;"><col style="width:9%;">
						<col style="width:9%;"><col style="width:9%;"><col style="width:4%;"><col style="width:9%;">
						<col style="width:9%;"><col style="width:9%;"><col style="width:4%;">
					</colgroup>
					<thead>
						<tr>
							<th>CODE</th><th>사업명/사업개요</th><th>발주처</th><th>계약기간<br></th>
							<th>전체사업금액(+)</th><th>전체사업금액(-)<br>(계약금액)</th><th>지분율</th>
							<th>매출금액(-)<br>(계약금액 * 지분율)</th><th>수금완료금액(-)</th><th>수금잔여금액(-)</th><th>비고</th>
						</tr>
					</thead>
					<c:choose>
						<c:when test="${fn:contains(sessionScope.BizOrdChg, 'Y')}">
							<tbody class="businessList" id="sortable"></tbody>
						</c:when>
						<c:when test="${fn:contains(sessionScope.BizOrdChg, 'N')}">
							<tbody class="businessList"></tbody>
						</c:when>
					</c:choose>
					<tfoot id="businessSum"></tfoot>
				</table>
				<c:if test="${fn:contains(sessionScope.role, 'admin')}">
					<div class="btn-group">
						<button type="submit" class="btn btn-basic" id="insert">사업 추가</button>
					</div>
				</c:if>
			</form>
		</div>
	</div>
	
	<script>
		getBusinessList()
	</script>
	
<!-- 	<script>
		$(document).ready(function(){
			$("a[name='title']").on("click", function(e){
				e.preventDefault();
				fn_openBoardDetail($(this));
			});
		});
		function fn_openBoardDetail(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/openSm2Detail.do");
			comSubmit.addParam("idx", obj.parent().find("#idx").val());
			comSubmit.submit();
		}
	</script> -->

<%@ include file="/WEB-INF/include/body.jsp" %>
<%@ include file="/WEB-INF/include/footer.jsp" %>