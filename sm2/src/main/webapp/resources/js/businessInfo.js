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

$(document).ready(function(){
	// 사업 등록
	$(document).on("click", ".regist-btn", function(e){
		e.preventDefault();
		
		chInfoAction("C");
	});
	
	// 사업 목록 검색
	$(document).on("click", "#srchCh", function(e){
		getChInfoList();
	});
});

// 사업 목록 출력
function getBusinessList(){
	
	$("#businessList").empty();
	
	$.ajax({
		type: "POST",
		url: "/openSm2MainAjax.do",
		async: false,
		data: { searchword : $("#searchword").val() },
		dataType: "json",
		success: function(data){
			var tbody = "";
			$(data.list).each(function(i){
//				console.log(typeof(data.list[i].startterm));
				tbody += '<tr>' +
					'<td><input type="checkbox" name="change" value="' + data.list[i].idx + '"></td>' +
					'<td>' + data.list[i].code + '</td>' +
					'<td>' + 
						'<a href="#this"  title="' + data.list[i].businessname + ' 상세보기" name="title">' + data.list[i].businessname + '</a>' +
						'<input type="hidden" id="idx" name="idx" value="' + data.list[i].idx + '">' +
					'</td>' +
					'<td>' + data.list[i].client + '</td>' +
					'<td>' + data.list[i].startterm + ' ~ ' + data.list[i].endterm + '</td>' +
					'<td>' + data.list[i].plustotalbusinessamount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' 원 </td>' + '</tr>';
//					results[i].idx + '</td><td>' +
//					results[i].code + '</td><td>' +
//					results[i].code + '</td><td>' +
//					results[i].code + '</td><td>' +
//					results[i].code + '</td><td>' +
//					results[i].code + '</td><td>' +
			});
			$("#businessList").append(tbody);
		},		
		error: function(request, status, error){
			console.log("사업 목록 가져오기 실패");
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
				
				
				/*<tbody>
					<c:forEach>
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
									<c:when test="${dto.totalcollectionremainingamount < 2}">
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
				</tfoot>*/
				
				
				
				
				
				
				
				
				

	});
}