<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

	<div id="contents">
		<h2 class="cont_tit">이지스 ${year}년 사업실적(매출세금계산서 기준)</h2>
	
	<form id="frm">
		<div class="cont_top">
			<div class="dashboard_box">
				<div class="dashboard_item">
					<strong class="ds_tit">전체사업금액(+)</strong>
					<span class="ds_num"><fmt:formatNumber value="${amount.plustotalbusinessamountsum}" pattern="#,###"/> 원</span>
				</div>
				<div class="dashboard_item">
					<strong class="ds_tit">전체사업금액(-)<br>(계약금액)</strong>
					<span class="ds_num"><fmt:formatNumber value="${amount.minustotalbusinessamountsum}" pattern="#,###"/> 원</span>
				</div>
				<div class="dashboard_item">
					<strong class="ds_tit">매출금액(-)<br>∑(계약금액 * 지분율)</strong>
					<span class="ds_num"><fmt:formatNumber value="${amount.salesamountsum}" pattern="#,###"/> 원</span>
				</div>
				<div class="dashboard_item">
					<strong class="ds_tit">수금완료금액(-)</strong>
					<span class="ds_num"><fmt:formatNumber value="${amount.collectioncompletedamountsum}" pattern="#,###"/> 원</span>
				</div>
				<div class="dashboard_item">
					<strong class="ds_tit">수금잔여금액(-)</strong>
					<span class="ds_num"><fmt:formatNumber value="${amount.totalcollectionremainingamountsum}" pattern="#,###"/> 원</span>
				</div>
			</div>
		</div>
		
		<div class="cont_body">

			<table class="tbl_basic tbl_list" id="sortable">
				<caption>이지스 ${year}년 사업실적(매출세금계산서 기준)</caption>
				<colgroup>
					<col style="width:3%;">
					<col style="width:5%;">
					<col style="width:21%;">
					<col style="width:9%;">
					<col style="width:9%;">
					<col style="width:9%;">
					<col style="width:9%;">
					<col style="width:4%;">
					<col style="width:9%;">
					<col style="width:9%;">
					<col style="width:9%;">
					<col style="width:4%;">
				</colgroup>
				<thead>
					<tr>
						<th>
							<div class="btn-group btn-vmiddle">
								<button type="submit" class="btn btn-black middle change" name="change" id="change">교환</button>
							</div>
						</th>
						<th>CODE</th>
						<th>사업명/사업개요</th>
						<th>발주처</th>
						<th>계약기간<br></th>
						<th>전체사업금액(+)</th>
						<th>전체사업금액(-)<br>(계약금액)</th>
						<th>지분율</th>
						<th>매출금액(-)<br>(계약금액 * 지분율)</th>
						<th>수금완료금액(-)</th>
						<th>수금잔여금액(-)</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<td colspan="11">등록된 사업이 없습니다.</td>
					</c:if>
				<c:forEach items="${list}" var="dto" varStatus="status">
					<tr>
						<td><input type="checkbox" name="change" value="${dto.idx}"></td>
						<td>${dto.code}</td>
						<td>
							<a href="#this"  title="${dto.businessname} 상세보기" name="title">${dto.businessname}</a>
							<input type="hidden" id="idx" name="idx" value="${dto.idx}">
						</td>
						<td>${dto.client}</td>
						<td><fmt:formatDate pattern="yy/MM/dd" value="${dto.startterm}"/> ~ <fmt:formatDate pattern="yy/MM/dd" value="${dto.endterm}"/></td>
						<td><fmt:formatNumber value="${dto.plustotalbusinessamount}" pattern="#,###"/> 원</td>
						<td class="red_txt"><fmt:formatNumber value="${dto.minustotalbusinessamount}" pattern="#,###"/> 원</td>
						<td><fmt:formatNumber type="number" pattern="0.###" value="${dto.ratio}" />%</td>
						<td class="red_txt"><fmt:formatNumber value="${dto.salesamount}" pattern="#,###"/> 원</td>
						<td class="red_txt"><fmt:formatNumber value="${dto.collectioncompletedamount}" pattern="#,###"/> 원</td>
						<td class="red_txt"><fmt:formatNumber value="${dto.totalcollectionremainingamount}" pattern="#,###"/> 원</td>
						<td class="red_txt">
							<c:choose>
								<c:when test="${dto.businesscondition eq true}">
									<label class="blue_txt">완료</label>
								</c:when>
								<c:otherwise>
									<label class="red_txts">미완</label>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<th colspan='5'>사업금액 합계</th>
						<td><fmt:formatNumber value="${amount.plustotalbusinessamountsum}" pattern="#,###"/> 원</td>
						<td><fmt:formatNumber value="${amount.minustotalbusinessamountsum}" pattern="#,###"/> 원</td>
						<td>-</td>
						<td><fmt:formatNumber value="${amount.salesamountsum}" pattern="#,###"/> 원</td>
						<td><fmt:formatNumber value="${amount.collectioncompletedamountsum}" pattern="#,###"/> 원</td>
						<td><fmt:formatNumber value="${amount.totalcollectionremainingamountsum}" pattern="#,###"/> 원</td>
						<td>-</td>
					</tr>
				</tfoot>
			</table>
			<div class="btn-group">
				<button type="submit" class="btn btn-basic" id="insert">사업 추가</button>
			</div>
		</div>
	</form>
	</div>
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
		
		$("#change").on("click", function(e){
			e.preventDefault();
			fn_changeBusiness($(this));
		});
		
		$("#sortable tbody").sortable({
			update: function (event, ui) {
				$(this).children().each(function(index){
					$(this).find('td').first().html(index + 1);
				});
			}
		});
	});
	
	function fn_openBoardInsert(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/openSm2Insert.do' />");
		comSubmit.submit();
	}
	
	function fn_openBoardDetail(obj){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/openSm2Detail.do' />");
		comSubmit.addParam("idx", obj.parent().find("#idx").val());
		comSubmit.submit();
	}
	
	function fn_changeBusiness(obj){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='changeSm2Board.do' />");
		var changeList = [];
		
		$('input:checkbox[name=change]').each(function (index){
			if($(this).is(":checked") == true){
				changeList.push($(this).val());
				/* console.log($(this).val()); */
			}
		});
		
		/* console.log(changeList); */
		/* console.log(changeList.length); */
		if(changeList.length === 2) {
			comSubmit.addParam("list", changeList);
			comSubmit.submit();
		} else {
			if(confirm('순서교환은 2개의 사업을 선택해 주셔야합니다.\n선택한 사업을 리셋하시겠습니까?')) {
				document.getElementById("frm").reset();
			} else{
				return false;
			}
		}
	}
</script>


<%@ include file="/WEB-INF/include/footer.jsp" %>