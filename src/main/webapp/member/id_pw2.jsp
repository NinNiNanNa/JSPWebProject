<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/global_head.jsp" %>
<!-- 
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
	fn.submit();
}

$(function() {
	$('.closeBtn').click(function() {
		$('.idpw_result').hide();
	});
});
</script>
-->
<!-- 
<script>
$(function() {
	$('#idFindBtn').click(function() {
		//alert("클릭");
		//$('.id_result').show();
		let params = {
				idx:$().
		};
		$.post('id_pwProcess_update.jsp',
			params,
			function(rData) {
				console.log("콜백데이터", rData);
				$(userFindID).html();
				
			}
		);
	});
});
</script>
 -->
 
 <script>
 $(function() {
	 $('#idFindBtn').click(function() {
		//alert('fff');
		/*
		$.post(
			'./id_pwProcess_update.jsp',
			function(rData) {
				console.log(rData);
				
				//alert('가져오는듯??');
				//alert(rData.findID);
				//$('#userFindID').html(res.findID);
			}
		);
		*/
		console.log($("#fIDuser_name").val());
		console.log($("#fIDuser_email").val());
		$.ajax({
            url: "./id_pwProcess_update.jsp", // 목적지
            type: "POST", // HTTP Method
            data: $("#fIDuser_name").val(), // 전송 데이터
            dataType: 'json', // 전송 데이터 형식
            success: function(res){ // 성공 시 실행
				alert("성공?",res);
            },
            error:function(err){ //실패 시 실행
                alert("실패 원인 : " + err);
            }
        });
		
	 });
});
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
						<form name="idFindFrm" id="idFindFrm" method="post">
						<ul style="left:60px;">
							<li><input type="text" name="user_name" id="fIDuser_name" value="" class="login_input01" /></li>
							<li><input type="text" name="user_email" id="fIDuser_email" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:idFind();" id="idFindBtn" ><img src="../images/member/id_btn01.gif" class="id_btn" style="top:100px;" /></a>
						<a href="./join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
						</form>
					</div>
					<div class="pw_box">
						<form name="pwFindFrm" method="post">
						<ul style="left:60px;">
							<li><input type="text" name="user_id" value="" class="login_input01" /></li>
							<li><input type="text" name="user_name" value="" class="login_input01" /></li>
							<li><input type="text" name="user_email" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:pwFind();"><img src="../images/member/id_btn01.gif" class="pw_btn" style="top:105px;" /></a>
						</form>
					</div>
<%
if (pageContext.getAttribute("FindID") == null) {
%>
					<!-- 아이디 찾기 결과 화면 추가 -->
					<div class="idpw_result id_result">
						<h2>아이디 찾기</h2>
						<p>
							등록하신 아이디는 <span id="userFindID"></span> 입니다.
						</p>
						<img src="../images/btn01.gif" alt="확인" class="closeBtn" />
					</div>
<%
} else {
%>
					<div class="idpw_result id_result">
						<h2>아이디 찾기</h2>
						<p>
							등록하신 아이디는 없는 아이디 입니다.
						</p>
						<img src="../images/btn01.gif" alt="확인" class="closeBtn" />
					</div>
<%
}
%>

					
							
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
 </body>
</html>
