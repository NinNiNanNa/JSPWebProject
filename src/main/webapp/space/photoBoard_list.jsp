<%@page import="utils.BoardPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
<%@ include file="../include/TopTitleCommon.jsp" %>
<%@ include file="./ListCommon.jsp" %>
<%
//System.out.println("(listBoard_list.jsp)boardType=" + boardType);
%>
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
					<img src="../images/space/<%= imgPath %>" alt="<%= secondTitle %>" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%= secondTitle %><p>
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
						<ul class="clearfix" style="padding:0;width:100%;">
<%
//컬렉션에 입력된 데이터가 없는지 확인한다. 
if (boardLists.isEmpty()) {
%>
							<li>등록된 게시물이 없음</li>
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
						
							<li style="float:left;width:25%;padding-bottom:15px;">
								<div style="margin:0 8px;">
									<a href="listBoard_view.jsp?boardType=<%= boardType %>&idx=<%= dto.getIdx() %>" style="text-decoration:none;">
										<img style="width:100%;height:137px;object-fit:cover;" src="../Uploads/<%= dto.getSfile() %>" alt="<%= dto.getOfile() %>" />
										<span style="display:block;padding-top:5px;text-decoration:none;overflow:hidden;text-overflow:ellipsis; white-space:nowrap;font-size:18px;font-weight:bold;"><%= dto.getTitle() %></span>
										<span style="display:block;font-size:15px;padding:2px 0;"><%= dto.getId() %></span>
										<span style="display:block;font-size:15px;"><%= dto.getPostdate() %></span>
									</a>
								</div>
							</li>
<%
    }
}
%>
						</ul>
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
if(session.getAttribute("UserId")!= null && session.getAttribute("Account").equals("admin")){
%>
						<div class="button_wrap">
							<!-- 각종 버튼 부분 -->
							<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='listBoard_write.jsp?boardType=<%= boardType %>';">글쓰기</button>
						</div>
<%
} 
%>
<%
if(session.getAttribute("UserId")!= null && session.getAttribute("Account").equals("user") && boardType.equals("free")){
%>
	<div class="button_wrap">
		<!-- 각종 버튼 부분 -->
		<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='listBoard_write.jsp?boardType=<%= boardType %>';">글쓰기</button>
	</div>
<%
}
%>
<%
if(session.getAttribute("UserId")!= null && session.getAttribute("Account").equals("user") && boardType.equals("photo")){
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