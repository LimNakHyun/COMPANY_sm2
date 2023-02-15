<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

	<div id="contents">
		<h2 class="cont_tit">이지스 ${year}년 사업실적(매출세금계산서 기준)</h2>
	
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
		
		<div class="row ">
			<div class="col">
				<div class="search-box">
					<input type="text" id="searchword" name="searchword" placeholder="사업명" maxlength="100" autocomplete="off" onkeyup="JavaScript:getBusinessList();">
					<button type="button" id="srchCh" class="srch-btn"></button>
				</div>
			</div>
		</div>
		
		<div class="cont_body">
		
			<form id="frm">
				<table class="tbl_basic tbl_list">
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
					
					<tbody id="businessList"></tbody>
					
					<script type="text/javascript">
						$(document).ready(function(){
							$("#insert").on("click", function(e){
								e.preventDefault();
								fn_openBoardInsert();
							});
							
							/* $("a[name='title']").on("click", function(e){
								e.preventDefault();
								fn_openBoardDetail($(this));
							}); */
							
							$("#change").on("click", function(e){
								e.preventDefault();
								fn_changeBusiness($(this));
							});
							
							$("#searchbusiness").on("click", function(e){
								e.preventDefault();
								fn_searchbusiness($(this));
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
						
						function fn_searchbusiness(obj){
							var comSubmit = new ComSubmit();
							comSubmit.setUrl("<c:url value='searchbusinessSm2Board.do' />");
							comSubmit.addParam("searchword", obj.parent().find("#searchword").val());
							comSubmit.submit();
						}
					</script>
					
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

	<!-- <script type="text/javascript">
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
			
			$("#searchbusiness").on("click", function(e){
				e.preventDefault();
				fn_searchbusiness($(this));
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
		
		function fn_searchbusiness(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='searchbusinessSm2Board.do' />");
			comSubmit.addParam("searchword", obj.parent().find("#searchword").val());
			comSubmit.submit();
		}
	</script> -->

<%@ include file="/WEB-INF/include/footer.jsp" %>