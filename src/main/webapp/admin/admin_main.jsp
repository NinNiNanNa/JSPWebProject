<%@page import="membership.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="membership.MemberDAO"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 회원관리
MemberDAO dao = new MemberDAO();
List<MemberDTO> users = dao.usersAccount();
dao.close();
%>
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
	
	<div id="main_visual" style="margin-left:140px">
	<a href="../product/sub01.jsp"><img src="../images/main_image_01.jpg" /></a><a href="../product/sub01_02.jsp"><img src="../images/main_image_02.jpg" /></a><a href="../product/sub01_03.jsp"><img src="../images/main_image_03.jpg" /></a><a href="../product/sub02.jsp"><img src="../images/main_image_04.jpg" /></a>
	</div>

	<div class="main_contents">
	
	<h2 class="adminMain_title">회원관리</h2>
	<div class="">
		<!-- 게시판리스트부분 -->
		<table class="table table-bordered table-hover">
		<colgroup>
			<col width="100px"/>
			<col width="100px"/>
			<col width="100px"/>
			<col width="120px"/>
			<col width="120px"/>
			<col width="*"/>
			<col width="100px"/>
			<col width="100px"/>
		</colgroup>
		
		<thead>
		<tr class="success">
			<th class="text-center">아이디</th>
			<th class="text-center">비밀번호</th>
			<th class="text-center">이름</th>
			<th class="text-center">전화번호</th>
			<th class="text-center">휴대전화</th>
			<th class="text-center">이메일</th>
			<th class="text-center">가입일</th>
			<th class="text-center">계정</th>
			<th class="text-center">권한</th>
		</tr>
		</thead>
		
		<tbody>
		<!-- 리스트반복 -->
<% for(MemberDTO dto : users){ %>
		<tr>
			<td class="text-center"><%= dto.getId() %></td>
			<td class="text-center"><%= dto.getPass() %></td>
			<td class="text-center"><%= dto.getName() %></td>
			<td class="text-center"><%= dto.getTel() %></td>
			<td class="text-center"><%= dto.getMobile() %></td>
			<td class="text-center"><%= dto.getEmail() %></td>
			<td class="text-center"><%= dto.getRegidate() %></td>
			<td class="text-center"><%= dto.getAccount() %></td>
			<td class="text-center">
				<input type="checkbox" id="account" name="account" onchange="" value="">
			</td>
		</tr>
<% } %>
		</tbody>
		</table>
		<div class="button_wrap" style="text-align:right;">
			<!-- 각종 버튼 부분 -->
			<button type="button" class="btn btn-outline-secondary btn-sm">변경</button>
		</div>
	</div> 
	
	</div>
		
	<%@ include file="../include/quick.jsp"%>
</div>

<%@ include file="../include/footer.jsp"%>
	
</body>
</html>