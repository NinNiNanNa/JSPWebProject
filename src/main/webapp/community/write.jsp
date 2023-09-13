<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/TopTitleCommon.jsp" %>
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

		<img src="../images/community/sub_image.jpg" id="main_visual" />

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
				
					<form  name="writeFrm" method="post" action="../community/write.do?boardType=${ param.boardType }" enctype="multipart/form-data" onsubmit="return validateForm(this);">
					<input type="hidden" name="boardType" value="${ param.boardType }" />
					<table class="table table-bordered">
					<colgroup>
						<col width="20%"/>
						<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
							<th class="text-center" 
								style="vertical-align:middle;">작성자</th>
							<td>${ UserName }</td>
						</tr>
						<tr>
							<th class="text-center" 
								style="vertical-align:middle;">제목</th>
							<td>
								<input type="text" name="title" class="form-control" />
							</td>
						</tr>
						<tr>
							<th class="text-center" 
								style="vertical-align:middle;">내용</th>
							<td>
								<textarea rows="10" name="content" class="form-control"></textarea>
							</td>
						</tr>
						<tr>
							<th class="text-center" 
								style="vertical-align:middle;">첨부파일</th>
							<td>
								<input type="file" name="ofile" multiple="true"><br />
							</td>
						</tr>
					</tbody>
					</table>
					
					<div class="groupbutton_wrap" style="">
						<!-- 각종 버튼 부분 -->
						<button type="submit" class="btn btn-outline-success btn-sm">전송하기</button>
						<button type="reset" class="btn btn-outline-danger btn-sm">Reset</button>
						<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='../community/list.do?boardType=${ param.boardType }';">목록보기</button>
					</div>
					
					</form> 
								
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
 </body>
</html>
