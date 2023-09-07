<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script>
function loginValidate(frm){
	// 아이디 입력 확인
	if(frm.user_id.value==''){
		alert("아이디를 입력해주세요.");
		frm.user_id.focus();
		return false;
	}
	// 패스워드 입력 확인
	if(frm.user_pw.value==''){
        alert("패스워드를 입력해주세요.");
        frm.user_pw.focus();
        return false;
    }
}
</script>
 <body>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" style="margin-left:140px;" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
				</div>
<%
// 로그아웃 상태에서는 로그인폼을 출력
if (session.getAttribute("UserId") == null) { 
%>
				<div class="login_box01">
					<img src="../images/login_tit.gif" style="margin-bottom:30px;" />
					<!-- 회원정보는 보안이 필요하므로 반드시 post방식으로 전송해야한다. -->
    				<form name="loginFrm" method="post" action="loginProcess.jsp" onsubmit="return loginValidate(this);">
					<ul style="padding-left: 0;">
						<li><img src="../images/login_tit001.gif" alt="아이디" style="margin-right:15px;" /><input type="text" name="user_id" value="" class="login_input01" /></li>
						<li><img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" /><input type="password" name="user_pw" value="" class="login_input01" /></li>
					</ul>
					<input type="image" src="../images/login_btn.gif" class="login_btn01" alt="확인">
					</form>
				</div>
				<p style="text-align:center; margin-bottom:30px;">
					<a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;
					<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a>
				</p>
<%
} else {  
// 로그인이 된 상태에서는 회원의 이름과 회원정보수정,로그아웃 버튼을 출력
%>
				<!-- 로그인 후 -->
				<div class="login_box01">
					<p style="font-size:14px;line-height:200%;padding:40px 0px 20px 10px"><span style="font-weight:bold; color:#333;">${ UserName }님,</span> 반갑습니다.<br />로그인 하셨습니다.</p>
				</div>
				<p style="text-align:center; margin-bottom:30px;">
					<a href=""><img src="../images/login_btn04.gif" /></a>
					<a href="logout.jsp"><img src="../images/login_btn05.gif" /></a>
				</p>
<%
}
%>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
 </body>
</html>