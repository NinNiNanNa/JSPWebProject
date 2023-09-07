<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script>
function formValidate(frm){
	// 이름 입력 확인
	if(frm.name.value==''){
		alert("이름을 입력해주세요.");
		frm.name.focus();
		return false;
	}
	
	// 아이디 입력 확인
	if(frm.id.value==''){
		alert("아이디를 입력해주세요.");
		frm.id.focus();
		return false;
	}
	// 아이디는 4~12자이내
	if(!(frm.id.value.length>=4 && frm.id.value.length<=12)){
		alert("아이디는 4~12자 이내만 가능합니다.");
		frm.id.value = '';
		frm.id.focus();
		return false;
	}
	// 아이디는 숫자로 시작할 수 없음
	if(frm.id.value[0].charCodeAt(0)>=48 &&
            frm.id.value.charCodeAt(0)<=57){
        alert('아이디는 숫자로 시작할 수 없습니다.');
        frm.id.value = '';
        frm.id.focus();
        return false;
    }
	// 아이디는 영문+숫자의 조합으로만 사용
	for(var i=0 ; i<frm.id.value.length ; i++){
        if(!((frm.id.value[i]>='a' && frm.id.value[i]<='z') ||
            (frm.id.value[i]>='A' && frm.id.value[i]<='Z') ||
            (frm.id.value[i]>='0' && frm.id.value[i]<='9'))){
            alert("아이디는 영문 및 숫자의 조합만 가능합니다.");
            frm.id.value='';
            frm.id.focus();
            return false; 
        }
    }
	
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
        eval('document.joinFrm.'+ nextName).focus();
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

// 이메일 수신동의 체크시에 따라 value값 변경
function emailCheck(){
    
    const email_checkbox = document.getElementById('open_email');
	const checked = email_checkbox.checked;

	if(!(checked)){
		email_checkbox.value = "N";
		console.log(email_checkbox.value);
	}
	else{
		email_checkbox.value = "Y"
		console.log(email_checkbox.value);
	}
}

//아이디 중복확인 
function id_check_person(){
	const id = document.getElementById('id');
    if(id.value==''){
        alert("아이디를 입력후 중복확인 해주세요.");
        id.focus();
    }
    else{
        //아이디 중복확인 창을 띄울때 입력한 아이디를 쿼리스트링으로 
        //넘겨준다. 
        window.open('idOverlap.jsp?id='+id.value, 
            'idOver', 
            'width=500,height=300');
        //입력한 아이디를 수정할 수 없도록 속성을 추가한다. 
        id.readOnly = true;
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
            
            let frm = document.joinFrm;
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
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<form name="joinFrm" method="post" action="join02Process.jsp"  onsubmit="return formValidate(this);">
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" id="id" name="id"  value="" class="join_input" />&nbsp;<a onclick="id_check_person();" style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인"/></a>&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
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
							<input type="text" name="tel1" value="" maxlength="3" onkeyup="focusMove(this,'tel2',3);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" onkeyup="focusMove(this,'tel3',4);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" onkeyup="focusMove(this,'mobile1',4);" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" onkeyup="focusMove(this,'mobile2',3);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" onkeyup="focusMove(this,'mobile3',4);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
							<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
							<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
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
	 
							<input type="checkbox" id="open_email" name="open_email" onchange="emailCheck();" value="">
							<span>이메일 수신동의</span>
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zipcode" value=""  class="join_input" style="width:50px;" />
						
						<a href="javascript:;" title="새 창으로 열림" onclick="postOpen();">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
						
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