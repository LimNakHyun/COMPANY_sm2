/**
 * @Class Name : business.js
 * @Description : 사업 정보 js 
 * @
 * @   수정일     	수정자            	  수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2023.02.14     임낙현                  최초생성
 *
 * @author 재난안전DT팀 임낙현
 * @since 2023.02.14
 * @version 1.0
 * @see
 */

$(document).ready(function(){
	// 사업 등록 페이지로 이동
	$("#insert").on("click", function(e){
		e.preventDefault();
		fn_openBoardInsert();
	});
	
	// 사업 동적 검색 리셋
	$("#search_reset").on("click", function(e){
		e.preventDefault();
		fn_searchBoxReset();
	});
	
	// 사업 상세보기
	$("a[name='title']").on("click", function(e){
		e.preventDefault();
		fn_openBoardDetail($(this));
	});

	// 사업 상세보기에서 사업목록으로 이동
	$("#listDetail").on("click", function(e){
		e.preventDefault();
		fn_openBoardListDetail();
	});
	
	// 사업 삭제
	$("#deleteDetail").on("click", function(e){
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')){
			fn_deleteBoardDetail();
		} else{
			return false;
		}
	});
	
	// 사업 수정 페이지로 이동
	$("#updateDetail").on("click", function(e){
		e.preventDefault();
		fn_updateBoardDetail();
	});

	// 사업 등록 페이지에서 사업목록으로 이동
	$("#listInsert").on("click", function(e){
		e.preventDefault();
		if(!$('#CODE').val() && !$('#businessname').val() && !$('#client').val() && !$('#strstartterm').val() && !$('#strendterm').val() && !$('#plustotalbusinessamount').val() && !$('#ratio').val()){
			fn_openBoardListInsert();
		} else{
			if(confirm('목록으로 돌아가시겠습니까?\n현재 입력한 정보는 모두 사라지게 됩니다.')){
				fn_openBoardListInsert();
			} else{
				return false;
			}
		}
	});
	
	// 사업 등록
	$("#insertInsert").on("click", function(e){
		e.preventDefault();
		if(confirm('사업을 추가하시겠습니까?')){
			fn_insertBoardInsert();
		} else{
			return false;
		}
	});
	
	// 사업 등록 페이지 리셋
	$("#resetInsert").on("click", function(e){
		e.preventDefault();
		if(!$('#CODE').val() && !$('#businessname').val() && !$('#client').val() && !$('#strstartterm').val() && !$('#strendterm').val() && !$('#plustotalbusinessamount').val() && !$('#ratio').val()){
			return false;
		} else{
			if(confirm('리셋하시겠습니까?\n입력한 모든 정보가 사라집니다.')) {
				fn_inputResetInsert();
			} else{
				return false;
			}
		}
	});
	
	// 사업 수정
	$("#updateUpdate").on("click", function(e){
		e.preventDefault();
		if(confirm('사업을 수정하시겠습니까?')){
			fn_updateBoardUpdate();
		} else{
			return false;
		}
	});
	
	// 사업 수정 페이지 리셋
	$("#resetUpdate").on("click", function(e){
		e.preventDefault();
		if(confirm('리셋하시겠습니까?\n입력한 모든 정보가 사라집니다.')) {
			fn_inputResetUpdate();
		} else{
			return false;
		}
	});

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
});

// 사업 등록 페이지로 이동
function fn_openBoardInsert(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/openSm2Insert.do");
	comSubmit.submit();
}

// 사업 동적 검색 리셋
function fn_searchBoxReset(){
	$("#searchword").val("");
	$('#searchtype option').prop('selected', false);
	getBusinessList();
}

// 사업 상세보기
function fn_openBoardDetail(obj){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/openSm2Detail.do");
	comSubmit.addParam("idx", obj.parent().find("#idx").val());
	comSubmit.submit();
}

// 사업 순서 변경
$(function(){
	$("#sortable").sortable();
	$("#sortable").disableSelection();
	
	$("#sortable").sortable({
		stop: function(){
			var dChangeList = [];
			$('input:hidden[name=orderidx]').each(function (index){
				dChangeList.push($(this).val());
			});
			
			console.log(dChangeList);
			
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/switchBoard.do");
			comSubmit.addParam("list", dChangeList);
			comSubmit.submit();
		}
	});
});

