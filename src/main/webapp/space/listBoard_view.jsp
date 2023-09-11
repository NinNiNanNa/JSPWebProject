<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="./TopTitleCommon.jsp" %>

<%
//System.out.println("(listBoard_view.jsp)boardType=" + boardType);
/*
목록에서 제목을 클릭하면 게시물의 일련번호를 ?num=99와 같이 받아온다.
게시물 인출을 위해 파라미터를 받아온다.
*/
String idx = request.getParameter("idx");
//DAO객체 생성을 통해 오라클에 연결
BoardDAO dao = new BoardDAO();
//게시물의 조회수 증가
dao.updateVisitCount(idx);
//게시물의 내용을 인출하여 DTO에 저장
BoardDTO dto = dao.selectView(idx);
dao.close();
%>

<%@ include file="../include/global_head.jsp" %>


<script>
// 게시물 삭제를 위한 Javascript 함수
function deletePost() {
	// confirm() 함수는 대화창에서 '예'를 누를때 true가 반환된다.
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
    	// <form> 태그의 name속성을 통해 DOM을 얻어온다.
        var form = document.writeFrm;      
    	// 전송방식과 전송할 경로를 지정한다.
        form.method = "post"; 
        form.action = "./DeleteProcess.jsp"; 
        // submit() 함수를 통해 폼값을 전송한다.
        form.submit();         
        // <form>태그 하위의 hidden박스에 설정된 일련번호를 전송한다.
    }
}
</script>
 <body>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" style="margin-left:140px;"/>

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

				<form name="writeFrm">
				<input type="hidden" name="idx" value="<%= idx %>" />
				<table class="table table-bordered">
				<colgroup>
					<col width="15%"/>
					<col width="22.5%"/>
					<col width="15%"/>
					<col width="22.5%"/>
					<col width="15%"/>
					<col width="10%"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="text-center" style="vertical-align:middle;">작성자</th>
						<td><%= dto.getName() %></td>
						<th class="text-center" style="vertical-align:middle;">작성일</th>
						<td><%= dto.getPostdate() %></td>
						<th class="text-center" style="vertical-align:middle;">조회수</th>
						<td class="text-center" ><%= dto.getVisitcount() %></td>
					</tr>
					<tr>
						<th class="text-center" style="vertical-align:middle;">제목</th>
						<td colspan="5"><%= dto.getTitle() %></td>
					</tr>
					<tr>
						<th class="text-center" style="vertical-align:middle;">내용</th>
						<td colspan="5" style="height:300px;">
							<!-- 입력시 줄바꿈을 위한 엔터는 \r\n으로 입력되므로
							웹 브라우저에 출력시에는 <br>태그로 변경해야한다. -->
			                <%= dto.getContent() %>
						</td>
					</tr>
					<tr>
						<th class="text-center" style="vertical-align:middle;">첨부파일</th>
						<td colspan="3"><%= dto.getOfile() %></td>
					</tr>
				</tbody>
				</table>
<%
if(session.getAttribute("UserId")!= null && session.getAttribute("Account").equals("admin") && boardType.equals("notice")){
%>
				
				<div class="groupbutton_wrap" style="">
					<!-- 각종 버튼 부분 -->
					<button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='listBoard_edit.jsp?boardType=<%= boardType %>&idx=<%= dto.getIdx() %>';">수정하기</button>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="deletePost();">삭제하기</button>	
					<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='listBoard_list.jsp?boardType=<%= boardType %>';">목록보기</button>
				</div>
<%
} else if(session.getAttribute("UserId")!= null && session.getAttribute("Account")!=null && boardType.equals("free")){
%>
				<div class="groupbutton_wrap" style="">
					<!-- 각종 버튼 부분 -->
					<button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='listBoard_edit.jsp?boardType=<%= boardType %>&idx=<%= dto.getIdx() %>';">수정하기</button>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="deletePost();">삭제하기</button>	
					<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='listBoard_list.jsp?boardType=<%= boardType %>';">목록보기</button>
				</div>
<%	
} else {
%>
				<div class="groupbutton_wrap" style="">
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