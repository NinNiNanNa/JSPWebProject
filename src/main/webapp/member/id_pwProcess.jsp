<%@page import="membership.MemberDTO"%>
<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userId = request.getParameter("user_id");
String userName = request.getParameter("user_name");
String userEmail = request.getParameter("user_email");

MemberDAO dao = new MemberDAO();

MemberDTO dto = dao.memberFindIdPW(userId, userName, userEmail);

dao.close();

if(userId != null){
	//System.out.println("찾은패스워드:"+ dto.getPass());
	if(dto.getPass() != null){
		out.println(dto.getPass());
	}
	else {
		out.println("존재하지않는 비밀번호");
	}
}
else{
	//System.out.println("찾은아이디:"+ dto.getId());
	if(dto.getId() != null){
		out.println(dto.getId());
	}
	else {
		out.println("존재하지않는 아이디");
	}
}
%>