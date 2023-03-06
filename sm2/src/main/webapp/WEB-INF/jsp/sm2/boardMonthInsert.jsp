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
							<input type="text" id="dCollectioncash" name="dCollectioncash" min="0">
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="btn-group">
				<a href="#this" class="btn btn-basic" id="monthListInsert">목록으로</a>
				<a href="#this" class="btn btn-black" id="monthInsertInsert">추가</a>
			</div>
			
		</form>
		
<%@ include file="/WEB-INF/include/body.jsp" %>
	</div>
</div>

	<script type="text/javascript">
		// 월별 사업 등록 페이지 전체사업금액 숫자 콤마 추가
		const input = document.querySelector('#dCollectioncash');
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
<%@ include file="/WEB-INF/include/footer.jsp" %>