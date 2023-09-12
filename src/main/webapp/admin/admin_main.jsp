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
</style>
</head>
<body>
<center>

	<div id="wrap">
		<%@ include file="../include/top.jsp"%>

		<div class="main_contents" style="width:100%;height:600px;">
		
		게시판 작성은 기존꺼 쓸거임<br />
		[추가] 한화면에 다뿌릴예정 - 회원관리리스트, 블루클리닝 견적의뢰리스트, 체험학습신청리스트 필요
		<div class="row">
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
				<th class="text-center">번호</th>
				<th class="text-left">제목</th>
				<th class="text-center">작성자</th>
				<th class="text-center">작성일</th>
				<th class="text-center">조회수</th>
				<th class="text-center">첨부</th>
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
	
</center>
</body>
</html>