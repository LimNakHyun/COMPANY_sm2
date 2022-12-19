<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>

<table>
	<tr>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="1">
				<button>1월</button>
			</form>
		</td>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="2">
				<button>2월</button>
			</form>
		</td>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="3">
				<button>3월</button>
			</form>
		</td>
	</tr>
	<tr>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="4">
				<button>4월</button>
			</form>
		</td>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="5">
				<button>5월</button>
			</form>
		</td>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="6">
				<button>6월</button>
			</form>
		</td>
	</tr>
	<tr>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="7">
				<button>7월</button>
			</form>
		</td>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="8">
				<button>8월</button>
			</form>
		</td>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="9">
				<button>9월</button>
			</form>
		</td>
	</tr>
	<tr>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="10">
				<button>10월</button>
			</form>
		</td>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="11">
				<button>11월</button>
			</form>
		</td>
		<td>
			<form action="monthForm" method="post">
				<input type="hidden" name="month" value="12">
				<button>12월</button>
			</form>
		</td>
	</tr>
</table>

</body>
</html>