<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// session영역에서 회원 아이디,이름,이메일 삭제
session.removeAttribute("UserId");
session.removeAttribute("UserName");
session.removeAttribute("UserEmail");

// 로그아웃 처리 후 로그인 페이지로 '이동' 한다.
response.sendRedirect("login.jsp");
%>