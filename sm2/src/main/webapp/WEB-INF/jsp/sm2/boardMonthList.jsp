<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>

<table>
	<c:forEach var="i" begin="0" end="3">
		<tr>
			<c:forEach var="j" begin="1" end="3">
				<td>
					<form action="/sm2/openSm2Month.do">
						<input type="hidden" name="month" value="<c:out value="${i * 3 + j}" />">
						<button><c:out value="${i * 3 + j}" />월</button>
					</form>
				</td>
			</c:forEach>
		</tr>
	</c:forEach>
</table>

</body>
</html>