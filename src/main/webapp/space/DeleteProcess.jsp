<%@page import="utils.FileUtil"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSP최상단에 인클루드 하여 로그인 정보가 없다면 즉시 로그인 페이지로 이동시킨다. -->
<%@ include file="../include/isLogin.jsp"%>  
<%
// 게시판 유형 파라미터 받기
String boardType = request.getParameter("boardType");
//System.out.println("(DeleteProcess.jsp)boardType:" + boardType);
// 일련번호를 폼값으로 받기
String idx = request.getParameter("idx");

BoardDTO dto = new BoardDTO();
BoardDAO dao = new BoardDAO();
// 본인 확인을 위해 기존 게시물을 인출
dto = dao.selectView(idx);

String sessionId = (String) session.getAttribute("UserId");

int delResult = 0;

//세션아이디와 게시물의 아이디가 일치하면 작성자 본인이므로...
if (sessionId.equals(dto.getId())){
	// 게시판 유형가져오기
	dto.getBoardType();
	// 게시물을 삭제한다.
	dto.setIdx(idx);
	//System.out.println("boardType:" + dto.getBoardType());
	delResult = dao.deletePost(dto);
	dao.close();
	
	if (delResult == 1){
		String saveFileName = dto.getSfile();
		FileUtil.deleteFile(request, "/Uploads", saveFileName);
		// 게시물이 삭제되면 목록으로 이동한다.
		JSFunction.alertLocation("게시물 삭제가 완료되었습니다.", "./listBoard_list.jsp?boardType="+dto.getBoardType(), out);
	}
	else {
		// 삭제에 실패하면 뒤로 이동한다.
		JSFunction.alertBack("게시물 삭제에 실패하였습니다.", out);
	}
}
else {
	// 작성자 본인이 아니면 삭제할 수 없다.
	JSFunction.alertBack("삭제할 권한이 없습니다.", out);
	return;
}
%>