// 사업 목록 출력 및 사업 검색
function getBusinessList(){
	
	$(".dashboard_box").empty();
	$(".businessList").empty();
	$("#businessSum").empty();
	
	$.ajax({
		type: "POST",
		url: "/openSm2MainAjax.do",
		async: false,
		data: {
			searchtype : $("#searchtype").val(),
			searchword : $("#searchword").val()
		},
		dataType: "json",
		success: function(data){
			
			var blockSum = "";
			blockSum +=
				'<div class="dashboard_item"><strong class="ds_tit">전체사업금액(+)</strong><span class="ds_num">' + data.amount.plustotalbusinessamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</span></div>' +
				'<div class="dashboard_item"><strong class="ds_tit">전체사업금액(-)<br>(계약금액)</strong><span class="ds_num">' + data.amount.minustotalbusinessamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</span></div>' +
				'<div class="dashboard_item"><strong class="ds_tit">매출금액(-)<br>∑(계약금액 * 지분율)</strong><span class="ds_num">' + data.amount.salesamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</span></div>' +
				'<div class="dashboard_item"><strong class="ds_tit">수금완료금액(-)</strong><span class="ds_num">' + data.amount.collectioncompletedamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</span></div>' +
				'<div class="dashboard_item"><strong class="ds_tit">수금잔여금액(-)</strong><span class="ds_num">' + data.amount.totalcollectionremainingamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</span></div>';
			$(".dashboard_box").append(blockSum);
			
			var tbody = "";
			$(data.list).each(function(i){
				var startDate = (data.list[i].startterm).substr(2, 2) + "/" + (data.list[i].startterm).substr(5, 2) + "/" + (data.list[i].startterm).substr(8, 2);
				var endDate = (data.list[i].endterm).substr(2, 2) + "/" + (data.list[i].endterm).substr(5, 2) + "/" + (data.list[i].endterm).substr(8, 2);
				tbody += '<tr>' +
					'<td>' + data.list[i].code + '</td>' +
					'<td>' + 
						'<a href="#this"  title="' + data.list[i].businessname + ' 상세보기" name="title">' + data.list[i].businessname + '</a>' +
						'<input type="hidden" id="idx" name="idx" value="' + data.list[i].idx + '">' +
						'<input type="hidden" id="orderidx" name="orderidx" value="' + data.list[i].orderidx + '">' +
					'</td>' +
					'<td>' + data.list[i].client + '</td>' +
					'<td>' + startDate + ' ~ ' + endDate + '</td>' +
					'<td>' + data.list[i].plustotalbusinessamount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원 </td>' +
					'<td class="red_txt">' + data.list[i].minustotalbusinessamount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</td>' +
					'<td>' + data.list[i].ratio + '%</td>' +
					'<td class="red_txt">' + data.list[i].salesamount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</td>' +
					'<td class="red_txt">' + data.list[i].collectioncompletedamount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</td>' +
					'<td class="red_txt">' + data.list[i].totalcollectionremainingamount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</td>';
				if(data.list[i].totalcollectionremainingamount < 2) {
					tbody += '<td><label class="blue_txt">완료</label></td></tr>';
				} else {
					tbody += '<td><label class="red_txt">미완</label></td></tr>';
				}
			});
			$(".businessList").append(tbody);
			
			var tfoot = "";
			tfoot += 
				'<tr>' +
					'<th colspan="4">사업금액 합계</th>' +
					'<td>' + data.amount.plustotalbusinessamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</td>' +
					'<td>' + data.amount.minustotalbusinessamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</td>' +
					'<td>-</td>' +
					'<td>' + data.amount.salesamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</td>' +
					'<td>' + data.amount.collectioncompletedamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</td>' +
					'<td>' + data.amount.totalcollectionremainingamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</td>' +
					'<td>-</td>' +
				'</tr>';
			$("#businessSum").append(tfoot);
		},		
		error: function(request, status, error){
			console.log("사업 목록 가져오기 실패");
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
				
	});
}

// 사업 상세보기에서 사업목록으로 이동
function fn_openBoardListDetail(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/openSm2Main.do");
	comSubmit.submit();
}

// 사업 삭제
function fn_deleteBoardDetail(){
	var comSubmit = new ComSubmit("frm");
	comSubmit.setUrl("/deleteSm2Board.do");
	comSubmit.submit();
}

// 사업 수정 페이지로 이동
function fn_updateBoardDetail(){
	var comSubmit = new ComSubmit("frm");
	comSubmit.setUrl("/openSm2UpdateBoard.do");
	comSubmit.submit();
}

// 사업 등록 페이지에서 사업목록으로 이동
function fn_openBoardListInsert(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/openSm2Main.do");
	comSubmit.submit();
}

// 사업 등록
function fn_insertBoardInsert(){
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
	} else if(!$('#dPlustotalbusinessamount').val()){
		alert('전체사업금액을 입력해주세요.');
	} else if(!$('#ratio').val()){
		alert('지분율을 입력해주세요.');
	} else if($('#ratio').val() > 100){
		alert('지분율은 100%가 최대값입니다.');
	} else{
		comSubmit.setUrl("/insertSm2Board.do");
		comSubmit.submit();
	}
}

// 사업 등록페이지 리셋
function fn_inputResetInsert(){
	document.getElementById("frm").reset();
}

// 사업 수정
function fn_updateBoardUpdate() {
	var comSubmit = new ComSubmit("frm");
	var chkNum = /[0-9]*/;

	if(!$('#businessname').val()){
		alert('사업명/사업개요를 입력해주세요.');
	} else if(!$('#client').val()){
		alert('발주처를 입력해주세요.');
	} else if(!$('#strstartterm').val()){
		alert('시작 계약기간을 입력해주세요.');
	} else if(!$('#strendterm').val()){
		alert('완료 계약기간을 입력해주세요.');
	} else if(!chkNum.test($('#plustotalbusinessamount').val())){
		alert('전체사업금액은 숫자만 입력이 가능합니다.');
	} else if($('#plustotalbusinessamount').val() == "0"){
		alert('전체사업금액을 입력해주세요.');
	} else if(!$('#plustotalbusinessamount').val()){
		alert('전체사업금액을 입력해주세요.');
	} else if(!$('#ratio').val()){
		alert('지분율을 입력해주세요.');
	} else{
		comSubmit.setUrl("/updateSm2Board.do");
		comSubmit.submit();
	}
}

// 사업 수정 페이지 리셋
function fn_inputResetUpdate(){
	document.getElementById("frm").reset();
}