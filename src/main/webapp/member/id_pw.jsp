<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script>
function idFind(){
	var fn = document.idFindFrm
	// 회원이름 입력 확인
	if(fn.user_name.value==''){
		alert("회원이름을 입력해주세요.");
		fn.user_name.focus();
		return false;
	}
	// 이메일 입력 확인
	if(fn.user_email.value==''){
		alert("이메일을 입력해주세요.");
		fn.user_email.focus();
		return false;
	}
	fn.method = 'post';
	fn.action = './id_pwProcess.jsp';
	fn.submit();
}

function pwFind(){
	var fn = document.pwFindFrm
	// 회원이름 입력 확인
	if(fn.user_id.value==''){
		alert("아이디를 입력해주세요.");
		fn.user_id.focus();
		return false;
	}
	// 회원이름 입력 확인
	if(fn.user_name.value==''){
		alert("회원이름을 입력해주세요.");
		fn.user_name.focus();
		return false;
	}
	// 이메일 입력 확인
	if(fn.user_email.value==''){
		alert("이메일을 입력해주세요.");
		fn.user_email.focus();
		return false;
	}
	fn.method = 'post';
	fn.action = './id_pwProcess.jsp';
	fn.submit();
}
</script>
 <body>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" style="margin-left:140px;"/>

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box" style="position:relative;">
					<div class="id_box">
						<form name="idFindFrm">
						<ul style="left:60px;">
							<li><input type="text" name="user_name" value="" class="login_input01" /></li>
							<li><input type="text" name="user_email" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:idFind();" ><img src="../images/member/id_btn01.gif" class="id_btn" style="top:100px;" /></a>
						<a href="./join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
						</form>
					</div>
					<div class="pw_box">
						<form name="pwFindFrm">
						<ul style="left:60px;">
							<li><input type="text" name="user_id" value="" class="login_input01" /></li>
							<li><input type="text" name="user_name" value="" class="login_input01" /></li>
							<li><input type="text" name="user_email" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:pwFind();"><img src="../images/member/id_btn01.gif" class="pw_btn" style="top:105px;" /></a>
						</form>
					</div>			
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
 </body>
</html>
