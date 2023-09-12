<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String boardType = request.getParameter("boardType");
//System.out.println("(TopTitleCommon.jsp)boardType=" + boardType);
//System.out.println("나와라 주소! : " + request.getRequestURI());

String imgPath = "";
String secondTitle = "";

switch (boardType) {
	case "notice":
		imgPath = "sub01_title.gif";
		secondTitle = "공지사항";
	    break;
	case "program":
		imgPath = "sub02_title.gif";
		secondTitle = "프로그램일정";
	    break;
	case "free":
		imgPath = "sub03_title.gif";
		secondTitle = "자유게시판";
	    break;
	case "photo":
		imgPath = "sub04_title.gif";
		secondTitle = "사진게시판";
	    break;
	case "info":
		imgPath = "sub05_title.gif";
		secondTitle = "정보자료실";
	    break;
	case "empinfo":
		imgPath = "sub01_title.gif";
		secondTitle = "직원자료실";
	    break;
	case "guardian":
		imgPath = "sub02_title.gif";
		secondTitle = "보호자 게시판";
	    break;
}
%>