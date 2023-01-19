<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">
	
	<div class="cont_body">
<h2 class="cont_tit">사업 추가</h2>

<form id="frm">
	<table class="tbl_basic tbl_view tbl_inp">
		<caption>사업 추가</caption>
		<colgroup>
			<col style="width:10%;">
			<col style="width:80%;">
		</colgroup>
		<tbody>
			<tr>
				<th>코드선택</th>
				<td scope="row">
					<select id="CODE" name="CODE">
						<option value="" hidden>== 선택 ==</option>
						<option value="유지보수">유지보수</option>
						<option value="구축">구축</option>
						<option value="구독">구독</option>
						<option value="SI">SI</option>
						<option value="컨설팅">컨설팅</option>
						<option value="DB구축">DB구축</option>
						<option value="임대료">임대료</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th><label>사업명/사업개요</label></th>
				<td scope="row">
					<input type="text" id="businessname" name="businessname">
				</td>
			</tr>
			<tr>
				<th><label>발주처</label></th>
				<td scope="row">
					<input type="text" id="client" name="client">
				</td>
			</tr>
			<tr>
				<th><label>계약 기간</label></th>
				<td scope="row">
					<input type="date" id="strstartterm" name="strstartterm" max="9999-12-31"> ~
					<input type="date" id="strendterm" name="strendterm" max="9999-12-31">
					<!-- <input class="datepicker" name="strstartterm" required="required" autocomplete="off" readonly> ~ 
					<input class="datepicker" name="strendterm" required="required" autocomplete="off" readonly> -->
					
					<!-- <script>
						$.datepicker.setDefaults({
						  dateFormat: 'yy-mm-dd',
						  prevText: '이전 달',
						  nextText: '다음 달',
						  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
						  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
						  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
						  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
						  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
						  showMonthAfterYear: true,
						  yearSuffix: '년'
						});
					
						$(function(){
							$('.datepicker').datepicker();
						})
					</script> -->
					
				</td>
			</tr>
			<tr>
				<th><label>전체사업금액</label></th>
				<td scope="row">
					<input type="number" id="plustotalbusinessamount" name="plustotalbusinessamount" pattern="#,###">
				</td>
			</tr>
			<tr>
				<th><label>지분율</label></th>
				<td scope="row">
					<input type="number" id="ratio" name="ratio" min="0" max="100" step="0.01"> %
				</td>
			</tr>
		</tbody>
	</table>
	
	
	<div class="btn-group">
		<a href="#this" class="btn btn-basic" id="list">목록으로</a>
		<a href="#this" class="btn btn-black" id="insert">추가</a>
		<button type='reset' class="btn btn-lightblue">리셋</button>
	</div>
	
</form>

<%@ include file="/WEB-INF/include/body.jsp" %>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#list").on("click", function(e){
				e.preventDefault();
				if(!$('#CODE').val() && !$('#businessname').val() && !$('#client').val() && !$('#strstartterm').val() && !$('#strendterm').val() && !$('#plustotalbusinessamount').val() && !$('#ratio').val()){
					fn_openBoardList();
				} else{
					if(confirm('목록으로 돌아가시겠습니까?\n현재 입력한 정보는 모두 사라지게 됩니다.')){
						fn_openBoardList();
					} else{
						return false;
					}
				}
			});
			
			$("#insert").on("click", function(e){
				e.preventDefault();
				if(confirm('사업을 추가하시겠습니까?')){
					fn_insertBoard();
				} else{
					return false;
				}
			});
		});
		
		function fn_openBoardList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sm2/openSm2Main.do' />");
			comSubmit.submit();
		}
		
		function fn_insertBoard(){
			var comSubmit = new ComSubmit("frm");
			if(!$('#CODE').val()) {
				alert('코드를 선택해 주세요.');
			} else if(!$('#businessname').val()){
				alert('사업명/사업개요를 입력해주세요.');
			} else if(!$('#client').val()){
				alert('발주처를 입력해주세요.');
			} else if(!$('#strstartterm').val()){
				alert('시작 계약기간을 입력해주세요.');
			} else if(!$('#strendterm').val()){
				alert('완료 계약기간을 입력해주세요.');
			} else if(!$('#plustotalbusinessamount').val()){
				alert('전체사업금액을 입력해주세요.');
			} else if(!$('#ratio').val()){
				alert('지분율을 입력해주세요.');
			} else{
				comSubmit.setUrl("<c:url value='/sm2/insertSm2Board.do' />");
				comSubmit.submit();
			}
		}
		
		/* const input = document.querySelector('#plustotalbusinessamount');
		input.addEventListener('keyup', function(e) {
		  let value = e.target.value;
		  value = Number(value.replaceAll(',', ''));
		  if(isNaN(value)) {
		    input.value = 0;
		  }else {
		    const formatValue = value.toLocaleString('ko-KR');
		    input.value = formatValue;
		  }
		}) */
	</script>

</body>
</html>