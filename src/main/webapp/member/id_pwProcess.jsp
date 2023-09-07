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

if(userId == null){
	MemberDTO dto = dao.memberFindIdPW(null, userName, userEmail);
	dao.close();

	if (dto.getId() != null) {
		JSFunction.alertLocation("등록하신 아이디는 " + dto.getId() + " 입니다.", "./login.jsp", out);
	} else {
		JSFunction.alertBack("등록된 아이디가 없습니다.", out);
	}
}
else{
	MemberDTO dto = dao.memberFindIdPW(userId, userName, userEmail);
	dao.close();

	if (dto.getPass() != null) {
		JSFunction.alertLocation("등록하신 비밀번호는 " + dto.getPass() + " 입니다.", "./login.jsp", out);
	} else {
		JSFunction.alertBack("등록된 비밀번호가 없습니다.", out);
	}
}
%>