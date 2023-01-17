<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>EGIS 매출 관리 시스템</title>
	<link href="${pageContext.request.contextPath}/resources/css/contents.css" rel="stylesheet" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common.js" charset="utf-8"></script>
</head>
<body>

	<c:set var="today" value="<%=new java.util.Date()%>" />
	<c:set var="year"><fmt:formatDate value="${today}" pattern="yyyy" /></c:set>

	<div id="wrapper">
		<div id="header">
			<h1 class="logo"><a href="/sm2/openSm2Index.do"><img class="egis_logo" src='${pageContext.request.contextPath}/resources/images/logo.svg'
				alt="이지스"></a></h1>
			<div class="box">
				<div class="menu_box">
					<ul>
						<li class="year_select">
							<form action="/sm2/openSm2List.do" name="yearFrm">
								<select name="year" class="select-basic" onchange="yearChange();">
									<c:forEach var="i" begin="2021" end="${year}" step="1">
										<option value="${i}" ${date.year eq i ? "selected" : ''}>${i}년</option>
									</c:forEach>
								</select>
							</form>
						</li>
						<li ${fn:contains(pageContext.request.requestURI, 'boardList') || fn:contains(pageContext.request.requestURI, 'boardDetail') || fn:contains(pageContext.request.requestURI, 'boardWrite') ? 'class="selected"' : ''}>
							<form action="/sm2/openSm2List.do" method="post">
								<input type="hidden" name="year" value="${date.year}">
								<button type="submit" class="btn btn-basic">매출 총괄현황</button>
							</form>
						</li>
						<li ${fn:contains(pageContext.request.requestURI, 'boardSalesOverall') ? 'class="selected"' : ''}>
							<form action="/sm2/openSm2SalesOverall.do">
								<input type="hidden" name="year" value="${date.year}">
								<button type="submit" class="btn btn-basic">총괄</button>
							</form>
						</li>
						<c:forEach var="j" begin="1" end="12">
							<li ${j eq month ? "class='selected'" : ''}>
							<form action="/sm2/openSm2Month.do" method="post">
								<input type="hidden" name="year" value="${date.year}">
								<input type="hidden" name="month" value="${j}">
								<button type="submit" class="btn btn-basic">${j}월</button>
							</form></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	
		<div id="container">