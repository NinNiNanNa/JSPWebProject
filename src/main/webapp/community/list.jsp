<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/TopTitleCommon.jsp" %>
<%@ include file="../include/global_head.jsp" %>


 <body>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" style="margin-left:140px" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/community/<%= imgPath %>" alt="<%= secondTitle %>" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%= secondTitle %><p>
				</div>
				<div>
				
					<div class="search_wrap">
						<!-- 검색부분 -->
						<form method="get">	
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
					<div class="row">
						<!-- 게시판리스트부분 -->
						<table class="table table-bordered table-hover">
						<colgroup>
							<col width="80px"/>
							<col width="*"/>
							<col width="120px"/>
							<col width="120px"/>
							<col width="80px"/>
							<col width="50px"/>
						</colgroup>
						
						<thead>
						<tr class="success">
							<th class="text-center">번호</th>
							<th class="text-center">제목</th>
							<th class="text-center">작성자</th>
							<th class="text-center">작성일</th>
							<th class="text-center">조회수</th>
							<th class="text-center">첨부</th>
						</tr>
						</thead>
						
						<tbody>
						<!-- 리스트반복 -->
				<c:choose>
					<c:when test="${ empty boardLists }">
						<tr>
							<td colspan="6" align="center">
								등록된 게시물이 없습니다.
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${ boardLists }" var="row" varStatus="loop">
						<tr>
							<td class="text-center">
								${ map.totalCount - (((map.pageNum-1) * map.pageSize) + loop.index) }
							</td>
							<td class="text-left">
								<a href="../community/view.do?boardType=${ param.boardType }&idx=${ row.idx }">${ row.title }</a>
							</td>
							<td class="text-center">${ row.id }</td>
							<td class="text-center">${ row.postdate }</td>
							<td class="text-center">${ row.visitcount }</td>
							<td class="text-center">
							<c:if test="${ not empty row.ofile }">
				            	<a href="../community/download.do?boardType=${ param.boardType }&ofile=${ row.ofile }&sfile=${ row.sfile }&idx=${ row.idx }">
				            	<img width="20" src="../images/space/download.png" alt="" />
								</a>
				            </c:if>
							</td>
						</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
						</tbody>
						</table>
					</div>
					<div class="bottom_wrap">
						<div class="pagenation_wrap">
							<!-- 페이지번호 부분 -->
							<ul>
								${ map.pagingImg }
							</ul>	
						</div>
						
<% if (session.getAttribute("UserId")!= null && session.getAttribute("Account").equals("admin")) { %>
						<div class="button_wrap">
							<!-- 각종 버튼 부분 -->
							<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='../community/write.do?boardType=${ param.boardType }';">글쓰기</button>
						</div>
<% } %>						
<% if (session.getAttribute("UserId")!= null && session.getAttribute("Account").equals("user") && boardType.equals("guardian")) { %>
						<div class="button_wrap">
							<!-- 각종 버튼 부분 -->
							<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='../community/write.do?boardType=${ param.boardType }';">글쓰기</button>
						</div>
<% } %>
					</div>
				
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
 </body>
</html>
