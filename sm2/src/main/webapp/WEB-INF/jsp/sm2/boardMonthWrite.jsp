<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">
	
	<div class="cont_tit">
	
		<h2 class="cont_tit">사업 추가</h2>
		
		<form action="/sm2/insertSm2Month.do" method="post">
			<input type="hidden" name="month" value="${date.month}">
			<input type="hidden" name="year" value="${date.year}">
			<table class="tbl_basic tbl_view tbl_inp">
				<caption>${date.month}월 사업 추가</caption>
				<colgroup>
					<col style="width:10%;">
					<col style="width:80%;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label>사업 선택</label></th>
						<td>
							<select name="businessname" required>
								<option value="" hidden>사업 선택</option>
								<c:forEach items="${selectboxList}" var="boxlist" varStatus="status">
									<option value="${boxlist.businessname}">${boxlist.businessname}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label>매출금액(-)</label></th>
						<td>
							<input type="number" name="salesamount" required="required">
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn-group">
				<button type="submit" class="btn btn-basic">사업 추가</button>
			</div>
		</form>
	</div>
</div>