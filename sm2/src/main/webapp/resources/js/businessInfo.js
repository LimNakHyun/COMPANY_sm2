/**
 * @Class Name : businessInfo.js
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

//$(document).ready(function(){
	// 사업 등록
//	$(document).on("click", ".regist-btn", function(e){
//		e.preventDefault();
//		
//		chInfoAction("C");
//	});
	
	// 사업 목록 검색
//	$(document).on("click", "#srchCh", function(e){
//		getChInfoList();
//	});
//});

// 사업 목록 출력 및 사업 검색
function getBusinessList(){
	
	$(".dashboard_box").empty();
	$("#businessList").empty();
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
				'<div class="dashboard_item"><strong class="ds_tit">전체사업금액(+)</strong><span class="ds_num">' + data.amount.minustotalbusinessamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</span></div>' +
				'<div class="dashboard_item"><strong class="ds_tit">전체사업금액(+)</strong><span class="ds_num">' + data.amount.salesamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</span></div>' +
				'<div class="dashboard_item"><strong class="ds_tit">전체사업금액(+)</strong><span class="ds_num">' + data.amount.collectioncompletedamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</span></div>' +
				'<div class="dashboard_item"><strong class="ds_tit">전체사업금액(+)</strong><span class="ds_num">' + data.amount.totalcollectionremainingamountsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원</span></div>';
			$(".dashboard_box").append(blockSum);
			
			var tbody = "";
			$(data.list).each(function(i){
				var startDate = (data.list[i].startterm).substr(2, 2) + "/" + (data.list[i].startterm).substr(5, 2) + "/" + (data.list[i].startterm).substr(8, 2);
				var endDate = (data.list[i].endterm).substr(2, 2) + "/" + (data.list[i].endterm).substr(5, 2) + "/" + (data.list[i].endterm).substr(8, 2);
				tbody += '<tr>' +
					'<td><input type="checkbox" name="change" value="' + data.list[i].idx + '"></td>' +
					'<td>' + data.list[i].code + '</td>' +
					'<td>' + 
						'<a href="#this"  title="' + data.list[i].businessname + ' 상세보기" name="title">' + data.list[i].businessname + '</a>' +
						'<input type="hidden" id="idx" name="idx" value="' + data.list[i].idx + '">' +
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
			$("#businessList").append(tbody);
			
			var tfoot = "";
			tfoot += 
				'<tr>' +
					'<th colspan="5">사업금액 합계</th>' +
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