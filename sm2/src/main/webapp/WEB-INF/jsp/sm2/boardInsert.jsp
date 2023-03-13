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
					<input type="text" id="dPlustotalbusinessamount" name="dPlustotalbusinessamount">
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
		<a href="#this" class="btn btn-basic" id="listInsert">목록으로</a>
		<a href="#this" class="btn btn-black" id="insertInsert">추가</a>
		<a href="#this" class="btn btn-lightblue" id="resetInsert">리셋</a>
	</div>
	
</form>

<%@ include file="/WEB-INF/include/body.jsp" %>
	
	<script type="text/javascript">
	
		// 사업 등록 페이지 전체사업금액 숫자 콤마 추가
		const input = document.querySelector('#dPlustotalbusinessamount');
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