<%@page import="utils.FileUtil"%>
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
//폼값 받기
String title = request.getParameter("title");
String content = request.getParameter("content");

// 1. 파일 업로드 처리 ======================================================================
// 업로드 디렉토리의 물리적 경로 확인
String saveDiretory = application.getRealPath("/Uploads");
// 파일 업로드
String originalFileName = "";
try {
	// 업로드가 정상적으로 완료되면 원본 파일명을 반환
	originalFileName = FileUtil.uploadFile(request, saveDiretory);
}
catch(Exception e){
	// 파일업로드시 오류가 발생되면 경고창을 띄운 후 작성페이지로 이동
	e.printStackTrace();
	JSFunction.alertLocation(response, "파일을 첨부하지 못했습니다.", "./listBoard_write.jsp?boardType="+boardType);
	return;
}

//2. 파일 업로드 외 처리 ======================================================================
// 폼값 DTO객체에 저장
BoardDTO dto = new BoardDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setBoardType(boardType);
// 세션영역에 저장된 회원아이디를 가져와서 저장
dto.setId(session.getAttribute("UserId").toString());

// 첨부파일이 정상적으로 등록되어 원본 파일명이 반환되었다면
if(originalFileName != ""){
	// 파일명을 "날짜_시간.확장자"형식으로 변경
	String savedFileName = FileUtil.renameFile(saveDiretory, originalFileName);
	// 원본과 변경된 파일명을 DTO에 저장
	dto.setOfile(originalFileName); // 원본 파일 이름
	dto.setSfile(savedFileName); 	// 서버에 저장된 파일 이름
}

BoardDAO dao = new BoardDAO();
int isResult = dao.insertWrite(dto);
dao.close();

if (isResult == 1){	// 글쓰기에 성공하면
	if(boardType.equals("photo")){
		JSFunction.alertLocation("게시물을 등록하였습니다.", "./photoBoard_list.jsp?boardType="+boardType, out);
	} else {
		JSFunction.alertLocation("게시물을 등록하였습니다.", "./listBoard_list.jsp?boardType="+boardType, out);
	}
}
else {	// 글쓰기에 실패하면
	JSFunction.alertBack("게시물 작성에 실패하였습니다.", out);
}
%>