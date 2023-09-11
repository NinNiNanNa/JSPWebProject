<%@page import="board.BoardDAO"%>
<%@page import="utils.FileUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String ofile = request.getParameter("ofile");	// 원본 파일명
String sfile = request.getParameter("sfile");	// 저장된 파일명
String idx = request.getParameter("idx");		// 게시물 일련번호

// ※ getOutputStream() has already been called for this response 오류 해결 => out객체 초기화
out.clear();
pageContext.pushBody();
// 파일 다운로드
FileUtil.download(request, response, "/Uploads", sfile, ofile);

// 해당 게시물의 다운로드 수 1 증가
BoardDAO dao = new BoardDAO();
dao.downCountPlus(idx);
dao.close();
%>