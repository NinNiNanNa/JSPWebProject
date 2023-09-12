<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSP최상단에 인클루드 하여 로그인 정보가 없다면 즉시 로그인 페이지로 이동시킨다. -->
<%@ include file="../include/isLogin.jsp"%>
<%@ include file="../include/TopTitleCommon.jsp" %>
<%
//System.out.println("(listBoard_edit.jsp)boardType:" + boardType);
// 수정할 게시물의 일련번호를 파라미터로 받아온다.
String idx = request.getParameter("idx");
// DAO객체 생성 및 DB연결
BoardDAO dao = new BoardDAO();
// 기존 게시물의 내용을 읽어온다.   
BoardDTO dto = dao.selectView(idx);
// 세션영역에 저장된 회원 아이디를 가져와서 문자열로 변환한다.
String sessionId = session.getAttribute("UserId").toString();
// 로그인한 회원이 해당 게시물의 작성자인지 확인한다.
if (!sessionId.equals(dto.getId())) {
	// 작성자가 아니라면 진입할 수 없도록 하고 뒤로 이동한다.
	JSFunction.alertBack("수정할 권한이 없습니다.", out);
	return;
}
/*
URL의 패턴을 파악하면 내가 작성한 게시물이 아니어도 얼마든지 수정페이지로 진입할 수 있다.
따라서 수정페이지 자체에서도 작성자 본인이 맞는지 확인하는 절차가 필요하다.
*/
dao.close();
%>
    
<%@ include file="../include/global_head.jsp" %>

<script type="text/javascript">
/* 글쓰기 페이지에서 제목과 내용이 입력되었는지 검증하는 JS코드 */
function validateForm(form) { 
    if (form.title.value == "") {
        alert("제목을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.content.value == "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
}
</script>
 <body>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" style="margin-left: 140px"/>

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/<%= imgPath %>" alt="<%= secondTitle %>" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%= secondTitle %><p>
				</div>
				<div>

				<form  name="writeFrm" method="post" action="./EditeProcess.jsp" enctype="multipart/form-data" onsubmit="return validateForm(this);">
				<!-- 게시판 유형을 구분해줌 -->
				<input type="hidden" name="boardType" value="<%= boardType %>" />
				<input type="hidden" name="idx" value="<%= dto.getIdx() %>" />
				<!-- 
				기존 등록된 파일명.
				만약 수정페이지에서 첨부파일을 변경하지 않는다면 여기에 등록된 파일명을 사용해서 update할 예정이다.
				 -->
				<input type="hidden" name="prevOfile" value="<%= dto.getOfile() %>" />
				<input type="hidden" name="prevSfile" value="<%= dto.getSfile() %>" />
				<table class="table table-bordered">
				<colgroup>
					<col width="20%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">작성자</th>
						<td><%= dto.getName() %></td>
					</tr>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">제목</th>
						<td>
							<input type="text" name="title" value="<%= dto.getTitle() %>" class="form-control" />
						</td>
					</tr>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">내용</th>
						<td>
							<textarea rows="10" name="content" class="form-control"><%= dto.getContent().replace("<br/>", "\n") %></textarea>
						</td>
					</tr>
<% if (boardType.equals("photo") || boardType.equals("info")) { %>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">첨부파일</th>
						<td>
							<input type="file" name="ofile" multiple="true"><br />
						</td>
					</tr>
<% } %>
				</tbody>
				</table>
				
<%
if(session.getAttribute("UserId")!= null && boardType.equals("photo")){
%>
				<div class="groupbutton_wrap" style="">
					<!-- 각종 버튼 부분 -->
					
					<button type="submit" class="btn btn-outline-success btn-sm">작성완료</button>
					<button type="reset" class="btn btn-outline-danger btn-sm">Reset</button>
					<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='photoBoard_list.jsp?boardType=<%= boardType %>';">목록보기</button>
				</div>
<% 
} else {
%>
				<div class="groupbutton_wrap" style="">
					<!-- 각종 버튼 부분 -->
					<button type="submit" class="btn btn-outline-success btn-sm">전송하기</button>
					<button type="reset" class="btn btn-outline-danger btn-sm">Reset</button>
					<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='listBoard_list.jsp?boardType=<%= boardType %>';">목록보기</button>
				</div>
<%
}
%>
				</form> 

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
 </body>
</html>