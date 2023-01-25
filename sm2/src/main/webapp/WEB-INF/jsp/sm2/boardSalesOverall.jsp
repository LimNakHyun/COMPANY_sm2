<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>

<div id="contents">

	<h2 class="cont_tit">${year}년 (주)이지스 사업 매출 현황 보고</h2>
	
	<c:set var="currentYMD" value="<%=new java.util.Date() %>" />

	<div class="cont_top">
		<div class="dashboard_box">
		
			<c:forEach items="${list}" var="dto" varStatus="idx">
				<c:choose>
					<c:when test="${dto.quarter ne null}">
						<div class="dashboard_item">
							<strong class="ds_tit" class="quarter">${dto.quarter} 실매출액</strong>
							<span class="ds_num" class="quarter"><fmt:formatNumber value="${dto.quarteramount}" pattern="#,###"/> 원</span>
						</div>
					</c:when>
				</c:choose>
			</c:forEach>
			
			<div class="dashboard_item">
				<c:forEach items="${list}" var="dto" varStatus="idx">
					<c:choose>
						<c:when test="${idx.index eq 16}">
							<strong class="ds_tit">${dto.all} (<fmt:formatDate value="${currentYMD}" pattern="yyyy년 MM월 dd일"/> 기준)</strong>
							<span class="ds_num"><fmt:formatNumber value="${dto.allamount}" pattern="#,###"/> 원</span>
						</c:when>
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</div>
	
	<div class="cont_body">
		<table style="width:49%; float:left;" class="tbl_basic tbl_view">
			<caption>${year}년 (주)이지스 사업 실매출 현황 보고</caption>
			<tr>
				<th colspan="3">실 매출 현황</th>
			</tr>
			<colgroup>
				<col style="width:4%;">
				<col style="width:5%;">
				<col style="width:40%;">
			</colgroup>
			<tbody>
			<c:forEach items="${list}" var="dto" varStatus="idx">
				<tr>
					<c:choose>
						<c:when test="${dto.monthstr ne null}">
							<c:if test="${(dto.month%3) eq 1}">
								<th rowspan="4"><fmt:formatNumber value="${(idx.index/4)+1}"/>/4 분기</th>
							</c:if>
							<th class="s_th">${dto.monthstr} 매출액</th>
							<td><fmt:formatNumber value="${dto.amount}" pattern="#,###"/> 원</td>
						</c:when>
						<c:when test="${dto.quarter ne null}">
							<th class="quarter">분기 매출액</th> <%-- ${dto.quarter} --%>
							<td class="quarter"><fmt:formatNumber value="${dto.quarteramount}" pattern="#,###"/> 원</td>
						</c:when>
					</c:choose>
				</tr>
			</c:forEach>
			</tbody>
			<tfoot>
				<tr>
				<c:forEach items="${list}" var="dto" varStatus="idx">
					<c:choose>
						<c:when test="${idx.index eq 16}">
							<th colspan="2">${dto.all}</th>
							<td><fmt:formatNumber value="${dto.allamount}" pattern="#,###"/> 원</td>
						</c:when>
					</c:choose>
				</c:forEach>
				</tr>
			</tfoot>
		</table>
		
		<table style="width:49%; float:right;" class="tbl_basic tbl_view">
			<caption>${year}년 (주)이지스 사업 예상매출 현황 보고</caption>
			<tr>
				<th colspan="3">예상 매출 현황</th>
			</tr>
			<colgroup>
				<col style="width:4%;">
				<col style="width:5%;">
				<col style="width:40%;">
			</colgroup>
			<tbody>
			<c:forEach items="${expectList}" var="dto" varStatus="idx">
				<tr>
					<c:choose>
						<c:when test="${dto.monthstr ne null}">
							<c:if test="${(dto.month%3) eq 1}">
								<th rowspan="4"><fmt:formatNumber value="${(idx.index/4)+1}"/>/4 분기</th>
							</c:if>
							<th class="s_th">${dto.monthstr} 매출액</th>
							<td><fmt:formatNumber value="${dto.amount}" pattern="#,###"/> 원</td>
						</c:when>
						<c:when test="${dto.quarter ne null}">
							<th class="quarter">분기 매출액</th> <%-- ${dto.quarter} --%>
							<td class="quarter"><fmt:formatNumber value="${dto.quarteramount}" pattern="#,###"/> 원</td>
						</c:when>
					</c:choose>
				</tr>
			</c:forEach>
			</tbody>
			<tfoot>
				<tr>
				<c:forEach items="${expectList}" var="dto" varStatus="idx">
					<c:choose>
						<c:when test="${idx.index eq 16}">
							<th colspan="2">${dto.all}</th>
							<td><fmt:formatNumber value="${dto.allamount}" pattern="#,###"/> 원</td>
						</c:when>
					</c:choose>
				</c:forEach>
				</tr>
			</tfoot>
		</table>
	</div>
</body>
</html>