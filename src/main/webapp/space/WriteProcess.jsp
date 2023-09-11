<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSP최상단에 인클루드 하여 로그인 정보가 없다면 즉시 로그인 페이지로 이동시킨다. -->
<%@ include file="../include/isLogin.jsp"%>  
<%
// 게시판 유형 파라미터 받기
String boardType = request.getParameter("boardType");
System.out.println("(WriteProcess.jsp)boardType:" + boardType);

// 폼값 받기
String title = request.getParameter("title");
String content = request.getParameter("content");

// 폼값 DTO객체에 저장
BoardDTO dto = new BoardDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setBoardType(boardType);

dto.setId(session.getAttribute("UserId").toString());

BoardDAO dao = new BoardDAO();

int isResult = dao.insertWrite(dto);

dao.close();

if (isResult == 1){	// 글쓰기에 성공하면
	// 목록으로 이동
	response.sendRedirect("./listBoard_list.jsp?boardType="+boardType);
}
else {	// 글쓰기에 실패하면
	JSFunction.alertBack("게시물 작성에 실패하였습니다.", out);
}
%>