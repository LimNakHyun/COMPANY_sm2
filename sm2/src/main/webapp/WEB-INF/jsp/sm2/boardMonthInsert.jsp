<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">
	
	<div class="cont_body">
	
		<h2 class="cont_tit">사업 추가</h2>
		
		<form id="frm">
			<table class="tbl_basic tbl_view tbl_inp">
				<caption>${month}월 사업 추가</caption>
				<colgroup>
					<col style="width:10%;">
					<col style="width:80%;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label>사업명/사업개요</label></th>
						<td>
							<select class="chzn-select" id="businessname" name="businessname" data-placeholder="사업 선택">
								<option value=""></option>
								<c:forEach items="${selectboxList}" var="boxlist" varStatus="status">
									<option value="${boxlist.businessname}">${boxlist.businessname}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label>사업수금액</label></th>
						<td>
							<input type="text" id="collectioncash" name="collectioncash" min="0">
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="btn-group">
				<a href="#this" class="btn btn-basic" id="list">목록으로</a>
				<a href="#this" class="btn btn-black" id="insert">추가</a>
			</div>
			
		</form>
		
<%@ include file="/WEB-INF/include/body.jsp" %>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#list").on("click", function(e){
				e.preventDefault();
				if(!$('#businessname').val() && !$('#collectioncash').val()){
					fn_openBoardList();
				} else{
					if(confirm('월별 사업 목록으로 돌아가시겠습니까?\n현재 입력한 정보는 모두 사라지게 됩니다.')){
						fn_openBoardList();
					} else{
						return false;
					}
				}
			});
			
			$("#insert").on("click", function(e){
				e.preventDefault();
				if(confirm('월별 사업을 추가하시겠습니까?')){
					fn_insertBoard();
				} else{
					return false;
				}
			});
		});
		
		$(".chzn-select").chosen({
			allow_single_deselect: true
		});
		
		function fn_openBoardList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/openSm2Month.do' />");
			comSubmit.submit();
		}
		
		function fn_insertBoard(){
			var comSubmit = new ComSubmit("frm");
			if(!$('#businessname').val()){
				alert('사업명/사업개요를 선택해주세요.');
			} else if(!$('#collectioncash').val()){
				alert('매출 금액을 입력해주세요.');
			} else{
				comSubmit.setUrl("<c:url value='/insertSm2BoardMonth.do' />");
				comSubmit.submit();
			}
		}
		
		const input = document.querySelector('#collectioncash');
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
</div>