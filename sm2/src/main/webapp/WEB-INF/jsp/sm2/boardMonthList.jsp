<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>

<%-- <table class="type01">
	<c:forEach var="i" begin="0" end="3">
		<tr>
			<c:forEach var="j" begin="1" end="3">
				<td>
					<form action="/sm2/openSm2Month.do" method="post">
						<input type="hidden" name="month" value="<c:out value="${i * 3 + j}" />">
						<button><c:out value="${i * 3 + j}" />월</button>
					</form>
				</td>
			</c:forEach>
		</tr>
	</c:forEach>
</table> --%>
<br><br>
<div class="year">
	<select class="middle" name="year">
		<option value="none" hidden>== 연도 선택 ==</option>
		<option value="2021">2021년</option>
		<option value="2022">2022년</option>
		<option value="2023">2023년</option>
		<option value="2024">2024년</option>
	</select>
</div>
<br><br>

<div class="monthbtn">
	<c:forEach var="i" begin="0" end="3">
		<c:forEach var="j" begin="1" end="3">
			<form action="/sm2/openSm2Month.do" method="post">
				<input type="hidden" name="month" value="<c:out value="${i * 3 + j}" />">
				<button><c:out value="${i * 3 + j}" />월</button>
			</form>
		</c:forEach>
		<br><br>
	</c:forEach>
</div>

</body>
</html>