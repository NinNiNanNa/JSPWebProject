<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파일이 저장될 폴더경로 받기
String sDirectory = application.getRealPath("./Uploads");
Part part = request.getPart("ofile");
String partHeader = part.getHeader("content-disposition");
System.out.println("partHeader="+ partHeader);
String[] phArr = partHeader.split("filename=");
String originalFileName = phArr[1].trim().replace("\"", "");
if (!originalFileName.isEmpty()) {				
	part.write(sDirectory+ File.separator +originalFileName);
}
%>
<img src="./Uploads/<%=originalFileName%>">