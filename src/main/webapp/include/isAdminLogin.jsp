<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if (session.getAttribute("UserId")==null && session.getAttribute("Account").equals("admin")) {
	JSFunction.alertBack("이용하실 수 있는 권한이 없습니다.", out);
	
	return;
}
%>