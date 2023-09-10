<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/global_head.jsp" %>

<script>
$(function() {
	
	// 아이디 찾기
	$('#idFindBtn').click(function() {
		let name = $('#idFindFrm input[name=user_name]');
		let email = $('#idFindFrm input[name=user_email]');
		if(name.val() == ''){
			alert("이름을 입력해주세요.");
			name.focus();
		}
		else if(email.val() == ''){
			alert("이메일을 입력해주세요.");
			email.focus();
		}
		else{
			$('.id_result').show();
			
			$.ajax({
		    	url: "./id_pwProcess.jsp", // 목적지
	        	type: "POST", // HTTP Method
	        	data: $('#idFindFrm').serialize(), // 전송 데이터
	        	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        	dataType: 'html', // 전송 데이터 형식
	        	success: function(res){ // 성공 시 실행
	         		//console.log(res);
		          	$('#userFindID').html(res);
	          	},
	          	error:function(err){ //실패 시 실행
	            	alert("실패 원인 : " + err);
	          	}
	      	});
		}
	});

	// 비밀번호 찾기
	$('#pwFindBtn').click(function() {
		let id = $('#pwFindFrm input[name=user_id]');
		let name = $('#pwFindFrm input[name=user_name]');
		let email = $('#pwFindFrm input[name=user_email]');
		if(id.val() == ''){
			alert("아이디를 입력해주세요.");
			id.focus();
		}
		else if(name.val() == ''){
			alert("이름을 입력해주세요.");
			name.focus();
		}
		else if(email.val() == ''){
			alert("이메일을 입력해주세요.");
			email.focus();
		}
		else{
			$('.pw_result').show();
			$.ajax({
		    	url: "./id_pwProcess.jsp", // 목적지
	        	type: "POST", // HTTP Method
	        	data: $('#pwFindFrm').serialize(), // 전송 데이터
	        	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        	dataType: 'html', // 전송 데이터 형식
	        	success: function(res){ // 성공 시 실행
	         		//console.log(res);
		          	$('#userFindPW').html(res);
	          	},
	          	error:function(err){ //실패 시 실행
	            	alert("실패 원인 : " + err);
	          	}
	      	});
		}
	});
 
	// 결과창 닫기버튼
	$('.closeBtn').click(function() {
		$('.idpw_result').hide();
		$('.login_input01').val('');
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
						<form name="idFindFrm" id="idFindFrm">
						<ul style="left:60px;">
							<li><input type="text" name="user_name" value="" class="login_input01" /></li>
							<li><input type="text" name="user_email" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:idFind();" id="idFindBtn" ><img src="../images/member/id_btn01.gif" class="id_btn" style="top:100px;" /></a>
						<a href="./join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
						</form>
					</div>
					<div class="pw_box">
						<form name="pwFindFrm" id="pwFindFrm">
						<ul style="left:60px;">
							<li><input type="text" name="user_id" value="" class="login_input01" /></li>
							<li><input type="text" name="user_name" value="" class="login_input01" /></li>
							<li><input type="text" name="user_email" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:pwFind();" id="pwFindBtn" ><img src="../images/member/id_btn01.gif" class="pw_btn" style="top:105px;" /></a>
						</form>
					</div>
					<!-- 아이디 찾기 결과 화면 추가 -->
					<div class="idpw_result id_result">
						<h2>아이디 찾기</h2>
						<p>
							등록하신 아이디는 <span id="userFindID"></span> 입니다.
						</p>
						<img src="../images/btn01.gif" alt="확인" class="closeBtn" />
					</div>
					<!-- 비밀번호 찾기 결과 화면 추가 -->
					<div class="idpw_result pw_result">
						<h2>비밀번호 찾기</h2>
						<p>
							등록하신 비밀번호는 <span id="userFindPW"></span> 입니다.
						</p>
						<img src="../images/btn01.gif" alt="확인" class="closeBtn" />
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
 </body>
</html>
