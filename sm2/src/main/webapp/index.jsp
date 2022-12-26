<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
</html>

<%-- <body>
	<h3>연도 선택</h3>
	
	<div id="yearDiv">
		<p>
			<input type="hidden" id="year" name="year_2021">2021년
			<a href="#this" class="btn" id="delete" name="delete">연도 삭제</a>
		</p>
	</div>
	
	<a href="#this" class="btn" id="addYear">연도 추가</a>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		var year_count = 2021;
	
		$(document).ready(function(){
			$("#addYear").on("click", function(e){ //연도 추가 버튼
				e.preventDefault();
				fn_addYear();
			});
			
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteYear($(this));
			});
		});
		
		function fn_addYear(){
			var str = "<p><input type='hidden' name='year_" + (++year_count) + "'>" + year_count + "년 <a href='#this' class='btn' name='delete'>연도 삭제</a></p>";
			$("#yearDiv").append(str);
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteYear($(this));
			});
		}
		
		function fn_deleteYear(obj){
			obj.parent().remove();
		}
	</script>
	
</body>
</html>

<jsp:forward page="/sm2/openSm2List.do"/> --%>