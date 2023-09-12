<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
@import url("../css/admin_main.css");
</style>
<!-- 부트스트랩 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div id="wrap">
	<%@ include file="../include/top.jsp"%>

	<div class="main_contents">
	
	<h2 class="adminMain_title">회원관리</h2>
	<div class="">
		<!-- 게시판리스트부분 -->
		<table class="table table-bordered table-hover">
		<colgroup>
			<col width="80px"/>
			<col width="*"/>
			<col width="120px"/>
			<col width="120px"/>
			<col width="80px"/>
			<col width="50px"/>
		</colgroup>
		
		<thead>
		<tr class="success">
			<th class="text-center">아이디</th>
			<th class="text-left">비밀번호</th>
			<th class="text-center">이름</th>
			<th class="text-center">전화번호</th>
			<th class="text-center">휴대전화</th>
			<th class="text-center">이메일</th>
			<th class="text-center">이메일수신</th>
			<th class="text-center">우편번호</th>
			<th class="text-center">기본주소</th>
			<th class="text-center">상세주소</th>
			<th class="text-center">가입일</th>
			<th class="text-center">계정</th>
		</tr>
		</thead>
		
		<tbody>
		<!-- 리스트반복 -->
		<tr>
			<td class="text-center">번호</td>
			<td class="text-left"><a href="sub01_view.jsp">제목</a></td>
			<td class="text-center">작성자</td>
			<td class="text-center">작성일</td>
			<td class="text-center">조회수</td>
			<td class="text-center">첨부</td>
		</tr>
		</tbody>
		</table>
	</div> 
	
	</div>
		
	<%@ include file="../include/quick.jsp"%>
</div>

<%@ include file="../include/footer.jsp"%>
	
</body>
</html>