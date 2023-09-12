<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
    
<%@ include file="../include/TopTitleCommon.jsp" %>
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

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/community/sub01_title.gif" alt="직원자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;직원자료실<p>
				</div>
				<div>

				<form name="writeFrm">
				<input type="hidden" name="idx" value="${ dto.idx }" />
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
						<td>${ dto.name }</td>
						<th class="text-center" style="vertical-align:middle;">작성일</th>
						<td>${ dto.postdate }</td>
						<th class="text-center" style="vertical-align:middle;">조회수</th>
						<td class="text-center" >${ dto.visitcount }</td>
					</tr>
					<tr>
						<th class="text-center" style="vertical-align:middle;">제목</th>
						<td colspan="5">${ dto.title }</td>
					</tr>
					<tr>
						<th class="text-center" style="vertical-align:middle;">내용</th>
						<td colspan="5" style="height:300px;">
							<!-- 입력시 줄바꿈을 위한 엔터는 \r\n으로 입력되므로
							웹 브라우저에 출력시에는 <br>태그로 변경해야한다. -->
			                ${ dto.content }
							<c:if test="${ not empty dto.ofile and isImage eq true }">
							<br /><img width="70%" src="../Uploads/${ dto.sfile }" alt="" />
							</c:if>
						</td>
					</tr>
					<tr>
						<th class="text-center" style="vertical-align:middle;">첨부파일</th>
						<td colspan="3">
							<c:if test="${ not empty dto.ofile }">
							${ dto.ofile }
							<a href="../community/download.do?ofile=${ dto.ofile }&sfile=${ dto.sfile }&idx=${ dto.idx }">[다운로드]</a>
							</c:if>
						</td>
				        <th class="text-center" style="vertical-align:middle;">다운로드수</th>
				        <td class="text-center" >${ dto.downcount }</td>
					</tr>
				</tbody>
				</table>
				
				<div class="groupbutton_wrap" style="">
					<!-- 각종 버튼 부분 -->
					<button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='../community/edit.do?boardType=${ param.boardType }&idx=${ param.idx }';">수정하기</button>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="deletePost();">삭제하기</button>	
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