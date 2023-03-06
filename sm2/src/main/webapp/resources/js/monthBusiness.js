/**
 * @Class Name : monthBusiness.js
 * @Description : 사업 정보 js 
 * @
 * @   수정일     	수정자            	  수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2023.03.05     임낙현                  최초생성
 *
 * @author 재난안전DT팀 임낙현
 * @since 2023.03.05
 * @version 1.0
 * @see
 */

$(document).ready(function(){
	// 월별 사업 등록
	$("#monthInsert").on("click", function(e){
		e.preventDefault();
		fn_openBoardMonthInsert();
	});
	
	// 월별 사업 상세보기
	$("a[name='monthTitle']").on("click", function(e){
		e.preventDefault();
		fn_openBoardMonthDetail($(this));
	});
	
	// 월별 사업 상태 완료로변경
	$("a[name='monthConditionGo']").on("click", function(e){
		e.preventDefault();
		if(confirm('사업을 완료하시겠습니까?')){
			fn_switchMonthBusinessCondition($(this));
		} else{
			return false;
		}
	});
	
	// 월별 사업 상태 미완으로변경
	$("a[name='monthConditionBack']").on("click", function(e){
		e.preventDefault();
		if(confirm('사업을 미완 상태로 되돌리시겠습니까?')){
			fn_switchMonthBusinessCondition($(this));
		} else{
			return false;
		}
	});
	
	// 월별 사업 상세보기 페이지에서 월별사업목록으로 돌아가기
	$("#monthListDetail").on("click", function(e){
		e.preventDefault();
		fn_openBoardMonthListDetail();
	});
	
	// 월별 사업 삭제
	$("#monthDeleteDetail").on("click", function(e){
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')){
			fn_deleteBoardMonthDetail();
		} else{
			return false;
		}
	});
	
	// 월별 사업 추가 페이지에서 월별 사업 목록으로 이동
	$("#monthListInsert").on("click", function(e){
		e.preventDefault();
		if(!$('#businessname').val() && !$('#collectioncash').val()){
			fn_openBoardMonthListInsert();
		} else{
			if(confirm('월별 사업 목록으로 돌아가시겠습니까?\n현재 입력한 정보는 모두 사라지게 됩니다.')){
				fn_openBoardMonthListInsert();
			} else{
				return false;
			}
		}
	});

	// 월별 사업 추가
	$("#monthInsertInsert").on("click", function(e){
		e.preventDefault();
		if(confirm('월별 사업을 추가하시겠습니까?')){
			fn_insertBoardMonthInsert();
		} else{
			return false;
		}
	});
	
	// 월별 사업 수정
	$("#monthUpdateUpdate").on("click", function(e){
		e.preventDefault();
		if(confirm('월별 사업을 수정하시겠습니까?')){
			fn_updateBoardMonthUpdate();
		} else{
			return false;
		}
	});

	// 월별 사업 수정페이지 리셋
	$("#monthResetUpdate").on("click", function(e){
		e.preventDefault();
		if(confirm('리셋하시겠습니까?\n입력한 사업수금액 정보가 사라집니다.')) {
			fn_inputMonthResetUpdate();
		} else{
			return false;
		}
	});
	
	// 월별 사업 추가 페이지에서 사업명 검색기능 플러그인
	$(".chzn-select").chosen({
		allow_single_deselect: true
	});
});

//월별 사업 등록
function fn_openBoardMonthInsert(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/openSm2MonthInsert.do");
	comSubmit.submit();
}

//월별 사업 상세보기
function fn_openBoardMonthDetail(obj){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/openSm2MonthDetail.do");
	comSubmit.addParam("monthidx", obj.parent().find("#monthidx").val());
	comSubmit.submit();
}

//월별 사업 상태 변경
function fn_switchMonthBusinessCondition(obj){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/updateSm2MonthBusinessCondition.do");
	comSubmit.addParam("idx", obj.parent().find("#idx").val());
	comSubmit.addParam("monthidx", obj.parent().find("#monthidx").val());
	comSubmit.addParam("collectioncash", obj.parent().find("#collectioncash").val());
	comSubmit.addParam("monthbusinesscondition", obj.parent().find("#monthbusinesscondition").val());
	comSubmit.submit();
}

// 월별 사업 순서 변경
$(function(){
	$("#monthsortable").sortable();
	$("#monthsortable").disableSelection();
	
	$("#monthsortable").sortable({
		stop: function(){
			var dMonthChangeList = [];
			
			$('input:hidden[name=monthorderidx]').each(function (index){
				dMonthChangeList.push($(this).val());
			});
			
			console.log(dMonthChangeList);
			
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/switchBoardMonth.do");
			comSubmit.addParam("list", dMonthChangeList);
			comSubmit.submit();
		}
	});
});

// 월별 사업 상세보기 페이지에서 월별사업목록으로 돌아가기
function fn_openBoardMonthListDetail(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/openSm2Month.do");
	comSubmit.submit();
}

// 월별 사업 삭제
function fn_deleteBoardMonthDetail(){
	var comSubmit = new ComSubmit("frm");
	comSubmit.setUrl("/deleteBoardMonth.do");
	comSubmit.submit();
}

// 월별 사업 추가
function fn_insertBoardMonthInsert(){
	var comSubmit = new ComSubmit("frm");
	if(!$('#businessname').val()){
		alert('사업명/사업개요를 선택해주세요.');
	} else if(!$('#dCollectioncash').val()){
		alert('매출 금액을 입력해주세요.');
	} else{
		comSubmit.setUrl("/insertSm2BoardMonth.do");
		comSubmit.submit();
	}
}

// 월별 사업 추가 페이지에서 월별 사업 목록으로 이동
function fn_openBoardMonthListInsert(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("/openSm2Month.do");
	comSubmit.submit();
}

// 월별 사업 수정
function fn_updateBoardMonthUpdate() {
	var comSubmit = new ComSubmit("frm");
	
	if(!$('#UDCollectioncash').val()){
		alert('사업수금액을 입력해주세요.')
	} else if($('#UDCollectioncash').val() == "0"){
		alert('전체사업금액을 입력해주세요.');
	} else{
		comSubmit.setUrl("/updateBoardMonth.do");
		comSubmit.submit();
	}
}

// 월별 사업 수정 페이지 리셋
function fn_inputMonthResetUpdate(){
	document.getElementById("frm").reset();
}
