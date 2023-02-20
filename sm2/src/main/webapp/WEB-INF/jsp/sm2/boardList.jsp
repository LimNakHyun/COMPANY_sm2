<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

	<div id="contents">
		<h2 class="cont_tit">이지스 ${year}년 사업실적(매출세금계산서 기준)</h2>
	
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
						<col style="width:3%;"><col style="width:5%;"><col style="width:21%;">
						<col style="width:9%;"><col style="width:9%;"><col style="width:9%;"><col style="width:9%;">
						<col style="width:4%;"><col style="width:9%;"><col style="width:9%;"><col style="width:9%;"><col style="width:4%;">
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
					<tbody id="businessList"></tbody>
					<tfoot id="businessSum"></tfoot>
				</table>
				<div class="btn-group">
					<button type="submit" class="btn btn-basic" id="insert">사업 추가</button>
				</div>
			</form>
		</div>
	</div>
	
	<script>
		getBusinessList()
	</script>
	
<%@ include file="/WEB-INF/include/body.jsp" %>

	<script type="text/javascript">
		$(document).ready(function(){
			$("#insert").on("click", function(e){
				e.preventDefault();
				fn_openBoardInsert();
			});
			
			$("#change").on("click", function(e){
				e.preventDefault();
				fn_changeBusiness($(this));
			});
			
			$("#search_reset").on("click", function(e){
				e.preventDefault();
				fn_searchBoxReset();
			});
		});
		
		$(document).on("click", "a[name='title']", function(e){
			e.preventDefault();
			fn_openBoardDetail($(this));
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
				}
			});
			
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
		
		function fn_searchBoxReset(){
			$("#searchword").val("");
			$('#searchtype option').prop('selected', false);
			getBusinessList();
		}
	</script>

<%@ include file="/WEB-INF/include/footer.jsp" %>