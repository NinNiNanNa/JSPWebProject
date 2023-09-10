<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSP최상단에 인클루드 하여 로그인 정보가 없다면 즉시 로그인 페이지로 이동시킨다. -->
<%@ include file="../include/isLogin.jsp"%>  
<%
// 게시판 유형 파라미터 받기
String boardType = request.getParameter("boardType");
//System.out.println("(EditeProcess.jsp)boardType:" + boardType);
// 일련번호를 폼값으로 받기
String idx = request.getParameter("idx");
String title = request.getParameter("title");
String content = request.getParameter("content");

BoardDTO dto = new BoardDTO();
dto.setIdx(idx);
dto.setTitle(title);
dto.setContent(content);

BoardDAO dao = new BoardDAO();
// 본인 확인을 위해 기존 게시물을 인출
int editResult = dao.updatePost(dto);

dao.close();

if (editResult == 1){
	// 게시물이 수정되면 목록으로 이동한다.
	JSFunction.alertLocation("게시물 수정이 완료되었습니다.", "./listBoard_view.jsp?boardType="+boardType+"&idx="+dto.getIdx(), out);
}
else {
	// 수정에 실패하면 뒤로 이동한다.
	JSFunction.alertBack("게시물 수정에 실패하였습니다.", out);
}
%>