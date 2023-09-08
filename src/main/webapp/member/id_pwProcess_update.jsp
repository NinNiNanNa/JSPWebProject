<%@page import="membership.MemberDTO"%>
<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String userId = request.getParameter("user_id");
String userName = request.getParameter("user_name");
String userEmail = request.getParameter("user_email");

MemberDAO dao = new MemberDAO();

MemberDTO dto = dao.memberFindIdPW(userId, userName, userEmail);

dao.close();

if(userId == null){
	pageContext.setAttribute("FindID", dto.getId());
	//out.println("찾은아이디:"+ dto.getId());
	String findID = dto.getId();
	
}
else{
	pageContext.setAttribute("FindPW", dto.getPass());
	//out.println("찾은패스워드:"+ dto.getPass());
	String findPW = dto.getPass();
}
%>