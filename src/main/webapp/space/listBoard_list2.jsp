<%@page import="utils.BoardPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String boardType = request.getParameter("boardType");
//System.out.println("(listBoard_list.jsp)boardType=" + boardType);
//System.out.println("나와라 주소! : " + request.getRequestURI());
%>
<%@ include file="./ListCommon.jsp" %>
<%@ include file="../include/global_head.jsp" %>


 <body>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" style="margin-left:140px;" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
				
<% if(boardType.equals("notice")) { %>				
					<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
<% } else if(boardType.equals("free")) { %>
					<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
<% } else if(boardType.equals("photo")) { %>
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
<% } %>	
					
					
				</div>
				<div>
	
					<div class="search_wrap">
						<!-- 검색부분 -->
						<form method="post">	
						<div class="select_wrap">
							<select name="keyField" class="">
								<option value="title">제목</option>
								<option value="content">내용</option>
								<option value="id">작성자</option>
							</select>
						</div>
						<div class="input_wrap">
							<input type="text" name="keyString"  class=""/>
							<div class="searchBtn_wrap">
								<input type="image" src="../images/space/search.png" />
							</div>
						</div>
						</form>	
					</div>
					<div class="">
						<!-- 게시판리스트부분 -->
						<table class="table table-bordered table-hover">
							<colgroup>
								<col width="80px"/>
								<col width="*"/>
								<col width="120px"/>
								<col width="120px"/>
								<col width="80px"/>
<% if(boardType.equals("photo")) { %>
								<col width="50px"/>
<% } %>
							</colgroup>
							<thead>
								<tr class="success">
									<th class="text-center">번호</th>
									<th class="text-center">제목</th>
									<th class="text-center">작성자</th>
									<th class="text-center">작성일</th>
									<th class="text-center">조회수</th>
<% if(boardType.equals("photo")) { %>	
									<th class="text-center">첨부</th>	
<% } %>
								</tr>
							</thead>
							<tbody>
<%
//컬렉션에 입력된 데이터가 없는지 확인한다. 
if (boardLists.isEmpty()) {
%>
								<tr>
						            <td colspan="6" align="center">
						                등록된 게시물이 없습니다^^*
						            </td>
						        </tr>
<%
} else {
	// 출력할 게시물이 있는 경우에는 확장 for문으로 List컬렉션에 저장된 레코드의 갯수만큼 반복하여 출력
    int virtualNum = 0;  
    int countNum = 0;  
    for (BoardDTO dto : boardLists)
    {
    	// 현재 출력할 게시물의 갯수에 따라 번호가 달라지게되므로 totalCount를 사용하여 가상번호를 부여
        //virtualNum = totalCount--;  
    	
    	virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
%>
								<!-- 리스트반복 -->
								<tr>
									<td class="text-center"><%= virtualNum %></td>
									<td class="text-left"><a style="text-decoration:none; display:inline-block;width:359;overflow:hidden; text-overflow:ellipsis; white-space:nowrap;" href="listBoard_view.jsp?boardType=<%= boardType %>&idx=<%= dto.getIdx() %>"><%= dto.getTitle() %></a></td>
									<td class="text-center"><%= dto.getId() %></td>
									<td class="text-center"><%= dto.getPostdate() %></td>
									<td class="text-center"><%= dto.getVisitcount() %></td>
<% if (dto.getOfile().isEmpty()) { %>
									<td class="text-center"><a href="">[Down]</a></td>
<% } %>
								</tr>
<%
    }
}
%>
							</tbody>
						</table>
					</div>
					<div class="bottom_wrap">
						<div class="pagenation_wrap">
							<!-- 페이지번호 부분 -->
							<ul>
								<%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, (request.getRequestURI() + "?boardType=" + boardType)) %>
								<!-- 
								<li><span class="glyphicon glyphicon-fast-backward"></span></li>
								<li><a href="#">1</a></li>		
								<li><a href="#" class="active">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>		
								<li><a href="#">5</a></li>
								<li><span class="glyphicon glyphicon-fast-forward"></span></li>
								 -->
							</ul>	
						</div>
<%
if(session.getAttribute("UserId")!= null && session.getAttribute("Account").equals("admin") && boardType.equals("notice")){
%>
						<div class="button_wrap">
							<!-- 각종 버튼 부분 -->
							<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='listBoard_write.jsp?boardType=<%= boardType %>';">글쓰기</button>
						</div>
<%
}else if(session.getAttribute("UserId")!= null && session.getAttribute("Account")!= null && boardType.equals("free")){
%>
	<div class="button_wrap">
		<!-- 각종 버튼 부분 -->
		<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='listBoard_write.jsp?boardType=<%= boardType %>';">글쓰기</button>
	</div>
<%
}
%>
						
					</div>
	
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
 </body>
</html>