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
//System.out.println("(EditeProcess.jsp)boardType:" + boardType);
// 일련번호를 폼값으로 받기
String idx = request.getParameter("idx");
String title = request.getParameter("title");
String content = request.getParameter("content");
/*
수정을 위해 hidden박스에 저장된 내용도 함께 받아온다.
게시물의 일련번호와 기존 등록된 파일명이 함께 전송된다.
*/
String prevOfile = request.getParameter("prevOfile");
String prevSfile = request.getParameter("prevSfile");

//1. 파일 업로드 처리 ======================================================================
//업로드 디렉토리의 물리적 경로 확인
String saveDiretory = application.getRealPath("/Uploads");
//파일 업로드
String originalFileName = "";
try {
	// 업로드가 정상적으로 완료되면 원본 파일명을 반환
	originalFileName = FileUtil.uploadFile(request, saveDiretory);
}
catch(Exception e){
	// 파일업로드시 오류가 발생되면 경고창을 띄운 후 작성페이지로 이동
	e.printStackTrace();
	JSFunction.alertBack("파일을 첨부하지 못했습니다.", out);
	return;
}

//2. 파일 업로드 외 처리 ======================================================================

BoardDTO dto = new BoardDTO();
dto.setIdx(idx);
dto.setTitle(title);
dto.setContent(content);

//원본 파일명과 저장된 파일 이름 설정
if (originalFileName != "") {
	   /*
	   수정페이지에서 새롭게 등록한 파일이 있다면 기존 내용을 수정해야한다.
	   파일명의 이름을 변경한 후 원본파일명과 저장된 파일명을 DTO에 저장한다.
	   */
	   String savedFileName = FileUtil.renameFile(saveDiretory, originalFileName);
	
	   dto.setOfile(originalFileName);	// 원래 파일 이름
	   dto.setSfile(savedFileName);		// 서버에 저장된 파일 이름
	   
	   // 기존 파일 삭제
	   FileUtil.deleteFile(request, "/Uploads", prevSfile);
}
else {
	   //첨부 파일이 없으면 기존 이름 유지
	   dto.setOfile(prevOfile);
	   dto.setSfile(prevSfile);
}

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