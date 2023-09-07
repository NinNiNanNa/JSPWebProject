<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSP최상단에 인클루드 하여 로그인 정보가 없다면 즉시 로그인 페이지로 이동시킨다. -->
<%@ include file="../include/isLogin.jsp"%>  
<%
//로그인된 아이디 회원을 세션영역에서 가져오기
String userId = session.getAttribute("UserId").toString();
// 가입된 회원정보 불러오기
MemberDAO dao = new MemberDAO();
// 회원정보 불러오기 메소드 호출
MemberDTO dto = dao.memberInfo(userId);

String uname = dto.getName();
String uid = dto.getId();
String uOpen_email = dto.getOpen_email();
String uzipcode = dto.getZipcode();
String uarr1 = dto.getAddr1();
String uarr2 = dto.getAddr2();
// 전화번호, 핸드폰번호, 이메일 문자 나누기
String[] telArray = dto.getTel().split("-");
String[] mobileArray = dto.getMobile().split("-");
String[] emailArray = dto.getEmail().split("@");
%>

<%@ include file="../include/global_head.jsp" %>

<script>
function formValidate(frm){
	// 이름 입력 확인
	if(frm.name.value==''){
		alert("이름을 입력해주세요.");
		frm.name.focus();
		return false;
	}
	0
	// 패스워드 입력 확인
	if(frm.pass.value==''){
        alert("패스워드를 입력해주세요.");frm.pass.focus();return false;
    }
	// 패스워드는 4~12자 이내
	if(!(frm.pass.value.length>=4 && frm.pass.value.length<=12)){
		alert("패스워드는 4~12자 이내만 가능합니다.");
		frm.pass.value = '';
        frm.pass2.value = '';
		frm.pass.focus();
		return false;
	}
	// 패스워드 확인 입력 확인
    if(frm.pass2.value==''){
        alert("패스워드 확인을 입력해주세요.");frm.pass2.focus();return false;
    }
    // 입력한 패스워드가 일치하지 않는다면
    if(frm.pass.value!=frm.pass2.value){
        alert('패스워드가 일치하지 않습니다. 다시 입력해주세요.');
        //사용자가 입력한 패스워드를 지운다. 
        frm.pass.value = '';
        frm.pass2.value = '';
        //입력상자로 포커싱 한다. 
        frm.pass.focus();
        return false;
    }
}

/* thisObj 입력상자에 inputLen 길이의 텍스트를 입력하면 nextName 엘리먼트로 포커스를 이동시킨다. */ 
function focusMove(thisObj, nextName, inputLen){
    //입력한 문자의 길이
    var strLen = thisObj.value.length;
    //제한 길이가 넘어가는지 확인 
    if(strLen >= inputLen){
        eval('document.modifyFrm.'+ nextName).focus();
    }  
}

function email_input(frm){
	//이메일의 도메인을 선택한 경우의 value값 가져오기 
    var choiceDomain = frm.last_email_check2.value;
    if(choiceDomain==''){//--선택-- 부분을 선택한 경우..
        //입력한 모든 값을 지운다. 
        frm.email_1.value = '';
        frm.email_2.value = '';
        //아이디 입력란으로 포커싱한다.
        frm.email_1.focus();
    }
    else if(choiceDomain=='직접입력'){//직접입력을 선택한 경우..
        //기존에 입력된 값을 지운다.
        frm.email_2.value = '';
        //readonly 속성을 해제한다.
        frm.email_2.readOnly = false;
        //포커스를 이동한다. 
        frm.email_2.focus();
    }
    else{//포털 도메인을 선택한 경우..
        //선택한 도메인을 입력한다. 
        frm.email_2.value = choiceDomain;
        //입력된 값을 수정할 수 없도록 readonly속성을 추가한다. 
        frm.email_2.readOnly = true;
    }
}

//이메일 수신동의 체크시에 따라 value값 변경
function emailCheck(){
 
 const email_checkbox = document.getElementById('open_email');
	const checked = email_checkbox.checked;

	if(checked == true){
		email_checkbox.value = "Y"
		console.log(email_checkbox.value);
	}
	else if(checked == false){
		email_checkbox.value = "N";
		console.log(email_checkbox.value);
	}
}
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function postOpen(){    
    new daum.Postcode({
        oncomplete: function(data) {
            console.log(data);
            console.log(data.zonecode);
            console.log(data.address);
            
            let frm = document.modifyFrm;
            frm.zipcode.value = data.zonecode;
            frm.addr1.value = data.address;
            frm.addr2.focus();
        }
    }).open();
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
					<h2 style="font-size:27px;font-weight:bold;color:#C73C18;">회원정보수정</h2>
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원정보수정<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<form name="modifyFrm" method="post" action="modifyProcess.jsp"  onsubmit="return formValidate(this);">
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="<%= uname %>" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" id="id" name="id"  value="<%= uid %>" class="join_input"  readonly="readonly" style="outline:0;background:#eee;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="" class="join_input" /></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="<%= telArray[0] %>" maxlength="3" onkeyup="focusMove(this,'tel2',3);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="<%= telArray[1] %>" maxlength="4" onkeyup="focusMove(this,'tel3',4);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="<%= telArray[2] %>" maxlength="4" onkeyup="focusMove(this,'mobile1',4);" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="<%= mobileArray[0] %>" maxlength="3" onkeyup="focusMove(this,'mobile2',3);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="<%= mobileArray[1] %>" maxlength="4" onkeyup="focusMove(this,'mobile3',4);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="<%= mobileArray[2] %>" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
							<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="<%= emailArray[0] %>" /> @ 
							<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="<%= emailArray[1] %>" readonly />
							<select name="last_email_check2" onChange="email_input(this.form);" class="pass" id="last_email_check2" >
								<option selected="" value="">선택해주세요</option>
								<option value="1" >직접입력</option>
								<option value="dreamwiz.com" >dreamwiz.com</option>
								<option value="empal.com" >empal.com</option>
								<option value="empas.com" >empas.com</option>
								<option value="freechal.com" >freechal.com</option>
								<option value="hanafos.com" >hanafos.com</option>
								<option value="hanmail.net" >hanmail.net</option>
								<option value="hotmail.com" >hotmail.com</option>
								<option value="intizen.com" >intizen.com</option>
								<option value="korea.com" >korea.com</option>
								<option value="kornet.net" >kornet.net</option>
								<option value="msn.co.kr" >msn.co.kr</option>
								<option value="nate.com" >nate.com</option>
								<option value="naver.com" >naver.com</option>
								<option value="netian.com" >netian.com</option>
								<option value="orgio.co.kr" >orgio.co.kr</option>
								<option value="paran.com" >paran.com</option>
								<option value="sayclub.com" >sayclub.com</option>
								<option value="yahoo.co.kr" >yahoo.co.kr</option>
								<option value="yahoo.com" >yahoo.com</option>
							</select>
	 
							<input type="checkbox" id="open_email" name="open_email" onchange="emailCheck();" value="<%= uOpen_email %>">
							<span>이메일 수신동의</span>
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zipcode" value="<%= uzipcode %>"  class="join_input" style="width:50px;" />
						
						<a href="javascript:;" title="새 창으로 열림" onclick="postOpen();">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value="<%= uarr1 %>"  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value="<%= uarr2 %>"  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				</table>

				<p style="text-align:center; margin-bottom:20px">
					<input type="image" src="../images/btn01.gif" alt="확인">&nbsp;&nbsp;
					<a href="join01.jsp"><img src="../images/btn02.gif" alt="취소" /></a>
				</p>
				</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
 </body>
</html>
